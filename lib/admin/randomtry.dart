import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collectionGroup('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              return Column(
                children: [
                  ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(right: 16.0),
                          child: Image.network(order['itemImageUrl'] ?? ''),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Item Name: ${order['itemName']}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Quantity: ${order['quantity']}'),
                              Text(
                                  'Total Amount: ${order['totalAmount'] ?? 'N/A'}'),
                              Text(
                                'Order ID: ${order['orderId']}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(order: order),
                        ),
                      );
                    },
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}



class OrderDetailsPage extends StatefulWidget {
  final QueryDocumentSnapshot order;

  OrderDetailsPage({required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late String selectedStatus;
  @override
  void initState() {
    super.initState();

    selectedStatus = widget.order['status'];
  }



  void updateOrderStatus(String status) {
    setState(() {
      selectedStatus = status;
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .doc(widget.order.id)
        .update({'status': status});
  }


  @override
  Widget build(BuildContext context) {
    var address = widget.order['address'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card( color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Item Name: ${widget.order['itemName']}'),
                          ),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CachedNetworkImage(imageUrl: widget.order['itemImageUrl']),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Quantity: ${widget.order['quantity']}'),
                      Text('Item Price: \$${widget.order['itemPrice']}'),
                      Text('Delivery Amount: \$${widget.order['deliveryAmount']}'),
                      Text(
                        'Total Amount: ${widget.order['totalAmount']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Address',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text('Name: ${address['Name']}'),
                      Text('Phone Number: ${address['PhoneNumber']}'),
                      Text(
                          'Address: ${address['houseNO']}, ${address['Pincode']}, ${address['city']}, ${address['state']}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Status',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Order Confirmed'),
                        leading: Radio<String>(
                          value: 'Order Confirmed',
                          groupValue: selectedStatus,
                          onChanged: (value) => updateOrderStatus(value!),
                        ),
                      ),
                      ListTile(
                        title: Text('Shipped'),
                        leading: Radio<String>(
                          value: 'Shipped',
                          groupValue: selectedStatus,
                          onChanged: (value) => updateOrderStatus(value!),
                        ),
                      ),
                      ListTile(
                        title: Text('Delivered'),
                        leading: Radio<String>(
                          value: 'Delivered',
                          groupValue: selectedStatus,
                          onChanged: (value) => updateOrderStatus(value!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
