import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colorsss.dart';
import 'category/item_detail.dart';

class brandItems extends StatelessWidget {
  final String brand;
  const brandItems({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("items")
              .where("brand", isEqualTo: brand)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text('error ${snapshot.error}');
            }
            var items = snapshot.data?.docs ?? [];
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var product = items[index].data() as Map<String, dynamic>;
                return SizedBox(
                  height: 150,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => itemDetail(
                            description: product["description"],
                            price: product['price'],
                            titile: product['name'],
                            imageUrl: product["image"],
                          ),
                        )),
                        child: Column(
                          children: [
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: Image(
                                    image: NetworkImage(product['image']))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product['name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 100.0),
                              child: Text(
                                " \u20B9 ${product['price']}",
                                style: TextStyle(color: redcolor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).box.rounded.white.shadow.make(),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300),
            );
          }),
    );
  }
}
