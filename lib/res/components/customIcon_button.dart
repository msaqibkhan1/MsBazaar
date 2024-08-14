import 'package:flutter/material.dart';

class CustmIconButton extends StatelessWidget {
  final Color color, iconColor;
  final VoidCallback onTap;
  final IconData iconData;

  const CustmIconButton(
      {super.key,
      required this.color,
      required this.iconColor,
      required this.onTap,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          iconData,
          color: iconColor,
          size: 21,
        ),
      ),
    );
  }
}
