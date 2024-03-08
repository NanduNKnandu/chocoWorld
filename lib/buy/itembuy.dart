import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/buy/orderModelClass.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../homescreen/category/orderconfirm.dart';
import '../userDetail/AddAddress.dart';
import '../userDetail/address.dart';
import '../userDetail/change address.dart';

class ItemBuy extends StatefulWidget {
  const ItemBuy({
    Key? key,
    this.title,
    this.imageUrl,
    required this.price,
    this.description,
    this.userId,
  }) : super(key: key);

  final String? title;
  final String? imageUrl;
  final String price;
  final String? description;
  final String? userId;

  @override
  State<ItemBuy> createState() => _ItemBuyState();
}

class _ItemBuyState extends State<ItemBuy> {
  String userName = "";
  int selectedQuantity = 1;
  bool Address = false;




  void showQuantityPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Select Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    final quantity = index + 1;
                    return ListTile(
                      title: Text('$quantity'),
                      onTap: () {
                        setState(() {
                          selectedQuantity = quantity;
                          print(selectedQuantity);
                        });
                        Navigator.pop(context);
                      },
                      selected: selectedQuantity == quantity,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    fetchUserName();
    checkUserAddress();
  }
  void checkUserAddress() async{
    String userId=FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
    if(userSnapshot.exists && userSnapshot.data() != null){
      bool userhasaddress=userSnapshot['Address'] !=null;
      setState(() {
        Address = userhasaddress;
      });
    } else {
      setState(() {
        Address=false;
      });
    }


  }

  Future<bool> getLocation() async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Address")
        .get();
    if (data.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> fetchUserName() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      print("User snapshot data: ${userSnapshot.data()}");

      if (userSnapshot.exists) {
        setState(() {
          userName = userSnapshot['name'];
        });
        print("User name: $userName");
      } else {
        print("User document does not exist");
      }
    } catch (error) {
      print("Error fetching user's name: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Order Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return Text("No Data Found");
          } else {
            var items = snapshot.data!.docs;
            double itemPrice = selectedQuantity * double.parse(widget.price);
            double deliveryAmound = 30;
            double totalAmount = itemPrice + deliveryAmound;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddressPage(),
                                          ));
                                    },
                                    child: Text(
                                      "Change",
                                      style: TextStyle(
                                        color: Colors.blue.shade900,
                                      ),
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
                  const SizedBox(height: 20),
                  Container(
                    height: 70,
                    child: ListTile(
                      leading: Image(
                        image: NetworkImage(widget.imageUrl!),
                      ),
                      title: Text(widget.title!),
                    ),
                  ),
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        customListTile(
                          leadingText: 'Item Price',
                          trailingText: itemPrice.toString(),
                        ),
                        customListTile(
                          leadingText: "Delivery amount",
                          trailingText: "30",
                        ),
                        const Divider(),
                        customListTile(
                          leadingText: "Total",
                          trailingText: "$totalAmount",
                        ),
                        TextButton(
                            onPressed: () {
                              showQuantityPicker();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Qty: $selectedQuantity  ",
                                  style: TextStyle(color: Colors.black),
                                ).box.roundedFull.make(),
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.black26,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: FutureBuilder(
          future: getLocation(),
          builder: (BuildContext context, AsyncSnapshot<bool>snapshot) {
            if(snapshot.hasData) {
              bool address = snapshot.data!;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible:
                        false,
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
                            actions: <Widget>[
                              TextButton(
                                child: Text('Go Back'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () async {
                                  if(address== false){
                                    Fluttertoast.showToast(
                                        msg: "please add your address");
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAddress(),));
                                  } else {
                                    OrderBuy order = OrderBuy(
                                        itemName: widget.title!,
                                        itemImageUrl: widget.imageUrl!,
                                        quantity: selectedQuantity,
                                        itemPrice: double.parse(widget.price),
                                        deliveryAmount: 30,
                                        totalAmount: double.parse(widget.price) *
                                            selectedQuantity +
                                            30);

                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(
                                        FirebaseAuth.instance.currentUser!.uid)
                                        .collection('orders')
                                        .add({
                                      'itemName': order.itemName,
                                      'itemImageUrl': order.itemImageUrl,
                                      'quantity': order.quantity,
                                      'itemPrice': order.itemPrice,
                                      'deliveryAmount': order.deliveryAmount,
                                      'totalAmount': order.totalAmount,
                                    });
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          OrderConfirmationPage(
                                            order: order,
                                          ),

                                    ));

                                  }








                                   // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            } else{
 return const SizedBox();
            }
          }
        ),
      ),
    );
  }
}

Widget customListTile({
  required String leadingText,
  required String trailingText,
}) {
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