import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/userDetail/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class editt extends StatefulWidget {
  final dynamic data;
  const editt({Key? key, this.data}) : super(key: key);

  @override
  State<editt> createState() => _edittState();
}

class _edittState extends State<editt> {
  File? selectedImage;
  final FirebaseAuth fetch = FirebaseAuth.instance;
  final FirebaseFirestore load = FirebaseFirestore.instance;
  final FirebaseStorage imageAdd = FirebaseStorage.instance;

  TextEditingController namecontroller = TextEditingController();
  // TextEditingController passcontroller = TextEditingController();

  imagePicker() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.data['name'];
  }

  Future<void> updateUserProfile() async {
    try {
      if (namecontroller.text != widget.data['name']) {
        await fetch.currentUser?.updateDisplayName(namecontroller.text);
      }

      if (selectedImage != null) {
        String fileName = fetch.currentUser!.uid;
        Reference reference = imageAdd.ref().child('profilePic/$fileName.jpg');
        TaskSnapshot snapshot = await reference.putFile(selectedImage!);
        String downloadURL = await snapshot.ref.getDownloadURL();

        await load
            .collection("Users")
            .doc(fetch.currentUser!.uid)
            .update({"image": downloadURL});
      }

      await load
          .collection('Users')
          .doc(fetch.currentUser?.uid)
          .update({'name': namecontroller.text});

      print('User profile updated successfully');
    } catch (error) {
      print('Error updating user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.orange.shade800,
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                imagePicker();
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : NetworkImage(widget.data["image"]) as ImageProvider,
              ),
            ),
            20.heightBox,
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    GlassContainer(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.40),
                          Colors.white.withOpacity(0.10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.60),
                          Colors.white.withOpacity(0.10),
                          Colors.purpleAccent.withOpacity(0.05),
                          Colors.purpleAccent.withOpacity(0.60),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 20,
                      borderRadius: BorderRadius.circular(24.0),
                      borderWidth: 1.0,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.blue.withOpacity(0.20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: namecontroller,
                        style: TextStyle(color: Colors.orange),
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          hintText: "name",
                        ),
                      ),
                    ),
                    30.heightBox,
                    // TextField(
                    //   controller: passcontroller,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     hintText: "password",
                    //     border: InputBorder.none,
                    //   ),
                    // ),
                  ],
                )),
            100.heightBox,
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text("Updating Profile..."),
                        ],
                      ),
                    );
                  },
                  barrierDismissible: false,
                );
                await updateUserProfile();

                print('Updating display name: ${namecontroller.text}');

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => profilee(),
                    ),
                    (route) => false);
              },
              child: GlassContainer(
                  height: 50,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.40),
                      Colors.white.withOpacity(0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.60),
                      Colors.white.withOpacity(0.10),
                      Colors.purpleAccent.withOpacity(0.05),
                      Colors.purpleAccent.withOpacity(0.60),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.39, 0.40, 1.0],
                  ),
                  blur: 20,
                  borderRadius: BorderRadius.circular(24.0),
                  borderWidth: 1.0,
                  elevation: 3.0,
                  isFrostedGlass: true,
                  shadowColor: Colors.purple.withOpacity(0.20),
                  width: 70,
                  child: Center(
                      child: Text(
                    "Save",
                    style: TextStyle(color: Colors.orange),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
