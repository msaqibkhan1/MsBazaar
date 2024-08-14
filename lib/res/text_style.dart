import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle appBar = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22);
  static TextStyle appBarGrey = const TextStyle(
      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 11);
  static TextStyle heading1 = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16);
  static TextStyle greyText = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bottomNavigation =
      const TextStyle(fontWeight: FontWeight.w600);
  static TextStyle italicBanner = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontStyle: FontStyle.italic);
  static TextStyle banner = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
}
