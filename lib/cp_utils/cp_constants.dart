import 'package:flutter/material.dart';

const cp_error = Color(0xffd50000);
const cp_warning = Color(0xffff9900);
const cp_primary = Color(0xff2d8cf0);
const cp_success = Color(0xff19be6b);
const cp_white = Color(0xffffffff);

const errorTitle = 'Error';
const successTitle = 'Success';
const confirmTitle = 'Confirm';
const warningTitle = 'Warning';
const okText = 'Okay';
const cancelText = 'Cancel';
const inputTitle = 'Enter email';
const inputText = 'Submit';

const textBtnLight = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
const textBtnDark = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

Color? bgColor(Color? color, bool? transparent, dynamic type) {
  if (color != null && transparent!) {
    return color.withOpacity(0.3);
  } else if (color != null && !transparent!) {
    return color;
  }

  if (color == null && transparent!) {
    return type.withOpacity(0.3);
  } else if (color == null && !transparent!) {
    return type;
  }

  return type;
}
