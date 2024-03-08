import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin/tabbar.dart';
import 'homescreen/navigat.dart';
import 'loginpage.dart';

class splashh extends StatefulWidget {
  const splashh({super.key});

  @override
  State<splashh> createState() => _splashhState();
}

class _splashhState extends State<splashh> {
bool blur=true;
  @override
  void initState() {

    Timer(Duration(seconds: 7), () {
      if(FirebaseAuth.instance.currentUser!=null){
        if(FirebaseAuth.instance.currentUser!.uid=="e3Bn1AZ3uFSQNoe0BcsjKDokwe73"){
          print(FirebaseAuth.instance.currentUser!.uid);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminTabPage(),));
        }
        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => bottomNavigat(),));
        }
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginn(),));
      }

    });
    

    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/chcocsplash.jpg"),
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low,
          colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken,))),
      child: BackdropFilter(
        filter: blur? ImageFilter.blur(sigmaX: 4.0,sigmaY: 2.0): ImageFilter.blur(sigmaX: 1.0,sigmaY: 1.0),
        child: const Stack(
          children: [

            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choco world",style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
                  Text("Chocolate shop",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
