import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
class TextAnim1 extends StatefulWidget {
  @override
  _TextAnimState createState() => _TextAnimState();
}

class _TextAnimState extends State<TextAnim1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
          child: FadeAnimatedTextKit(
            duration: Duration(milliseconds:2000),
            pause: Duration(milliseconds:1000),
        isRepeatingAnimation: false,
        text: ["Signing","Out"],
        textStyle: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize:70.0),
        onFinished: (){
          Navigator.of(context).pushNamedAndRemoveUntil('/Home3', (Route<dynamic> route) => false);

        },
        
      ),
    );
  }
}