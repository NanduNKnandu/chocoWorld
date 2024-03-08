import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elite_events/userDetail/profile.dart';
import 'package:elite_events/homescreen/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../admin/admincart.dart';
import 'category/categories.dart';

class bottomNavigat extends StatefulWidget {
  const bottomNavigat({super.key});

  @override
  State<bottomNavigat> createState() => _bottomNavigatState();
}

class _bottomNavigatState extends State<bottomNavigat> {
  int index = 0;
  final pages=[
    homee(), categoriess(),CartPage(cartItems: [],),profilee(),
  ];

  final itemList = <Widget>[
    Lottie.asset("asset/lottie/Animation - Home.json",width: 35,repeat: false),
    Lottie.asset("asset/lottie/categories.json",width: 36,repeat: false),
    GestureDetector(child: Lottie.asset("asset/lottie/cart.json",width: 36,repeat: false)),


    GestureDetector(child: Lottie.asset("asset/lottie/profile.json",width: 35,repeat: false))
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (value){
            setState(() {
              index=value;
            });
          },
          items: itemList,
          height: 55,
          index: index,
          backgroundColor: Colors.transparent,
        ),
        body: pages[index],
      ),
    );
  }
}
