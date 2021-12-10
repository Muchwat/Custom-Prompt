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
          child: MaterialButton(
            elevation: 0,
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () {
              CustomPrompt(
                context: context,
                animDuration: 800,
                color: Colors.red,
                type: Type.input,
                transparent: true,
                curve: Curves.bounceOut,
                btnOneOnClick: (value) {
                  print('Input value $value');
                },
              ).alert();
            },
            child: Text('Show Modal'),
          ),
        ),
      ),
    );
  }

  void submited(value) => print(value);
}