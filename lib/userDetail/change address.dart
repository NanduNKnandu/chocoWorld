import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/buy/orderModelClass.dart';
import 'package:elite_events/homescreen/category/orderconfirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colorsss.dart';
import 'AddAddress.dart';
import 'address.dart';

class changeADdress extends StatefulWidget {
  const changeADdress({super.key, required this.order});
  final OrderBuy order;

  @override
  State<changeADdress> createState() => _changeADdressState();
}

class _changeADdressState extends State<changeADdress> {
  int selectedAddressIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgrey,
      appBar: AppBar(
        title: Text(
          "My Address",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddressPage()));
              },
              child: Text(
                "+ Add a new address",
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          50.heightBox,
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Address")
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot2.hasData || snapshot2.data!.docs.isEmpty) {
                  return "No addresses found.".text.makeCentered();
                } else if (snapshot2.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot2.data!.docs.length,
                        itemBuilder: (context, index) {
                          var address = snapshot2.data!.docs[index];

                          return Column(
                            children: [
                              Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RadioListTile(
                                    value: index,
                                    groupValue: selectedAddressIndex,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAddressIndex = value!;
                                      });
                                    },
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(address['Name']),
                                        Text(
                                            "${address["houseNO"]},${address['Pincode']},${address['city']},${address['state']}"),
                                        Text("${address["PhoneNumber"]}")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              10.heightBox,
                            ],
                          );
                        }),
                  );
                } else {
                  return SizedBox();
                }
              }),
          15.heightBox,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedAddressIndex == -1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select Address'),
                  content: Text('Please select an address before proceeding.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Order'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Do you want to confirm your order?'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        String orderId = FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('orders')
                            .doc()
                            .id;
                        var addressData = await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("Address")
                            .get();
                        var selectedAddress =
                            addressData.docs[selectedAddressIndex];

                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('orders')
                            .doc(orderId)
                            .set({
                          'orderId': orderId,
                          'itemName': widget.order.itemName,
                          'itemImageUrl': widget.order.itemImageUrl,
                          'quantity': widget.order.quantity,
                          'itemPrice': widget.order.itemPrice,
                          'deliveryAmount': widget.order.deliveryAmount,
                          'totalAmount': widget.order.totalAmount,
                          'status' : 'Order Confirmed',
                          'address': {
                            'Name': selectedAddress['Name'],
                            'PhoneNumber': selectedAddress['PhoneNumber'],
                            'Pincode': selectedAddress['Pincode'],
                            'state': selectedAddress['state'],
                            'city': selectedAddress['city'],
                            'houseNO': selectedAddress['houseNO'],
                          },
                        });


                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderConfirmationPage(
                            order: OrderBuy(
                              orderId: orderId,
                              itemName: widget.order.itemName,
                              itemImageUrl: widget.order.itemImageUrl,
                              quantity: widget.order.quantity,
                              itemPrice: widget.order.itemPrice,
                              deliveryAmount: widget.order.deliveryAmount,
                              totalAmount: widget.order.totalAmount,
                              status: '',
                              deliveryAddress: Address(
                                  name: selectedAddress['Name'],
                                  phoneNumber: selectedAddress['PhoneNumber'],
                                  houseNo: selectedAddress['houseNO'],
                                  city: selectedAddress['city'],
                                  state: selectedAddress['state'],
                                  pincode: selectedAddress['Pincode'])
                            ),
                          ),
                        ));
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
