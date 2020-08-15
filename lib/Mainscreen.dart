import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neon/Gradient/gradient.dart';
import 'package:neon/Home1.dart';
import 'package:neon/Settings/home.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'Database/database.dart';

class MainScreen extends StatefulWidget {
   List<CameraDescription>cameras;
  MainScreen({this.cameras});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
          child: Scaffold(
            backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading:IconButton(icon: Icon(Entypo.cog),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
          },
          ),
          elevation:0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Typicons.pipette), onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Camera(cameras: widget.cameras)));
            })
          ],
            title: Text("neon",
          ),
          bottom: TabBar(tabs:[
            Tab(
              child: InkWell(
                onTap: null,
                splashColor: Colors.grey,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 15.0,
                   child: Container(
                     width: 400,
                     height: 350,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15.0)
                     ),
                     child:Center(child: Text("Color",
                        style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),
                     ))
                            ),
            ),
              ),
            ),
             Tab(
               child: InkWell(
                onTap: null,
                splashColor: Colors.grey,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 15.0,
                   child: Container(
                     width: 500,
                     height: 350,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15.0)
                     ),
                     child:Center(child: Text("Gradient",
                     style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),
                     ))
                            ),
            ),
              ),
            )
          ] ),
        
        ),
        body: TabBarView(
          children: [
          SolidColor(),
          Gradient1(),
        ]
        ),
        
      ),
    );
  }
}