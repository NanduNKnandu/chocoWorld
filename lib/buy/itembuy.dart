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
            double itemPrice = selectedQuantity * double.parse(widget.price);
            double deliveryAmound = 30;
            double totalAmount = itemPrice + deliveryAmound;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

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
        child: Row(
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
                    onPressed: () async{
                      OrderBuy order = OrderBuy(orderId: '',
                          itemName: widget.title!,
                          itemImageUrl: widget.imageUrl!,
                          quantity: selectedQuantity,
                          itemPrice: double.parse(widget.price),
                          deliveryAmount: 30,
                          totalAmount: double.parse(widget.price) *
                              selectedQuantity +
                              30, status: '');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => changeADdress(order:order ),));

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,color: Colors.white
                      ),
                    ),
                  ),
                ],
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