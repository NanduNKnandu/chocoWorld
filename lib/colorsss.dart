import 'package:elite_events/homescreen/dealofthed'
    'ay.dart';
import 'package:elite_events/userDetail/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final  Color textfieldgrey=Color.fromRGBO(209, 209, 209, 1);
final Color fontgrey=Color.fromRGBO(107, 115, 119, 1);
final Color darkfontgreay= Color.fromRGBO(62, 68, 71, 1);
final Color whitecolor=Color.fromRGBO(255, 255, 255, 1);
final Color lightgrey=Color.fromRGBO(239, 239, 239, 1);
final Color redcolor=Color.fromRGBO(230, 46, 4, 1);
Color chocolateColor = Color(0xFFD0AA71);


const dealOfTheDay ="deal of the day" , flashsale="flash sales",Tbrand="special Picks",editors="Editor's Choice";
const menuItems=[
  dealOfTheDay,flashsale,Tbrand,editors
];

const random="asset/donut.png",random1="asset/flashSale.png";

const category="categories",  topseller="top sellers";
const categories="asset/lottie/categories.json", brand1= "asset/lottie/brand.json", brand= "asset/lottie/bulb.json";



const milkchoclate="milk choclates", chocolateBars="chocolate bars", darkChocklate="dark chocloates", chocCAndies="choclate candies",customizableChoc="customized ",
    tuffle="tuffles", hotChoco="hot chocolates",drinkChoco="drinks",whitechoco="white chocolates";

//
const categoriesList=[
  milkchoclate,darkChocklate,whitechoco,chocolateBars,chocCAndies,drinkChoco,hotChoco,tuffle,customizableChoc
];
final sliderlist = ["asset/chocl.jpg", "asset/offer.png", "asset/banner.png"];

// String UserId=FirebaseAuth.instance.currentUser!.uid;
const categoriesImage=[
  "asset/milkChoc.png",
  "asset/darkChoco.png",
  "asset/whitechoc.png",
  "asset/chocobar.png",
  "asset/candy.png",
  "asset/chocodrink.png",
  "asset/hotchoc.png",
  "asset/chocbrand.png",
  "asset/custom.png",
];


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elite_events/buy/orderModelClass.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import '../../buy/myOrder.dart';
// import '../../colorsss.dart';
//
// class OrderConfirmationPage extends StatelessWidget {
//   OrderConfirmationPage({
//     required this.order,
//   });
//   final OrderBuy order;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => myOrder(),
//             ));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Order Confirmation"),
//         ),
//         body: FutureBuilder(
//             future: FirebaseFirestore.instance
//                 .collection("Users")
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .collection('orders')
//                 .doc(order.orderId)
//                 .get(),
//             builder: (context, snapshot) {
//               if(snapshot.connectionState==ConnectionState.waiting){
//                 return Center(child: CircularProgressIndicator(),);
//               }else if( !snapshot.hasData || !snapshot.data!.exists) {
//                 return Center(child: Text("Order not found"));
//               } else {
//                 var orderdata=snapshot.data;
//                 var addressdata=orderdata!['address'];
//
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Order Placed Successfully!",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       ListTile(
//                         leading: Image.network(order.itemImageUrl),
//                         title: Text(order.itemName),
//                         subtitle: Text("Quantity: ${order.quantity}"),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         "Order Details:",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       customOrderDetailTile("Item Price", "\$${order.itemPrice}"),
//                       customOrderDetailTile(
//                           "Delivery Amount", "\$${order.deliveryAmount}"),
//                       Divider(),
//                       customOrderDetailTile("Total", "\$${order.totalAmount}"),
//                       50.heightBox,
//                       Text(
//                         "Address Details  Details:",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       customAddressDetailTile('Name', addressdata['Name'])
//                     ],
//                   ),
//                 );
//
//               }
//
//             }),
//       ),
//     );
//   }
//
//   Widget customOrderDetailTile(String leadingText, String trailingText) {
//     return ListTile(
//       title: Text(
//         leadingText,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       trailing: Text(
//         trailingText,
//         style: TextStyle(
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
//
//   Widget customAddressDetailTile(String leadingText, String trailingText) {
//     return ListTile(
//       title: Text(
//         leadingText,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Text(
//         trailingText,
//         style: TextStyle(
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }
