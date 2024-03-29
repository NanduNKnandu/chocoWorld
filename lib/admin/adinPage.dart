import 'dart:io';
import 'package:elite_events/colorsss.dart';
import 'package:elite_events/textfielExtract.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import '../homescreen/category/categories.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  void initState() {
    // TODO: implement initState
    fetchBrands();
  }

  File? selectedImage;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemdescription = TextEditingController();
  final TextEditingController brand = TextEditingController();

  String selectedcatid = "";
  String brandSelect = '';
  List<String> brandsList = [];

  Future<void> fetchBrands() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('brand').get();


      brandsList.clear();


      querySnapshot.docs.forEach((DocumentSnapshot document) {
        String brandName = document['brandName'];
        if (!brandsList.contains(brandName)) {


          brandsList.add(
              brandName);
        }//
      });
      print("Brands List: $brandsList");

      setState(() {});
    } catch (error) {

      print("Error fetching brands: $error");
    }
  }

  void brandpick(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<String>(pickerData: brandsList),
      hideHeader: true,
      title: Text("Select Brand"),
      onConfirm: (Picker picker, List<int> selecteds) {
        setState(() {
          brandSelect = brandsList[selecteds.first];
        });
      },
    ).showDialog(context);
  }

  void categorypick(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerData: categoriesList),
        hideHeader: true,
        title: Text(" select category id"),
        onConfirm: (Picker picker, List<int> selecteds) {
          setState(() {
            selectedcatid = categoriesList[selecteds.first];
          });
        }).showDialog(context);
  }

  Future<void> imagePicker() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }
  void addBrand() async {
    String newBrand = brand.text.trim();
    if (newBrand.isNotEmpty) {
      await firestore.collection('brand').add({
        'brandName': newBrand,
      }).then((value) {
        print('Brand added successfully');

        fetchBrands();
        //
      }).catchError((error) {
        print('Error adding brand: $error');
      });
    }
  }


  void addItem() async {
    String itemName = itemNameController.text;
    String itemPrice = itemPriceController.text;
    String description = itemdescription.text;
    String loweCatId = selectedcatid.toLowerCase();
    if (selectedImage != null) {
      Reference storageReference = storage
          .ref()
          .child("item image/${DateTime.now().microsecondsSinceEpoch}");
      UploadTask uploadTask = storageReference.putFile(selectedImage!);

      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        firestore.collection('items').add({
          'name': itemName,
          'price': itemPrice,
          'image': imageUrl,
          'catId': selectedcatid,
          'brand': brandSelect,
          'description': description
        }).then((value) {
          Fluttertoast.showToast(
              msg: "successfull.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.purple.shade100,
              textColor: Colors.white,
              fontSize: 16.0);
          print('Item added successfully');
        }).catchError((error) {
          print('Error adding item: $error');
        });
      });
    } else {
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildTextField(
                  controller: itemNameController,
                  hint: 'name',
                  colors: fontgrey,
                ),
                16.heightBox,
                buildTextField(
                  keyboardType: TextInputType.number,
                  showborder: true,
                  controller: itemPriceController,
                  hint: 'item price',
                  colors: fontgrey,
                ),
                SizedBox(height: 16.0),
                buildTextField(
                  controller: itemdescription,
                  hint: "description",
                  colors: fontgrey,
                ),
                16.heightBox,
                InkWell(
                  onTap: () => categorypick(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: "category", border: OutlineInputBorder()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedcatid),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: brand,
                        decoration: InputDecoration(
                          labelText: "Brand",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white
                    ),
                      child: TextButton(
                        onPressed: addBrand,
                        child: Text('Add Brand',style: TextStyle(color: Colors.orange.shade800),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () => brandpick(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Brand",
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(brandSelect),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                16.heightBox,
                selectedImage != null
                    ? SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.file(selectedImage!))
                    : SizedBox.shrink(),
                15.heightBox,
                ElevatedButton( style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: imagePicker,
                  child: Text('pick image',style: TextStyle(color: Colors.orange.shade800),),
                ),
                15.heightBox,
                ElevatedButton( style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    addItem();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => categoriess(),
                    ));
                  },
                  child: Text('Add Item',style: TextStyle(color:Colors.orange.shade800),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




//brand add step complete chat gpt ♥ ♥