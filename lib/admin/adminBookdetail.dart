import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? selectedOption =  'Order Confirmed';
  @override
  Widget build(BuildContext context) {


    print("change");
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
            subtitle: Text('Total Amount: ${widget.order.totalAmount ?? 'N/A'}'),
          ),


          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Address")
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot2.hasError) {
                  return Text("Error ${snapshot2.error}");
                }

                final QuerySnapshot? addressData =
                snapshot2.data as QuerySnapshot?;

                if (addressData == null || addressData.docs.isEmpty) {
                  return Text("No Address Found");
                }

                // mukalile if illelm ok aan pinne aaa final query snapshot? full
                return Container(
                  height: 220,
                  padding: EdgeInsets.all(20),
                  color: Colors.orange.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deliver to:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        snapshot2.data!.docs[0]['Name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        snapshot2.data!.docs[0]['houseNO'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot2.data!.docs[0]['Pincode'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            snapshot2.data!.docs[0]['city'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${snapshot2.data!.docs[0]['state']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
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
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    Text('Order Confirmed'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Shipping',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    Text('Shipping'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Item Delivered',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    Text('Item Delivered'),
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
