import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/colorsss.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'address.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
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
              child: Row(
                children: [ Icon(Icons.edit),
                  Text(
                    " + Add New Addres",
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
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
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          15.widthBox,
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Confirem Deletion"),
                                                      content: Text(
                                                          "Are you sure you want to delete this Address?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "Users")
                                                                  .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                                  .collection(
                                                                  "Address")
                                                                  .doc(address
                                                                  .id)
                                                                  .delete();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                            Text("Delete")),
                                                        Spacer(),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                            Text("Cancel")),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: fontgrey,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                      Text(address['Name'],style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(
                                          "${address["houseNO"]},${address['Pincode']},${address['city']},${address['state']}"),
                                      Text("${address["PhoneNumber"]}")
                                    ],
                                  ),
                                ),
                              ).box.rounded.shadow.red50.make(),

                              10.heightBox,
                            ],
                          );
                        }),
                  );
                } else {
                  return SizedBox();
                }
              }),
          15.heightBox
        ],
      ),
    );
  }
}