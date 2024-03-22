import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/colorsss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../buy/orderModelClass.dart';

class AdminBookingDetailPage extends StatefulWidget {
  final OrderBuy order;

  const AdminBookingDetailPage({
    required this.order,
  });

  @override
  State<AdminBookingDetailPage> createState() => _AdminBookingDetailPageState();
}

class _AdminBookingDetailPageState extends State<AdminBookingDetailPage> {
  late String selectedStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatus=widget.order.status;
  }

  void updateOrderStatus(String status)async{
try{
  await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).
  collection('orders').doc(widget.order.orderId).update({'status':status});
  setState(() {
    selectedStatus=status;
  });
}catch(e){
  print(e);
}
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          ListTile(
            title: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.order.itemName ?? 'Item not available',overflow:TextOverflow.ellipsis ),
                SizedBox(
                    height: 70,
                    width: 70,
                    child: CachedNetworkImage(imageUrl: widget.order.itemImageUrl))
              ],
            ),
            subtitle: Column(
              children: [
                Text('Total Amount: ${widget.order.totalAmount ?? 'N/A'}'),
              ],
            ),
          ),



          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Status:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Order Confirmed',
                      groupValue: selectedStatus,
                      onChanged: (value) => updateOrderStatus(value!),
                    ),
                    Text('Order Confirmed'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Shipped',
                      groupValue: selectedStatus,
                      onChanged: (value) => updateOrderStatus(value!),
                    ),
                    Text('Shipped'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Delivered',
                      groupValue: selectedStatus,
                      onChanged: (value) => updateOrderStatus(value!),
                    ),
                    Text('Delivered'),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
