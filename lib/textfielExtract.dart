import 'package:flutter/material.dart';

TextField buildTextField({
  required TextEditingController controller,
  required String hint,
  TextInputType keyboardType = TextInputType.text, // Default to text type
  bool showborder = true,
  required Color colors,
}) {
  return TextField(
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: colors),
      border: showborder
          ? OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      )
          : InputBorder.none,
    ),
  );
}
