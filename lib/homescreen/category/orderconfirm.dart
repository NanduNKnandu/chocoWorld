import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/buy/orderModelClass.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../buy/myOrder.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({
    required this.order,
  });
  final OrderBuy order;

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => myOrder(
                 ),
            ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Confirmation"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Placed Successfully!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Image.network(order.itemImageUrl),
                title: Text(order.itemName),
                subtitle: Text("Quantity: ${order.quantity}"),
              ),
              SizedBox(height: 20),
              Text(
                "Order Details:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              customOrderDetailTile("Item Price", "\u20B9${order.itemPrice}"),
              customOrderDetailTile(
                  "Delivery Amount", "\u20B9${order.deliveryAmount}"),
              Divider(),
              customOrderDetailTile("Total", "\u20B9${order.totalAmount}"),
              50.heightBox,
              Text(
                "Address Details  Details:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(order.deliveryAddress!.name),
              5.heightBox,
              Text(order.deliveryAddress!.houseNo),
              5.heightBox,
              Text(order.deliveryAddress!.pincode),
              5.heightBox,
              Text(order.deliveryAddress!.city),
              5.heightBox,
              Text(order.deliveryAddress!.state),
              5.heightBox,
              Text(order.deliveryAddress!.phoneNumber),
              5.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget customOrderDetailTile(String leadingText, String trailingText) {
    return ListTile(
      title: Text(
        leadingText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        trailingText,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
