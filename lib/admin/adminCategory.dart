import 'package:elite_events/admin/adinPage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../colorsss.dart';
import 'adminSubCat.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => admin(),
        ));
      },child: Icon(Icons.add_rounded)),
      body: ListView.builder(
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          var category = categoriesList[index];
          return Column(
            children: [
              Container(
                color: Vx.blue50,
                child: ListTile(
                  title: Text(category,style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubcategoriesPage(
                            categoryId: category.toLowerCase()),
                      ),
                    );
                  },
                ),
              ),
              10.heightBox
            ],
          );
        },
      ),
    );
  }
}
