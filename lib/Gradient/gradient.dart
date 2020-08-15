import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/Global/global.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:path/path.dart';

var b, c;
DataSnapshot s;

class Gradient1 extends StatefulWidget {
  @override
  _GradientState createState() => _GradientState();
}

class _GradientState extends State<Gradient1>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Future<String> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Gradient")
        .once()
        .then((DataSnapshot snapshot) {
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
      //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      gradient1.clear();
      gradient2.clear(); //Run kar wait
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("Gradient")
            .child(key)
            .child("Hexcolor1")
            .once()
            .then((DataSnapshot s) {
          //run
          gradient1.add(Color(s.value)); //array of hexcolor1
        });
        FirebaseDatabase.instance
            .reference()
            .child("Gradient")
            .child(key)
            .child("hexcolor2")
            .once()
            .then((DataSnapshot f) {
          //run
          gradient2.add(Color(f.value)); //array of hexcolor2
        });
      });
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    read();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: ListView.builder(
          itemCount: gradient1.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Transform.rotate(
                child: child,
                angle: _animationController.value * 2.0 * pi,
              ),
              child: SizedBox(
                height: 200,
                width: 130,
                child: GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.0),
                        gradient: LinearGradient(
                            colors: [gradient1[index], gradient2[index]],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            tileMode: TileMode.repeated),
                      ),
                    ),
                  ),
                  onLongPress: () {
                    // share(context,gradient2[index],gradient1[index]);
                  },
                ),
              ),
            );
          }),
    );
  }
  /* void share(BuildContext context ,b,c){
    final RenderBox box =context.findRenderObject();
    final Widget 
       // Share.share()
  }*/
}
