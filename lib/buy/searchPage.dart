import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsPage extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imageUrl;

  ItemDetailsPage({
    required this.itemName,
    required this.itemPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $itemName'),
            Text('Price: $itemPrice'),
            Text('Description: $imageUrl'),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  void handleSearch(String brandName, BuildContext context) {
    FirebaseFirestore.instance
        .collection('items') // Replace 'items' with your collection name
        .where('brand', isEqualTo: brandName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {

        QueryDocumentSnapshot document = querySnapshot.docs.first;

        String itemName = document['name'];
        String itemPrice = document['itemprice'];
        String imageUrl = document['description'];

        // Navigate to a new page with details
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailsPage(
            itemName: itemName,
            itemPrice: itemPrice,
            imageUrl: imageUrl,
          ),
        ));
      } else {

        print('No matching items found for brand: $brandName');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Data Available'),
              content: Text('No matching items found for brand: $brandName'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter brand name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                handleSearch(searchController.text, context);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

