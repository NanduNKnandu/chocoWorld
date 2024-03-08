import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colorsss.dart';
import '../homescreen/category/categories.dart';
import '../homescreen/navigat.dart';
import '../textfielExtract.dart';

class adminDealOf extends StatefulWidget {
  const adminDealOf({super.key});

  @override
  State<adminDealOf> createState() => _adminDealOfState();
}

class _adminDealOfState extends State<adminDealOf> {
  File? selectedImage;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemdescription = TextEditingController();

  String selectedcatid = "";

  void categorypick(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerData: menuItems),
        hideHeader: true,
        title: Text(" select category id"),
        onConfirm: (Picker picker, List<int> selecteds) {
          setState(() {
            selectedcatid = menuItems[selecteds.first];
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

  void addItem() async {
    String itemName = itemNameController.text;
    String itemPrice = itemPriceController.text;
    String description = itemdescription.text;
    if (selectedImage != null) {
      Reference storageReference = storage
          .ref()
          .child("menuItem image/${DateTime.now().microsecondsSinceEpoch}");
      UploadTask uploadTask = storageReference.putFile(selectedImage!);

      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        firestore.collection('dealoftheday').add({
          'name': itemName,
          'price': itemPrice,
          'image': imageUrl,
          'catId': selectedcatid.toLowerCase(),
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
                  child: Text('pick image',style: TextStyle(color: Colors.orange.shade800)),
                ),
                15.heightBox,
                ElevatedButton( style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    addItem();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => bottomNavigat(),
                    ));
                  },
                  child: Text('Add Item',style: TextStyle(color: Colors.orange.shade800),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
