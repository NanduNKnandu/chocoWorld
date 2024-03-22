import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/buy/itembuy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../admin/admincart.dart';
import '../../colorsss.dart';

class menuitembuy extends StatefulWidget {
  menuitembuy({
    Key? key,
    this.titile,
    this.imageUrl,
    required this.price,
    required this.description,
  }) : super(key: key);

  final String? titile;
  final String? imageUrl;
  final String price;
  final String description;

  @override
  State<menuitembuy> createState() => _menuitembuyState();
  static final GlobalKey<_menuitembuyState> menuitembuyKey =
  GlobalKey<_menuitembuyState>();
}

class _menuitembuyState extends State<menuitembuy> {
  bool isInCart = false;

  CollectionReference cartItems = FirebaseFirestore.instance.collection('cart');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: lightgrey,
            appBar: AppBar(
              title: Text(
                widget.titile!,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CartPage(
                          cartItems: [],
                        ),
                      ));
                    },
                    icon: Icon(
                      CupertinoIcons.cart,
                      color: Colors.white,
                    )),
                15.widthBox,
              ],
              backgroundColor: Colors.orange,
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Container(
                          color: lightgrey,
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: CachedNetworkImage(imageUrl: widget.imageUrl!),
                        ).box.make(),
                      ),
                    ),
                  ],
                ).box.make(),
                20.heightBox,
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\u20B9 ${widget.price}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      VxRating(
                        normalColor: Colors.grey,
                        selectionColor: Colors.orange,
                        onRatingUpdate: (value) => 2,
                      )
                    ],
                  ),
                ),
                20.heightBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(color: CupertinoColors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                25.heightBox,
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          isInCart ? goToCart() : addtoCart();
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              isInCart ? "Go To Cart" : "Add To Cart",
                              style: TextStyle(
                                  color: fontgrey, fontWeight: FontWeight.bold),
                            ),
                          ),
                          width: 155,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ItemBuy(
                                price: widget.price,
                                imageUrl: widget.imageUrl,
                                title: widget.titile,
                                description: widget.description),
                          ));
                        },
                        child: Container(
                          width: 155,
                          color: Colors.yellow,
                          child: Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: fontgrey, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: 310,
                  height: 70,
                  color: lightgrey,
                ).box.shadowSm.make(),
                20.heightBox,
              ],
            ),
          );
        }
    );
  }



  Future<void> checkCartStatus() async {
    var querySnapshot = await cartItems.get();
    setState(() {
      isInCart =
          querySnapshot.docs.any((doc) => doc['titile'] == widget.titile);
    });
  }

  Future<void> addtoCart() async {
    await cartItems.add({
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "title": widget.titile,
      'imageUrl': widget.imageUrl,
      'price': widget.price,
      'description': widget.description
    });

    setState(() {
      isInCart = true;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("item added to cart")));
  }

  void goToCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: []),
      ),
    );
  }
}
