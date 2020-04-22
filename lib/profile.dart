import 'package:flutter/material.dart';
class Profile2 extends StatefulWidget {
  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(image:  ExactAssetImage("images/tiles.jpg"),)
      
        ),
      ),
      
      
    );
  }
}