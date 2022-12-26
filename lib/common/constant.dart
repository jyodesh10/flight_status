import 'package:flutter/material.dart';

mixin Appcolors {
  static const grey = Color.fromRGBO(189, 189, 189, 1);
  static const black = Color.fromARGB(255, 57, 57, 57);
  static const red = Color.fromARGB(255, 184, 38, 38);
}

TextStyle get subtitleStyle {
  return const TextStyle(
      fontSize: 14.5, fontWeight: FontWeight.w300, color: Colors.black);
}

TextStyle get headingStyle {
  return const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
}
