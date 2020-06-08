import 'package:customprompt/customprompt.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new HelloWorld());
}

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Prompt',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Prompt example'),
        ),
        body: Center(
          child: FlatButton(
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () {
              CustomPrompt(
                  context: context,
                  color: Colors.blue,
                  title: 'Confirm',
                  content: 'Are you sure, you want to log out?',
                  onOkay: logOut,
                  onCancel: canceled
              ).alert();
            },
            child: Text('Show Modal'),
          ),
        ),
      ),
    );
  }

  void logOut() => print('log 0ut');
  void canceled() => print('log 0ut');
}