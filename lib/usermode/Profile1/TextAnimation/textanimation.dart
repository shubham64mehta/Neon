import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:neon/usermode/Profile1/User/user.dart';
class TextAnim extends StatefulWidget {
  @override
  _TextAnimState createState() => _TextAnimState();
}

class _TextAnimState extends State<TextAnim> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
          child: FadeAnimatedTextKit(
            duration: Duration(milliseconds:2000),
            pause: Duration(milliseconds:1000),
        isRepeatingAnimation: false,
        text: ["Hello","Welcome","To Tiles"],
        textStyle: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize:70.0),
        onFinished: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>User()));

        },
        
      ),
    );
  }
}