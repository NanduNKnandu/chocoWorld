import 'package:elite_events/colorsss.dart';
import 'package:elite_events/homescreen/category/subcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../userDetail/profile.dart';

class categoriess extends StatefulWidget {
  const categoriess({super.key});

  @override
  State<categoriess> createState() => _categoriessState();
}

class _categoriessState extends State<categoriess> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgrey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "categories",
          style: TextStyle(color: whitecolor),
        ),
      ),
      body: Stack(
        children: [
          Lottie.asset(
            "asset/lottie/background.json",
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: GridView.builder(

              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 220,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>subcat(catId: categoriesList[index].toLowerCase()) ,));
                  },
                  child: Column(
                    children: [
                      25.heightBox,
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(categoriesImage[index])),
                      Text(
                        categoriesList[index],
                        style: TextStyle(
                            color: darkfontgreay, fontWeight: FontWeight.bold),
                      )
                    ],
                  ).box.rounded.white.clip(Clip.antiAlias).outerShadowSm.make(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
