import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../colorsss.dart';
import 'item_detail.dart';

class subcat extends StatelessWidget {
  const subcat({Key? key, this.catId}) : super(key: key);
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("items")
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => itemDetail(
                                titile: product["name"],
                                price: product['price'],
                                imageUrl: product['image'],
                                description: product['description'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            10.heightBox,
                            Container(
                              height: 150,
                              width: 150,
                              child: CachedNetworkImage(
                                imageUrl: product['image'],
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Container(alignment: Alignment.center,child: CircularProgressIndicator(),),
                              ),
                            ),
                            10.heightBox,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product['name'],overflow: TextOverflow.ellipsis,maxLines: 2,),
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
