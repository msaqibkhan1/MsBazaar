import 'package:flutter/material.dart';


class CustmOutlinedButton extends StatelessWidget {
  final String title;
  final Color borderColor,textColor;
  final VoidCallback onTap;

  const CustmOutlinedButton(
      {super.key,
      required this.title,
      required this.borderColor,
        required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8, bottom: 12, top: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w700, fontSize: 16)
            ),
          ),
        ),
      ),
    );
  }
}
