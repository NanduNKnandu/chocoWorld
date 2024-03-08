import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'brandItems.dart';

class brands extends StatelessWidget {
  const brands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("brand").snapshots(),
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
                          builder: (context) =>
                              brandItems(brand: product['brandName']),
                        )),
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Text(
                              product['brandName'],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                            // Image(image: NetworkImage(product['image']))

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
              ),
            );
          }),
    );
  }
}
