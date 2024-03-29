import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homescreen/navigat.dart';
import 'orderModelClass.dart';
import 'orderdetails.dart';

class myOrder extends StatefulWidget {
  const myOrder({Key? key,}) : super(key: key);


  @override
  State<myOrder> createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => bottomNavigat(),
          ),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No orders available');
            } else {
              var orders = snapshot.data!.docs;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var orderData =
                  orders[index].data() as Map<String, dynamic>;
                  var order = OrderBuy.fromMap(orderData);

                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                              order: order,
                            ),
                          ));
                        },
                        title: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                order.itemName ?? 'Item not available',
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              width: 70,
                              child:
                              Image(image: NetworkImage(order.itemImageUrl)),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text('Total Amount: ${order.totalAmount ?? 'N/A'}'),
                            Row(
                              children: [
                                Text(
                                  'Order Status: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${order.status ?? "n/a"},",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: order.status == "Order Confirmed"
                                        ? Colors.blue
                                        : order.status == "Shipped"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}