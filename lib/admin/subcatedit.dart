import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/textfielExtract.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colorsss.dart';

class EditPage extends StatefulWidget {
  final String categoryId;
  final String subcategoryId;

  EditPage({required this.categoryId, required this.subcategoryId});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Subcategory"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField(hint: "Name",
              controller: nameController, colors: fontgrey,
            ),
            16.heightBox,
            buildTextField(hint: "price",
              controller: pricecontroller, colors: fontgrey,
            ),
            16.heightBox,
            buildTextField(hint: "description",
              controller: descriptioncontroller, colors: fontgrey,
            ),16.heightBox,


            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                updateDetails();
              },
              child: Text('Update',style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    existingdata();
  }
  void existingdata()async{
    try{
      DocumentSnapshot subcategorySnapshot= await FirebaseFirestore.instance.collection("items").doc(widget.subcategoryId).get();
      nameController.text=subcategorySnapshot["name"];
      pricecontroller.text=subcategorySnapshot['price'];
      descriptioncontroller.text=subcategorySnapshot['description'];
    } catch (error){
      print("error in fetching $error");
    }
  }

  void updateDetails() {
    String newName = nameController.text;
String NewPrice =pricecontroller.text;
String NewDescription = descriptioncontroller.text;
    FirebaseFirestore.instance
        .collection("items")
        .doc(widget.subcategoryId)
        .update({
      'name': newName,
      'price':NewPrice,
      "description":NewDescription,
    })
        .then((_) {
      print("Details updated successfully");
      Navigator.of(context).pop();
    })
        .catchError((error) {
      print("Error updating details: $error");
    });
  }
}
