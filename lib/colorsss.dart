import 'package:elite_events/homescreen/dealofthed'
    'ay.dart';
import 'package:elite_events/userDetail/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final  Color textfieldgrey=Color.fromRGBO(209, 209, 209, 1);
final Color fontgrey=Color.fromRGBO(107, 115, 119, 1);
final Color darkfontgreay= Color.fromRGBO(62, 68, 71, 1);
final Color whitecolor=Color.fromRGBO(255, 255, 255, 1);
final Color lightgrey=Color.fromRGBO(239, 239, 239, 1);
final Color redcolor=Color.fromRGBO(230, 46, 4, 1);
Color chocolateColor = Color(0xFFD0AA71);


const dealOfTheDay ="deal of the day" , flashsale="flash sales",Tbrand="special Picks",editors="Editor's Choice";
const menuItems=[
  dealOfTheDay,flashsale,Tbrand,editors
];

const random="asset/donut.png",random1="asset/flashSale.png";

const category="categories",  topseller="top sellers";
const categories="asset/lottie/categories.json", brand1= "asset/lottie/brand.json", brand= "asset/lottie/bulb.json";



const milkchoclate="milk choclates", chocolateBars="chocolate bars", darkChocklate="dark chocloates", chocCAndies="choclate candies",customizableChoc="customized ",
    tuffle="tuffles", hotChoco="hot chocolates",drinkChoco="drinks",whitechoco="white chocolates";

//
const categoriesList=[
  milkchoclate,darkChocklate,whitechoco,chocolateBars,chocCAndies,drinkChoco,hotChoco,tuffle,customizableChoc
];
final sliderlist = ["asset/chocl.jpg", "asset/offer.png", "asset/banner.png"];

String UserId=FirebaseAuth.instance.currentUser!.uid;
const categoriesImage=[
  "asset/milkChoc.png",
  "asset/darkChoco.png",
  "asset/whitechoc.png",
  "asset/chocobar.png",
  "asset/candy.png",
  "asset/chocodrink.png",
  "asset/hotchoc.png",
  "asset/chocbrand.png",
  "asset/custom.png",
];