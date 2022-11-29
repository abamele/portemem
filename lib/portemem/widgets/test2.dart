
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: RichText(
              text: TextSpan(
                text: "esssai",
                recognizer: new TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
