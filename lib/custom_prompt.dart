library customprompt;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'prompts/confirm.dart';

class CustomPrompt {
  BuildContext context;
  String content;
  String okayBtnText;
  String cancelBtnText;
  String title;
  Function onOkay;
  Function onCancel;
  Color color;

  CustomPrompt({
    this.context,
    this.color = Colors.white,
    this.title,
    this.content,
    this.okayBtnText = 'Okay',
    this.cancelBtnText = "Cancel",
    this.onOkay, this.onCancel
  });

  alert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          Confirm(
            color: color,
            title: title,
            description: content,
            okayBtnText: okayBtnText,
            cancelBtnText: cancelBtnText,
            onOkay: onOkay,
            onCancel: onCancel,
          ),
    );
  }

}