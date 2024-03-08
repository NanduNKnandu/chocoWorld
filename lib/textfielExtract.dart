import 'package:flutter/material.dart';

TextField buildTextField({required controller,  required String hint,bool showborder = true,required Color colors}) {
  return TextField(
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: colors),
        border: showborder? OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius: BorderRadius.circular(8.0),
  ) :InputBorder.none,
    )
  );
}



//dont dltttt