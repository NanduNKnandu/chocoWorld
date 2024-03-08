import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'loginpage.dart';

Widget cartContainer({ String? count, String? titlee}){
  return  Center(
    child: Column(
children: [
  15.heightBox,
    titlee!.text.black.make(),
    5.heightBox,
    count!.text.black.make(),

],
).box.white.rounded.width(100).height(80).shadow.make(),
  );
}


Widget  listProfile({required leading, title,subtitile}){
  return ListTile(
leading: leading,
    title: title,
    subtitle: subtitile,
  );
}
signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
      (context),
      MaterialPageRoute(
        builder: (context) => loginn(),
      ));
}