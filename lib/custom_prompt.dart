import 'dart:ui';
import 'package:customprompt/prompts/confirm.dart';
import 'package:customprompt/prompts/inputprompt.dart';
import 'package:customprompt/prompts/error.dart';
import 'package:customprompt/prompts/warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CustomPrompt {
  BuildContext context;
  Icon icon;
  String content;
  bool transparent;
  String type;
  Curve curve;
  int animDuration;
  String okayBtnText;
  String cancelBtnText;
  String title;
  Function onOkay;
  Function onCancel;
  Color color, btnOneColor, btnTwoColor;
  Text btnOneText, btnTwoText;

  /// {@tool snippet}
  /// Typically, custom_prompt will be used, as follows:
  ///
  /// ```dart
  /// CustomPrompt(
  //      animDuration: 500,
  //      title: 'Error',
  //      type: 'error',
  //      curve: Curves.easeInCubic,
  //      context: context,
  //      color: primary,
  //      content: 'An error occurred!',
  //      onOkay: logOut,
  //      onCancel: canceled
  //  ).alert();
  /// ```
  /// {@end-tool}
  ///
  /// The [color] defaults to white.
  /// The [animDuration] is animation time in milliseconds, defaults to 500.

  CustomPrompt({
    this.icon,
    @required this.context,
    @required this.type,
    this.animDuration = 500,
    this.transparent = false,
    this.color,
    this.title,
    this.btnOneText,
    this.btnTwoText,
    this.btnOneColor,
    this.btnTwoColor,
    @required this.content,
    this.curve = Curves.bounceOut,
    this.okayBtnText = 'Okay',
    this.cancelBtnText = "Cancel",
    this.onOkay, this.onCancel
  });

  alert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog(type: type),
    );
  }

  Widget input() => InputPrompt(
    icon: icon,
    color: color,
    title: title,
    transparent: transparent,
    animDuration: animDuration,
    animationCurve: curve,
    description: content,
    btnOneColor: btnOneColor,
    btnOneText: btnOneText,
    onOkay: onOkay,
  );

  Widget error() => Error(
    icon: icon,
    color: color,
    title: title,
    transparent: transparent,
    animDuration: animDuration,
    animationCurve: curve,
    description: content,
    btnOneColor: btnOneColor,
    btnOneText: btnOneText,
    onOkay: onOkay,
  );

  Widget warning() => Warning(
    icon: icon,
    color: color,
    title: title,
    transparent: transparent,
    animDuration: animDuration,
    animationCurve: curve,
    description: content,
    btnOneColor: btnOneColor,
    btnOneText: btnOneText,
    onOkay: onOkay,
  );

  Widget confirm() => Confirm(
    icon: icon,
    color: color,
    title: title,
    transparent: transparent,
    btnOneColor: btnOneColor,
    btnTwoColor: btnTwoColor,
    animDuration: animDuration,
    animationCurve: curve,
    description: content,
    btnOneText: btnOneText,
    btnTwoText: btnTwoText,
    onOkay: onOkay,
    onCancel: onCancel,
  );

  dialog({String type}) {
    switch(type) {
      case 'confirm':
        return confirm();
      case 'error':
        return error();
      case 'warning':
        return warning();
      case 'input':
        return input();
      default:
        return null;
    }
  }
}