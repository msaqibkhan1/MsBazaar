import 'package:flutter/material.dart';

class CustmTextField{
 static Widget custmTextField(
      {required String hintText,
      required Color color,
      required TextInputType textInputType,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText, labelText: hintText),
          ),
        ),
      ),
    );
  }
}