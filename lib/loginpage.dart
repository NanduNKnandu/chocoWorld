import 'package:elite_events/admin/adinPage.dart';
import 'package:elite_events/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'admin/tabbar.dart';
import 'homescreen/navigat.dart';



class loginn extends StatefulWidget {

  loginn({super.key});

  @override
  State<loginn> createState() => _loginnState();
}

class _loginnState extends State<loginn> {
  final emailcontro = TextEditingController();

  final passcontro = TextEditingController();

  bool isPasswordVisible = false;

  loggin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        String userid = userCredential.user!.uid;
        if (userid == "e3Bn1AZ3uFSQNoe0BcsjKDokwe73") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminTabPage(),));
        } else {



        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return bottomNavigat();
            }));
      }
      }
    } on FirebaseAuthException catch (logerror) {
      print("+++++${logerror}");
      if (logerror.code == "invalid-email") {
        return Fluttertoast.showToast(
            msg: "The email address is badly formatted.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.purple.shade100,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (logerror.code == "INVALID_LOGIN_CREDENTIALS") {
        return Fluttertoast.showToast(
            msg: "Please check your email address or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.purple.shade100,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                 Image(
                     height: 200,
                     image: AssetImage("asset/playstore.png")),
                  const SizedBox(
                    height: 85,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.purple.shade100),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontro,

                      decoration: const InputDecoration(
                          labelText: "  email address",
                          labelStyle: TextStyle(color: CupertinoColors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.purple.shade100),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passcontro,
                      obscureText: !isPasswordVisible,
                      decoration:  InputDecoration(
                          suffixIcon: IconButton(icon:  Icon(isPasswordVisible? Icons.visibility:Icons.visibility_off),onPressed: () {
setState(() {
  isPasswordVisible=!isPasswordVisible;
});
                          },),
                          labelText: "  password",
                          labelStyle: TextStyle(color: CupertinoColors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: TextButton(
                          onPressed: () {
                            loggin(
                                context: context,
                                email: emailcontro.text,
                                password: passcontro.text);
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgotten password?",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      )),
                  const SizedBox(
                    height: 150,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return loginn();
                      }));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return signup();
                              },
                            ));
                            signup();
                          },
                          child: Text(
                            "create new account",
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
