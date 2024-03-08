// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'admin/admincart.dart';
//
// class Discription extends StatefulWidget {
//   const Discription({super.key, required this.docid, required this.cl});
//   final String docid;
//   final String cl;
//
//   @override
//   State<Discription> createState() => _DiscriptionState();
// }
//
// class _DiscriptionState extends State<Discription> {
//   String weight = '1KG';
//   int? totalprice = 0;
//   String? date;
//
//   Future<bool> getLocation() async {
//     var data = await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("otherdetails")
//         .get();
//     if (data.docs.isNotEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   addtocat(
//       {required String name,
//         required int price,
//         required String image,
//         required docid,
//         required cl}) async {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('carts')
//         .add({
//       'name': name,
//       "price": price,
//       "image": image,
//       'docid': docid,
//       'cl': cl
//     });
//   }
//
//   booking(
//       {required String name, required int price, required String image}) async {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('booking')
//         .add({'name': name, "price": price, "image": image});
//   }
//
//   TextEditingController msgcontroler = TextEditingController();
//   String name = '';
//
//   @override
//   Widget build(BuildContext context) {
//     print(FirebaseAuth.instance.currentUser!.uid);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           StreamBuilder(
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 var myData = snapshot.data!.docs;
//                 print(myData.length);
//
//                 return Padding(
//                     padding: const EdgeInsets.only(right: 30),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) {
//                             return CartPage(cartItems: [],);
//                           },
//                         ));
//                       },
//                       child: Badge(
//                           label: Text(myData.length.toString()),
//                           smallSize: 17,
//                           child: Icon(
//                             Icons.shopping_cart_outlined,
//                             size: 30,
//                           )),
//                     ));
//               } else {
//                 return SizedBox();
//               }
//             },
//             stream: FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .collection("carts")
//                 .snapshots(),
//           ),
//         ],
//         backgroundColor: Colors.pink.shade100,
//       ),
//       body: ListView(
//         children: [
//           StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection(widget.cl)
//                   .doc(widget.docid)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(15),
//                         height: 240,
//                         width: 200,
//                         alignment: Alignment.topLeft,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: NetworkImage(snapshot.data!['image']),
//                             )),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snapshot.data!['name'],
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.currency_rupee,
//                             size: 17,
//                           ),
//                           Text(snapshot.data!["price"].toString())
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Row(
//                           children: [
//                             Radio(
//                                 value: '1KG',
//                                 groupValue: weight,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     totalprice =
//                                         int.parse(snapshot.data!['price']);
//                                     weight = value!;
//                                   });
//                                 }),
//                             Text('1Kg'),
//                             SizedBox(
//                               width: 50,
//                             ),
//                             Radio(
//                                 value: '2KG',
//                                 groupValue: weight,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     weight = value!;
//                                     totalprice =
//                                         int.parse(snapshot.data!['price']) * 2;
//                                   });
//                                 }),
//                             Text('2kg'),
//                             SizedBox(
//                               width: 50,
//
//                             ),
//                             Radio(
//                                 value: '3KG',
//                                 groupValue: weight,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     weight = value!;
//                                     totalprice =
//                                         int.parse(snapshot.data!['price']) * 3;
//                                   });
//                                 }),
//                             Text('3kg')
//                           ],
//                         ),
//                       ),
//                       Icon(
//                         Icons.currency_rupee,
//                         weight: 20,
//                         size: 17,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                           child: Center(
//                             child: Text(
//                               totalprice!.toString(),
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                           height: 30,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.black,
//                             ),
//                             borderRadius: BorderRadius.circular(40),
//                           )),
//                       Container(
//                         height: MediaQuery.of(context).size.height * .27,
//                         margin: EdgeInsets.only(top: 20),
//                         padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                             color: Colors.pink.shade100,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(30),
//                                 topLeft: Radius.circular(30))),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 10, bottom: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Discription',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: Text(snapshot.data!['discription'])),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 14,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'message on cake',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                       TextField(
//                         controller: msgcontroler,
//                       ),
//                       // ElevatedButton(onPressed: () {}, child: Text('okk')),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       InkWell(
//
//                           onTap: () async {
//                             DateTime? store = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(2023),
//                                 lastDate: DateTime(2028));
//
//                             if (store != null) {
//                               setState(() {
//                                 date =
//                                 "${store!.day}-${store.month}-${store!.year}";
//                                 print(date);
//                               });
//                             }
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                               height: 50,
//                               width: 200,
//                               child: Center(
//                                 child: Text(
//                                   date ?? 'choose Date',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 16),
//                                 ),
//                               ))),
//                       SizedBox(
//                         height: 26,
//                       ),
//                       Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               addtocat(
//                                   name: snapshot.data!['name'],
//                                   price: totalprice!,
//                                   image: snapshot.data!['image'],
//                                   docid: snapshot.data!.id,
//                                   cl: widget.cl);
//                               Fluttertoast.showToast(
//                                   msg: "Added to cart",
//                                   backgroundColor: Colors.red);
//                             },
//                             child: Row(
//                               children: [
//                                 FutureBuilder(
//                                   future: getLocation(),
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot<bool> snapshots) {
//                                     if (snapshots.hasData) {
//                                       bool status = snapshots.data!;
//                                       return Center(
//
//                                           child: Container(
//
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white30,
//                                                 borderRadius:
//                                                 BorderRadius.all(Radius.circular(10))),
//                                             height: 50,
//                                             width: 150,
//
//                                             child: TextButton(
//
//
//                                               onPressed: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       title: Text(
//                                                         "confirm order",
//                                                       ),
//                                                       content:
//                                                       SingleChildScrollView(
//                                                         child: ListBody(
//                                                           children: [
//                                                             Text(
//                                                                 "Do you want to confirm order?"),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       actions: [
//                                                         TextButton(
//                                                           onPressed: () {
//                                                             Navigator.of(context).pop();
//                                                           },
//                                                           child: Text("Go back",),
//                                                         ),
//                                                         TextButton(
//                                                             onPressed: () {
//
//                                                               if (status == false) {
//                                                                 Fluttertoast.showToast(
//                                                                     msg: "please add your address");
//                                                               } else {
//                                                                 booking(
//                                                                     name: snapshot.data!['name'],
//                                                                     price: totalprice!,
//                                                                     image: snapshot.data!['image']);
//                                                                 Fluttertoast.showToast(
//                                                                     msg: 'Booked suceesfully');
//                                                               }
//                                                               Navigator.pop(context);
//                                                             },
//                                                             child: Text("Yes"))
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               child: Text(
//                                                 'BUY NOW',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,color: Colors.black),
//                                               ),
//                                             ),
//                                           ));
//                                     } else {
//                                       return SizedBox();
//                                     }
//                                   },
//                                 ),
//                                 SizedBox(
//                                   width: 40,
//                                 ),
//                                 Container(
//                                   height: 70,
//                                   width: 160,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade500,
//
//
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(color: Colors.black),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                         'ADD TO CART',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 } else {
//                   return SizedBox();
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }

