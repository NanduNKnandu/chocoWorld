import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/colorsss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddAddress.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();


  @override
  void initState() {
    checkExistingaddress();

    // TODO: implement initState
    super.initState();
  }
   Future<void> checkExistingaddress()async{
    try {


     var snapshot = await FirebaseFirestore.instance
         .collection("Users")
         .doc(UserId)
         .collection("Address")
         .get();

     if(snapshot.docs.isNotEmpty){
       var data=snapshot.docs.single.data();
       fullNameController.text = data['Name'];
       phoneNumberController.text = data['PhoneNumber'];
       pincodeController.text = data['Pincode'];
       stateController.text = data['state'];
       cityController.text = data['city'];
       houseNoController.text = data['houseNO'];
     }
    } catch (err){
      print(err);
    }
  }



  void saveAddress() {
    String fullName = fullNameController.text;
    String phoneNumber = phoneNumberController.text;
    String pincode = pincodeController.text;

    String state = stateController.text;
    String city = cityController.text;
    String houseNo = houseNoController.text;


    if(fullName.isEmpty || phoneNumber.isEmpty || pincode.isEmpty || state.isEmpty || houseNo.isEmpty){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Incomplete Address"),
            content: Text("Please fill in all  fields before saving."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else{
      try{

        FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("Address").add({
          "Name":fullName,
          "PhoneNumber":phoneNumber,
          "Pincode":pincode,
          "state":state,
          "city":city,
          "houseNO":houseNo,
        }
        );

      } catch(err){
        print(err);
      }
    }



    print('Full Name: $fullName');
    print('Phone Number: $phoneNumber');
    print('Pincode: $pincode');
    print('State: $state');
    print('City: $city');
    print('House No: $houseNo');

    if(fullName.isNotEmpty && phoneNumber.isNotEmpty && pincode.isNotEmpty && state.isNotEmpty &&city.isNotEmpty && houseNo.isNotEmpty){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddAddress()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Address'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TransparentTextField(
                hintText: 'Full Name (required)*',
                controller: fullNameController,
              ),
              TransparentTextField(
                hintText: 'Phone Number (required)*',
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
              TransparentTextField(
                hintText: 'Pincode',
                controller: pincodeController,
                keyboardType: TextInputType.number,
              ),
              TransparentTextField(
                hintText: 'State',
                controller: stateController,
              ),
              TransparentTextField(
                hintText: 'City',
                controller: cityController,
              ),
              TransparentTextField(
                hintText: 'House No',
                controller: houseNoController,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {

                    saveAddress();
                  },
                  child: Text(
                    'Save Address',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class TransparentTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const TransparentTextField({
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
