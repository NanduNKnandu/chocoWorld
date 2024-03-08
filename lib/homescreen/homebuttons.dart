import 'package:elite_events/colorsss.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';





//dont deleteeeee



Widget homeButton({width, height,  icon, title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26,),
      Text(
        title,
        style: TextStyle(fontSize: 16.0),
      ),
    ],
  ).box.rounded.white.size(width, height).shadow.make();
}

Widget homeButton1({width, height,  lottie, title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Lottie.asset(lottie,width: 40),
      Text(
        title,
        style: TextStyle(fontSize: 16.0),
      ),
    ],
  ).box.rounded.white.size(width, height).shadow.make();
}