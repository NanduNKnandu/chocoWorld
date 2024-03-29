import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_events/allExtract.dart';
import 'package:elite_events/colorsss.dart';
import 'package:elite_events/userDetail/editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../buy/myOrder.dart';
import '../homescreen/navigat.dart';
import 'AddAddress.dart';

import '../admin/tabbar.dart';
import 'address.dart';

class profilee extends StatefulWidget {
  const profilee({super.key});

  @override
  State<profilee> createState() => _profileeState();
}

class _profileeState extends State<profilee> {
  String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => bottomNavigat(),));
        return false;
      },
      child: Scaffold(
          backgroundColor: lightgrey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade800,
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData) {
                          var datas = snapshot.data!.data();
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                        child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              editt(data: datas),
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: whitecolor,
                                      ),
                                    ))),
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 40,
                                        foregroundImage:
                                            NetworkImage(datas!['image'])),
                                    10.widthBox,
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          datas!["name"],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          datas!["email"],
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                                    OutlinedButton(
                                        onPressed: () {
                                          signout(context);
                                          // mainn().signout(context);
                                        },
                                        child: Text("Log out")),
                                  ],
                                ),
                                20.heightBox,

                                20.heightBox,

                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => AddAddress(),
                                          ));
                                        },
                                        child: listProfile(
                                            leading: Icon(Icons.place),
                                            title: Text(
                                              "Address",
                                              style: TextStyle(
                                                  // color: Colors.orange.shade800
                                                  ),
                                            )),
                                      ),


                                      Divider(
                                        color: lightgrey,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => myOrder(),
                                            ));
                                          },
                                          child: listProfile(
                                              leading: Icon(
                                                Icons.shopping_bag_outlined,
                                              ),
                                              title: Text("orders"))),
                                      Divider(
                                        color: lightgrey,
                                      ),
                                      TextButton(
                                          onPressed: () {
 launch("tel://9876543210");
                                          },
                                          child: listProfile(
                                              leading: Icon(Icons.headphones),
                                          title: Text('Contact us')
                                          )),
                                      Divider(color: lightgrey,),
                                      TextButton(
                                          onPressed: () {

                                            SystemNavigator.pop();
                                          },
                                          child: listProfile(
                                              leading: Icon(
                                                Icons.exit_to_app,
                                              ),
                                              title: Text("Exit"))),
                                    ],
                                  ).box.white.shadowSm.rounded.make(),
                                )
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
