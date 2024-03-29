import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/admin/subcatedit.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class menuItemSubcat extends StatelessWidget {
  const menuItemSubcat({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryId,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("dealoftheday")
            .where("catId", isEqualTo: categoryId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text("No subcategories found.");
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var subcategory = snapshot.data!.docs[index];
              return Column(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Vx.blue50,
                    child: ListTile(
                      title: Row(
                        children: [
                          SizedBox(height: 80,
                              width: 80,
                              child: CachedNetworkImage(imageUrl: subcategory['image'])),
                          Expanded(
                            child: Text(
                              subcategory['name'], overflow: TextOverflow.ellipsis,maxLines: 5,
                              style: TextStyle(
                            
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditPage(
                                  categoryId: categoryId,
                                  subcategoryId: subcategory.id,
                                ),
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm Deletion"),
                                    content: Text(
                                        "Are you sure you want to delete this subcategory?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("dealoftheday")
                                              .doc(subcategory.id)
                                              .delete();
                                          Navigator.of(context).pop();
                                          print("delete success");
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subcategory['price'],
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  20.heightBox
                ],
              );
            },
          );
        },
      ),
    );
  }
}
