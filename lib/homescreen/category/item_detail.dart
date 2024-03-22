import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/buy/itembuy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../admin/admincart.dart';
import '../../colorsss.dart';

class itemDetail extends StatefulWidget {
  itemDetail({
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
  State<itemDetail> createState() => _itemDetailState();
  static final GlobalKey<_itemDetailState> itemDetailKey =
      GlobalKey<_itemDetailState>();
}

class _itemDetailState extends State<itemDetail> {
  bool isInCart = false;
  bool Address = false;

  CollectionReference cartItems = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCartStatus();
    checkUserAddress();
  }

  void checkUserAddress() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
    if (userSnapshot.exists && userSnapshot.data() != null) {
      bool userhasaddress = userSnapshot['Address'] != null;
      setState(() {
        Address = userhasaddress;
      });
    } else {
      setState(() {
        Address = false;
      });
    }
  }

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
                        builder: (context) =>  CartPage(
                          cartItems: [],
                        ),
                      ));
                    },
                    icon:  Icon(
                      CupertinoIcons.cart,
                      color: Colors.white,
                    )),
                15.widthBox,
              ],
              backgroundColor: Colors.deepOrangeAccent,
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:  EdgeInsets.only(top: 100),
                        child: Container(
                          color: lightgrey,
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: Image(image: NetworkImage(widget.imageUrl!)),
                        ).box.make(),
                      ),
                    ),
                  ],
                ).box.make(),
                20.heightBox,
                Padding(
                  padding:  EdgeInsets.only(left: 28.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\u20B9 ${widget.price}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                    child: Text(
                      widget.description,
                      style:
                          TextStyle(color: CupertinoColors.black, fontSize: 15),
                    ),
                  ),
                ),
                25.heightBox,
                Container(
                  child: Row(
                    children: [
                      isInCart
                          ? InkWell(
                              onTap: () {
                                goToCart();
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Go To Cart",
                                    style: TextStyle(
                                        color: fontgrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                width: 155,
                                color: Colors.white,
                              ),
                            )
                          : InkWell(
                              onTap: addtoCart,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                      color: fontgrey,
                                      fontWeight: FontWeight.bold,
                                    ),
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
        });
  }

  Future<void> checkCartStatus() async {
    try {
      String userid = FirebaseAuth.instance.currentUser!.uid;
      var querySnapshot = await cartItems
          .where("userId", isEqualTo: userid)
          .where("title", isEqualTo: widget.titile)
          .get();
      setState(() {
        isInCart = querySnapshot.docs.isNotEmpty;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> addtoCart() async {
    String userid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userid)
        .collection("cart")
        .add({
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
