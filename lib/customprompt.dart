import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'prompts/inputprompt.dart';
import 'prompts/confirm.dart';
import 'prompts/error.dart';
import 'prompts/warning.dart';
import 'prompts/success.dart';

class CustomPrompt {
  BuildContext context;
  Icon? icon;
  bool transparent;
  Curve curve;
  int animDuration;
  String? okayBtnText, cancelBtnText, title, content, type, inputHint;
  Function? btnOneOnClick, btnTwoOnClick;
  Color? color, btnOneColor, btnTwoColor;
  Text? btnOneText, btnTwoText;

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
    required this.context,
    required this.type,
    this.animDuration = 500,
    this.transparent = false,
    this.color,
    this.title,
    this.btnOneText,
    this.btnTwoText,
    this.btnOneColor,
    this.btnTwoColor,
    this.inputHint = 'Enter your email...',
    this.content,
    this.curve = Curves.bounceOut,
    this.okayBtnText,
    this.cancelBtnText,
    this.btnOneOnClick,
    this.btnTwoOnClick,
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
        onSubmit: btnOneOnClick,
        inputHint: inputHint,
        transparent: transparent,
        animDuration: animDuration,
        animationCurve: curve,
        description: content,
        btnOneColor: btnOneColor,
        btnOneText: btnOneText,
      );

  Widget success() => Success(
        icon: icon,
        color: color,
        title: title,
        transparent: transparent,
        animDuration: animDuration,
        animationCurve: curve,
        description: content,
        btnOneColor: btnOneColor,
        btnOneText: btnOneText,
        onOkay: btnOneOnClick,
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
        onOkay: btnOneOnClick,
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
        onOkay: btnOneOnClick,
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
        btnOneOnclick: btnOneOnClick,
        btnTwoOnclick: btnTwoOnClick,
      );

  dialog({String? type}) {
    switch (type) {
      case 'confirm':
        return confirm();
      case 'error':
        return error();
      case 'warning':
        return warning();
      case 'input':
        return input();
      case 'success':
        return success();
      default:
        return null;
    }
  }
}
