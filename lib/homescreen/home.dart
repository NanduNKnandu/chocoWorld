import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/colorsss.dart';
import 'package:elite_events/homescreen/homebuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../buy/searchPage.dart';


import 'brands.dart';
import 'category/categories.dart';
import 'dealoftheday.dart';

class homee extends StatefulWidget {
  const homee({super.key});

  @override
  State<homee> createState() => _homeeState();
}

class _homeeState extends State<homee> {
  final TextEditingController searchController = TextEditingController();

  // void handleSearch(String brandName, BuildContext context) {
  //   FirebaseFirestore.instance
  //       .collection('items')
  //       .where('brand', isEqualTo: brandName)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     if (querySnapshot.docs.isNotEmpty) {
  //       QueryDocumentSnapshot document = querySnapshot.docs.first;
  //
  //       String itemName = document['name'];
  //       String itemPrice = document['itemprice'];
  //       String imageUrl = document['description'];
  //
  //       print('Item Name: $itemName');
  //       print('Item Price: $itemPrice');
  //       print('Image URL: $imageUrl');
  //
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ItemDetailsPage(
  //             itemName: itemName,
  //             itemPrice: itemPrice,
  //             imageUrl: imageUrl,
  //           ),
  //         ),
  //       );
  //     } else {
  //       print('No matching items found for brand: $brandName');
  //
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('No Data Available'),
  //             content: Text('No matching items found for brand: $brandName'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }).catchError((error) {
  //     print('Error fetching data: $error');
  //   });
  // }

  // final sliderlist2 = [
  //   "asset/Ferrero-Rocher.png",
  //   "asset/choc2.jpg",
  //   "asset/choc3.jpg",
  //   "asset/choc4.jpg"
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: lightgrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-40,
            height: 50,
            padding: EdgeInsets.all(12),
            color: Colors.white,
            // child: TextFormField(
            //   controller: searchController,
            //   decoration: InputDecoration(
            //       border: InputBorder.none,
            //       filled: true,
            //       fillColor: Colors.white,
            //       hintText: "choco world",
            //       hintStyle: TextStyle(color: textfieldgrey),
            //       // suffixIcon: TextButton(
            //       //   onPressed: () =>
            //       //       handleSearch(searchController.text, context),
            //       //   child: Icon(
            //       //     Icons.search,
            //       //     color: textfieldgrey,
            //       //   ),
            //       // )
            //   ),
            // ),
            child: Center(child: Text("Choco World",style: TextStyle(fontWeight: FontWeight.bold),),),
          ).box.shadowSm.make(),
          20.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 170,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    itemCount: sliderlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Image.asset(
                          sliderlist[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) => GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => dealoftheday(
                                  catId: menuItems[index].toLowerCase()),
                            ));
                          } else if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => dealoftheday(
                                  catId: menuItems[index].toLowerCase()),
                            ));
                          }
                        },
                        child: homeButton(
                          height: context.screenHeight * 0.16,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? random : random1,
                          title: index == 0 ? dealOfTheDay : flashsale,
                        ),
                      ),
                    ),
                  ),
                  10.heightBox,
                  Column(
                    children: [
                      InkWell( 
                        child: Container(
                          child: SizedBox(
                            height: 200,
                            width: 350,
                            child: Image.asset(
                              "asset/Ferrero-Rocher.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ), onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => brands(),)),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => categoriess(),
                            ));
                          } else if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => dealoftheday(
                                  catId: menuItems[2].toLowerCase()),
                            ));
                          } else if (index != 1 || index != 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => dealoftheday(
                                  catId: menuItems[3].toLowerCase()),
                            ));
                          }
                        },
                        child: homeButton1(
                          height: context.screenHeight * 0.16,
                          width: context.screenWidth / 3.5,
                          lottie: index == 0
                              ? categories
                              : index == 1
                                  ? brand
                                  : brand1,
                          title: index == 0
                              ? category
                              : index == 1
                                  ? Tbrand
                                  : editors,
                        ),
                      ),
                    ),
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "   Featured categories",
                        style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )),
                ],
              ),
            ),
          )
        ],
      )),
    ));
  }
}
