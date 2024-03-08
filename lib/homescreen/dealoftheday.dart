import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/homescreen/menuitemdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../colorsss.dart';
import 'category/item_detail.dart';

class dealoftheday extends StatelessWidget {
  const dealoftheday({Key? key, this.catId}) : super(key: key);
  final String? catId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          catId!,
          style: TextStyle(color: whitecolor),
        ),
      ),
      backgroundColor: lightgrey,
      body: Stack(
        children: [
          Lottie.asset("asset/lottie/background.json"),
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("dealoftheday")
                    .where("catId", isEqualTo: catId?.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  print("Debug: catId = $catId");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text("No items found.");
                  }
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => menuitembuy(
                                price: product['price'],
                                description: product['description'],
                                imageUrl: product['image'],
                                titile: product['name']),
                          ));
                        },
                        child: Column(
                          children: [
                            10.heightBox,
                            Container(
                              height: 150,
                              width: 150,
                              child: CachedNetworkImage(
                             imageUrl:    product['image'],
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product['name']),
                            ),
                            5.heightBox,
                            Padding(
                              padding: const EdgeInsets.only(right: 100),
                              child: Text(
                                " \u20B9 ${product['price']}",
                                style: TextStyle(color: redcolor),
                              ),
                            )
                          ],
                        ).box.rounded.white.shadowSm.make(),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
