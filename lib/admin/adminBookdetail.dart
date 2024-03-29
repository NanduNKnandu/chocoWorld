// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../buy/orderModelClass.dart';
//
// class AdminBookingDetailPage extends StatefulWidget {
//   final OrderBuy order;
//
//   const AdminBookingDetailPage({
//     required this.order,
//   });
//
//   @override
//   State<AdminBookingDetailPage> createState() => _AdminBookingDetailPageState();
// }
//
// class _AdminBookingDetailPageState extends State<AdminBookingDetailPage> {
//   late String selectedStatus;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedStatus = widget.order.status;
//   }
//
//   void updateOrderStatus(String status) {
//     setState(() {
//       selectedStatus = status;
//     });
//     // Update order status in Firestore here if needed
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Item Details',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               widget.order.itemName ?? 'Item not available',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 70,
//                             width: 70,
//                             child: CachedNetworkImage(imageUrl: widget.order.itemImageUrl ?? ''),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Total Amount: ${widget.order.totalAmount ?? 'N/A'}',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Delivery Address',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       // Text('Name: ${widget.order.deliveryAddress!.name}'),
//                       // Text('House Number: ${widget.order.address.houseNumber}'),
//                       // Text('Pincode: ${widget.order.address.pincode}'),
//                       // Text('City: ${widget.order.address.city}'),
//                       // Text('State: ${widget.order.address.state}'),
//                       // Text('Phone Number: ${widget.order.address.phoneNumber}'),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Order Status',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       ListTile(
//                         title: Text('Order Confirmed'),
//                         leading: Radio<String>(
//                           value: 'Order Confirmed',
//                           groupValue: selectedStatus,
//                           onChanged: (value) => updateOrderStatus(value!),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text('Shipped'),
//                         leading: Radio<String>(
//                           value: 'Shipped',
//                           groupValue: selectedStatus,
//                           onChanged: (value) => updateOrderStatus(value!),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text('Delivered'),
//                         leading: Radio<String>(
//                           value: 'Delivered',
//                           groupValue: selectedStatus,
//                           onChanged: (value) => updateOrderStatus(value!),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
