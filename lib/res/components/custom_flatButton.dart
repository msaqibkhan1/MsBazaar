import 'package:flutter/material.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';

class CustmFlatButton extends StatelessWidget {
  final String title;
  final Color color, textColor;
  final VoidCallback onTap;

  const CustmFlatButton(
      {super.key,
      required this.title,
      required this.color,
      required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: MqSize.mqHeight(0.057, context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Center(
          child: Text(title,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
