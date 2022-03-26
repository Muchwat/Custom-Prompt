import 'package:customprompt/customprompt.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Custom Prompt', home: HelloWorld()));
}

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Prompt example'),
      ),
      body: Center(
        child: MaterialButton(
          elevation: 0,
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () {
            CustomPrompt(
              context: context,
              animDuration: 800,
              color: Colors.red,
              type: Type.success,
              // type: Type.input,
              // type: Type.confirm,
              // type: Type.error,
              transparent: true,
              curve: Curves.bounceOut,
              btnOneOnClick: (value) {
                print('Input value $value');
              },
            ).alert();
          },
          child: Text(
            'Show Modal',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void submited(value) => print(value);
}
