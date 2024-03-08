import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class infocard extends StatelessWidget {
  const infocard({
    super.key, required this.name, required this.email,
  });
  final String name, email;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(name,style: TextStyle(color: Colors.white),),
      subtitle: Text(email,style: TextStyle(color: Colors.white)),
    );
  }
}
