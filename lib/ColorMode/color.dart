import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neon/ColorMode/Secondscreen/mix.dart';
import 'package:neon/ColorMode/color.dart';
import 'package:neon/ColorMode/firstscreen/color1.dart';
import 'package:neon/usermode/Gradient/gradient1.dart';
import 'package:neon/usermode/Profile1/AnimatedBackground.dart';
import 'package:neon/usermode/camera/camera.dart';
import 'package:neon/usermode/database1/database1.dart';
import 'package:neon/usermode/settings/settings.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

bool isswitched = false;

class Color1 extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Color1> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Entypo.cog),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home1()));
            },
          ),
          elevation: 0.0,
          actions: <Widget>[],
          title: Text(
            "Neon",
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: InkWell(
                onTap: null,
                splashColor: Colors.grey,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 15.0,
                  child: Container(
                      width: 400,
                      height: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                          child: Text(
                        "Color",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
            ),
            Tab(
              child: InkWell(
                onTap: null,
                splashColor: Colors.grey,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 15.0,
                  child: Container(
                      width: 500,
                      height: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                          child: Text(
                        "Mix&Match",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
            )
          ]),
        ),
        body: TabBarView(children: [Color2(), Mix()]),
      ),
    );
  }
}
