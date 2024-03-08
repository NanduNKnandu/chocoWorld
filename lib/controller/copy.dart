// //
// // import 'dart:io';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:elite_events/controller/controller.dart';
// // import 'package:elite_events/homescreen/profile.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:velocity_x/velocity_x.dart';
// //
// // class editt extends StatefulWidget {
// //   final dynamic data;
// //   const editt({Key? key, this.data}) : super(key: key);
// //
// //   @override
// //   State<editt> createState() => _edittState();
// // }
// //
// // class _edittState extends State<editt> {
// //   File? selectedImage;
// //   final FirebaseAuth fetch = FirebaseAuth.instance;
// //   final FirebaseFirestore load = FirebaseFirestore.instance;
// //   final FirebaseStorage imageAdd = FirebaseStorage.instance;
// //
// //
// //   TextEditingController namecontroller=TextEditingController();
// //   TextEditingController passcontroller=TextEditingController();
// //
// //
// //
// //   imagePicker() async {
// //     ImagePicker imagePicker = ImagePicker();
// //     XFile? pickedImage =
// //     await imagePicker.pickImage(source: ImageSource.gallery);
// //     if (pickedImage != null) {
// //       setState(() {
// //         selectedImage = File(pickedImage.path);
// //       });
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     namecontroller.text = widget.data['name'];
// //   }
// //
// //
// //   Future<void> updateUserProfile() async {
// //     try {
// //       if (namecontroller.text != widget.data['name']) {
// //         await fetch.currentUser?.updateDisplayName(namecontroller.text);
// //       }
// //
// //       if (passcontroller.text.isNotEmpty) {
// //         await fetch.currentUser?.updatePassword(passcontroller.text);
// //       }
// //
// //       if(selectedImage!=null){
// //         String fileName=fetch.currentUser!.uid; Reference reference=imageAdd.ref().child('profilePic/$fileName.jpg');
// //         TaskSnapshot snapshot = await reference.putFile(selectedImage!);
// //         String downloadURL = await snapshot.ref.getDownloadURL();
// //
// //         await load.collection("Users").doc(fetch.currentUser!.uid).update(
// //             {"image" :downloadURL});
// //       }
// //
// //       // Update the name in Firestore
// //       await load
// //           .collection('Users')
// //           .doc(fetch.currentUser?.uid)
// //           .update({'name': namecontroller.text});
// //
// //       // Show success message or perform any additional actions
// //       print('User profile updated successfully');
// //     } catch (error) {
// //       // Handle errors
// //       print('Error updating user profile: $error');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: true,
// //       backgroundColor: Colors.grey[300],
// //       appBar: AppBar(
// //         backgroundColor: Colors.orange.shade800,
// //       ),
// //       body: Center(
// //         child: Column(
// //           children: [
// //             InkWell(
// //               onTap: () {
// //                 imagePicker();
// //               },
// //               child: CircleAvatar(
// //                 radius: 60,
// //                 backgroundImage: selectedImage != null
// //                     ? FileImage(selectedImage!)
// //                     :NetworkImage(widget.data["image"]) as ImageProvider,
// //               ),
// //             ),
// //             20.heightBox,
// //             Padding(
// //               padding: const EdgeInsets.all(15.0),
// //               child: Column(
// //                 children: [
// //                   TextField(
// //                     controller:namecontroller,
// //                     decoration: InputDecoration(
// //                       disabledBorder: InputBorder.none,
// //                       hintText: "name",
// //                     ),
// //                   ),
// //                   30.heightBox,
// //                   TextField( controller:passcontroller,
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       hintText: "password",
// //                       border: InputBorder.none,
// //                     ),
// //                   ),
// //                 ],
// //               ).box.white.shadowSm.rounded.make(),
// //             ),
// //             100.heightBox,
// //             ElevatedButton(
// //               onPressed: () async{
// //                 showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) {
// //                     return AlertDialog(
// //                       content: Row(
// //                         children: [
// //                           CircularProgressIndicator(),
// //                           SizedBox(width: 16),
// //                           Text("Updating Profile..."),
// //                         ],
// //                       ),
// //                     );
// //                   },
// //                   barrierDismissible: false, // prevent user from tapping outside the dialog
// //                 );
// //                 await  updateUserProfile();
// //
// //                 print('Updating display name: ${namecontroller.text}');
// //
// //
// //                 Navigator.of(context).push(MaterialPageRoute(builder:(context) => profilee(), ));
// //               },
// //               child: Text("Save"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
//
//
//
//
// import 'package:elite_events/colorsss.dart';
// import 'package:elite_events/homescreen/homebuttons.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import 'category/categories.dart';
// import 'dealoftheday.dart';
// import 'flashsale.dart';
//
// class homee extends StatefulWidget {
//   const homee({super.key});
//
//   @override
//   State<homee> createState() => _homeeState();
// }
//
// class _homeeState extends State<homee> {
//   final sliderlist = ["asset/chocl.jpg", "asset/offer.png", "asset/banner.png"];
//   final sliderlist2 = [
//     "asset/Ferrero-Rocher.png",
//     "asset/choc2.jpg",
//     "asset/choc3.jpg",
//     "asset/choc4.jpg"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           color: lightgrey,
//           width: context.screenWidth,
//           height: context.screenHeight,
//           child: SafeArea(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     color: lightgrey,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: "Search anything....",
//                           hintStyle: TextStyle(color: textfieldgrey),
//                           suffixIcon: Icon(
//                             Icons.search,
//                             color: textfieldgrey,
//                           )),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           VxSwiper.builder(
//                             aspectRatio: 16 / 9,
//                             height: 170,
//                             autoPlay: true,
//                             enlargeCenterPage: true,
//                             itemCount: sliderlist.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Container(
//                                 child: Image.asset(
//                                   sliderlist[index],
//                                   fit: BoxFit.fill,
//                                 ),
//                               );
//                             },
//                           ),
//                           10.heightBox,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(
//                               2,
//                                   (index) => GestureDetector(
//                                 onTap: (){
//                                   if (index == 0) {
//                                     Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => DealOfTheDayPage(),
//                                     ));
//                                   } else if (index == 1) {
//                                     Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => FlashSalePage(),
//                                     ));
//                                   }
//                                 },
//                                 child: homeButton(
//                                   height: context.screenHeight * 0.16,
//                                   width: context.screenWidth / 2.5,
//                                   icon: index == 0 ? random : random1,
//                                   title: index == 0 ? dealOfTheDay : flashsale,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           10.heightBox,
//                           VxSwiper.builder(
//                             aspectRatio: 16 / 9,
//                             height: 170,
//                             autoPlay: false,
//                             enlargeCenterPage: true,
//                             itemCount: sliderlist2.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Container(
//                                 child: Image.asset(
//                                   sliderlist2[index],
//                                   fit: BoxFit.fill,
//                                 ),
//                               );
//                             },
//                           ),
//                           10.heightBox,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(3,
//                                   (index) => GestureDetector(
//                                 onTap: () {
//                                   if (index == 0) {
//                                     Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => categoriess(),
//                                     ));
//                                   } else if (index == 1) {
//                                     Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => FlashSalePage(),
//                                     ));
//                                   } else if (index !=1 || index!=0){
//                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => DealOfTheDayPage(),));
//                                   }
//                                 },
//                                 child: homeButton1(
//                                   height: context.screenHeight * 0.16,
//                                   width: context.screenWidth / 3.5,
//                                   lottie: index == 0
//                                       ? categories
//                                       : index == 1
//                                       ? brand
//                                       : brand1,
//                                   title: index == 0
//                                       ? category
//                                       : index == 1
//                                       ? Tbrand
//                                       : topseller,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           10.heightBox,
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 "   Featured categories",
//                                 style: GoogleFonts.adventPro(
//                                     textStyle: TextStyle(
//                                         fontSize: 20, fontWeight: FontWeight.bold)),
//                               )),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//         ));
//   }
// }
