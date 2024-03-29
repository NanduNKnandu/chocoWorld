// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../buy/orderModelClass.dart';
// import '../homescreen/navigat.dart';
// import 'adminBookdetail.dart';
//
//
// class adminbooking extends StatefulWidget {
//   const adminbooking({super.key});
//
//   @override
//   State<adminbooking> createState() => _adminbookingState();
// }
//
// class _adminbookingState extends State<adminbooking> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => bottomNavigat(),), (route) => false);
//         return false;
//       },
//       child: Scaffold(
//
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collectionGroup('orders')
//               .snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData || snapshot.data == null) {
//               return Text('No orders available');
//             } else {
//               var orders = snapshot.data!.docs;
//               return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//
//                   var orderData = orders[index].data() as Map<String, dynamic>;
//
//                   var order = OrderBuy.fromMap(orderData);
//
//                   print('Number of orders: ${orders.length}');
//                   print('Order data: $orders');
//
//                   return Column(
//                     children: [
//                       ListTile(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminBookingDetailPage(order:order ,)));
//                         },
//                         title: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(child: Text(order.itemName ?? 'Item not available')),
//                             SizedBox(
//                                 height: 70,
//                                 width: 70,
//                                 child: CachedNetworkImage(imageUrl: order.itemImageUrl))
//                           ],
//                         ),
//                         subtitle: Text('Total Amount: ${order.totalAmount ?? 'N/A'}'),
//                       ), Divider()
//                     ],
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }