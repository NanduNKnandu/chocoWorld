import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colorsss.dart';

import 'adminDealofTheday.dart';

import 'menuItemSubcat.dart';

class menuItms extends StatelessWidget {
  const menuItms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => adminDealOf(),
        ));
        
      },child: Icon(Icons.add_rounded),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          var category = menuItems[index];
          return Column(
            children: [
              Container(
                color: Vx.blue50,
                child: ListTile(
                  title: Text(category,style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => menuItemSubcat(
                          categoryId: category.toLowerCase(),
                        ),
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
