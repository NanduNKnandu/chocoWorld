import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ]));
}