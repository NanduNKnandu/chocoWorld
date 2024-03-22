import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'myOrder.dart';
import 'orderModelClass.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderBuy order;

  const OrderDetailsPage({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canCancelOrder = order.status != "Delivered";

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Item Name: ${order.itemName ?? 'N/A'}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(order.itemImageUrl ?? ''),
                    ),
                    200.heightBox,
                  ],
                ),
                Text('Quantity: ${order.quantity}'),
                Text('Delivery Amount: ${order.deliveryAmount}'),
                Text('Total Amount: ${order.totalAmount ?? 'N/A'}'),
                50.heightBox,
              ],
            ).box.blue50.rounded.shadow.make(),
            200.heightBox,
            if (canCancelOrder)
              TextButton(
                onPressed: () {
                  _showCancelConfirmationDialog(context);
                },
                child: Text("Cancel This Order"),
              ).box.roundedFull.blue50.make()
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
              children:[
                Text('Are you sure you want to cancel this order?'),
              ],
            ),
          ),
          actions:[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc(order.orderId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order canceled successfully'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => myOrder(),));
  }
}
