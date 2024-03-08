import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/textfielExtract.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'colorsss.dart';
import 'homescreen/navigat.dart';
import 'loginpage.dart';

class signup extends StatelessWidget {
TextEditingController emailcontro=TextEditingController();
TextEditingController namecontro=TextEditingController();
TextEditingController passcontro=TextEditingController();
TextEditingController phonecontro=TextEditingController();



loggin({required String email, required String password,required BuildContext context})async{
  try{
    final login= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    if(login.user!=null){
      await FirebaseFirestore.instance.collection("Users").doc(login.user!.uid).set({
        "name":namecontro.text,
        "email":emailcontro.text,
        "phone number":phonecontro.text,
        "id" :login.user!.uid,
        "image":"https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_960_720.png",

      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return bottomNavigat();
      })).then((_) {
        SystemNavigator.pop();
      });

    }
  }on FirebaseAuthException catch(loginerror){
    print("========${loginerror}");
    if(loginerror.code=="invalid-email"){
      return Fluttertoast.showToast(msg: "Please Check Your Email Address",
        toastLength:Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 15,


      );

    } if(loginerror.code=="weak-password"){
      return Fluttertoast.showToast(msg: "Password should be at least 6 characters",
        toastLength:Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 15,


      );
    }
    if(loginerror.code=="email-already-in-use"){
      return Fluttertoast.showToast(msg: "Email id already in use",toastLength: Toast.LENGTH_SHORT,backgroundColor:Colors.blue,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 15,
      );

    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [


          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Image(
                  height: 200,
                  image: AssetImage("asset/playstore.png")),
              SizedBox(height: 50,),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple.shade100),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  controller: namecontro,
                  decoration: const InputDecoration(
                      hintText: "  Enter your name",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple.shade100),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: buildTextField(controller: emailcontro, hint: "eamail address",showborder: false, colors: fontgrey),
              ),
              SizedBox(height: 15,),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple.shade100),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: phonecontro,
                  decoration: const InputDecoration(
                      hintText: "  Phone No",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple.shade100),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passcontro,
                  decoration: const InputDecoration(
                      hintText: "  Password",
                      labelStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 40,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Center(
                  child: InkWell(
                      onTap: () {
                        loggin(email: emailcontro.text, password: passcontro.text, context: context);
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ), ],
      ),
    );
  }

  
}
