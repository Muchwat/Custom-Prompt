import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lengths {
  static var context;
  late MediaQueryData _mediaQueryData;

  Lengths(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  double padding16() {
    return _mediaQueryData.size.width * 0.044444444444444;
  }

  double width() {
    return _mediaQueryData.size.width;
  }

  double height() {
    return _mediaQueryData.size.height;
  }
}
