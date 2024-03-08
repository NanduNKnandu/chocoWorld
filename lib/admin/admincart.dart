import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/homescreen/category/item_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Stream<QuerySnapshot> cartitemsShow;
  late String currentUserUid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    cartitemsShow = FirebaseFirestore.instance
        .collection("cart")
        .where("userId",
            isEqualTo: currentUserUid)
        .snapshots();
  }

  Future<void> delete(var documentId) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder(
          stream: cartitemsShow,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available');
            } else {
              var cartItems = snapshot.data!.docs;
              if(cartItems.isEmpty){
                return Center(child: Text("no items in the cart"),);
              }
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var cartItem =
                      cartItems[index].data() as Map<String, dynamic>;
                  var documentId = cartItems[index].id;
                  return ListTile(
                    title: Text(cartItem["title"] ?? "Title not available"),
                    subtitle: Text(
                        'Price: ${cartItem["price"] ?? "Price not available"}'),
                    leading: Image.network(cartItem["imageUrl"] ?? ""),
                    trailing: IconButton(
                        onPressed: () {
                          delete(documentId);
                        },
                        icon: Icon(CupertinoIcons.delete)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => itemDetail(
                            titile: cartItem["title"] ?? "Title not available",
                            imageUrl: cartItem["imageUrl"] ?? "",
                            price: cartItem["price"] != null
                                ? cartItem["price"].toString()
                                : "Price not available",
                            description: cartItem["description"] ??
                                "Description not available",
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }),
    );
  }
}
