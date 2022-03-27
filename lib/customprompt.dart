import 'package:flutter/material.dart';
import 'prompts/inputprompt.dart';
import 'prompts/confirm.dart';
import 'prompts/error.dart';
import 'prompts/warning.dart';
import 'prompts/success.dart';

enum Type { confirm, error, warning, input, success }

class CustomPrompt {
  BuildContext context;
  Icon? icon;
  bool transparent;
  Curve curve;
  int animDuration;
  Type type;
  String? okayBtnText, cancelBtnText, title, content, inputHint;
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
        description: content ?? " Something went wrong",
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

  dialog({Type? type}) {
    switch (type) {
      case Type.confirm:
        return confirm();
      case Type.error:
        return error();
      case Type.warning:
        return warning();
      case Type.input:
        return input();
      case Type.success:
        return success();
      default:
        return null;
    }
  }
}
