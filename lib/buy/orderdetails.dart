import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'orderModelClass.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderBuy order;

  const OrderDetailsPage({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Name: ${order.itemName ?? 'N/A'}'),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.network(order.itemImageUrl ?? ''),
            ),
            Text('Total Amount: ${order.totalAmount ?? 'N/A'}'),
            200.heightBox,
            ElevatedButton(
              onPressed: () {
                _showCancelConfirmationDialog(context);
              },
              child: Text("Cancel This Order"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCancelConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to cancel this order?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                cancelOrder(context);
              },
              child: Text('Yes, Cancel Order'),
            ),
          ],
        );
      },
    );
  }

  void cancelOrder(BuildContext context) {
    
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").snapshots();


    Navigator.of(context).pop();
  }
}
