

import 'package:flutter/cupertino.dart';

class MqSize {
  static double mqHeight(double height, BuildContext context) {
    return MediaQuery.of(context).size.height * height;
  }

  static double mqWidth(double width, BuildContext context) {
    return MediaQuery.of(context).size.height * width;
  }
}
