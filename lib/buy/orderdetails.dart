import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'myOrder.dart';
import 'orderModelClass.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({required this.order, Key? key}) : super(key: key);
  final OrderBuy order;

  @override
  Widget build(BuildContext context) {
    bool canCancelOrder = order.status != "Delivered";

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("orders")
            .doc(order.orderId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Item Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Item Name: ${data['itemName'] ?? 'N/A'}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network(data['itemImageUrl'] ?? ''),
                        ),
                        100.heightBox,
                      ],
                    ),
                    Text('Quantity: ${data['quantity']}'),
                    Text('Delivery Amount: ${data['deliveryAmount']}'),
                    Text('Total Amount: ${data['totalAmount'] ?? 'N/A'}'),
                    70.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Delivery Address',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Text('${data['address']['Name']}'),
                    Row(
                      children: [
                        Text('${data['address']['houseNO']},'),
                        Text('${data['address']['Pincode']}'),
                      ],
                    ),
                    Text('${data['address']['city']}'),
                    Text('${data['address']['state']}'),
                    Text('${data['address']['PhoneNumber']}'),
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
          );
        },
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
              children: [
                Text('Are you sure you want to cancel this order?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                cancelOrder(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => myOrder(),));
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
  }
}
