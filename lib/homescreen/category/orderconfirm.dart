
import 'package:elite_events/buy/orderModelClass.dart';
import 'package:flutter/material.dart';

import '../../buy/myOrder.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({
    required this.order,
  });
  final OrderBuy order;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => myOrder(),));
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
              customOrderDetailTile("Item Price", "\$${order.itemPrice}"),
              customOrderDetailTile("Delivery Amount", "\$${order.deliveryAmount}"),
              Divider(),
              customOrderDetailTile("Total", "\$${order.totalAmount}"),
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
