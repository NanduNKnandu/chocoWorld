// //
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elite_events/homescreen/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class editt extends StatefulWidget {
//   const editt({Key? key}) : super(key: key);
//
//   @override
//   State<editt> createState() => _edittState();
// }
//
// class _edittState extends State<editt> {
//   File? selectedImage;
//   final FirebaseAuth fetch = FirebaseAuth.instance;
//   final FirebaseFirestore load = FirebaseFirestore.instance;
//   final FirebaseStorage imageAdd = FirebaseStorage.instance;
//
//   imagePicker() async {
//     ImagePicker imagePicker = ImagePicker();
//     XFile? pickedImage =
//     await imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         selectedImage = File(pickedImage.path);
//       });
//     }
//   }
//
//   Future<void> updateProfile() async {
//     try {
//       print("update profile function started");
//       User? user = fetch.currentUser;
//       if (user != null) {
//         String userId = user.uid;
//
//         // Upload image to Firebase Storage
//         if (selectedImage != null) {
//           Reference storageReference =
//           imageAdd.ref().child('user/$userId.jpg');
//           await storageReference.putFile(selectedImage!);
//           String imageUrl = await storageReference.getDownloadURL();
//           print("Imageurl:$imageUrl");
//
//           // Update user data in Firestore
//           await load.collection('Users').doc(userId).update({
//             'name': 'Updated Name',
//             'phone': 'Updated Phone',
//             'avatar': imageUrl,
//           });
//
//           // Reload user data to reflect changes
//           user = fetch.currentUser;
//           Navigator.pop(context, imageUrl);
//
//         }
//       }
//       print("Update Profile Function Completed");
//     } catch (e) {
//       print('Error updating user profile: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: Colors.orange.shade800,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 imagePicker();
//               },
//               child: CircleAvatar(
//                 radius: 60,
//                 backgroundImage: selectedImage != null
//                     ? FileImage(selectedImage!)
//                     : AssetImage("asset/event2.jpg") as ImageProvider,
//               ),
//             ),
//             20.heightBox,
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                       disabledBorder: InputBorder.none,
//                       hintText: "name",
//                     ),
//                   ),
//                   15.heightBox,
//                   TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: "phone",
//                       disabledBorder: InputBorder.none,
//                     ),
//                   ),
//                 ],
//               ).box.white.rounded.make(),
//             ),
//             100.heightBox,
//             ElevatedButton(
//               onPressed: () {
//                 print("button perfect");
//                 updateProfile();
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => profilee(), ));
//               },
//               child: Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
