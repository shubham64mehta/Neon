import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/Mainscreen.dart';
import 'package:neon/usermode/Home/home.dart';
import 'package:neon/usermode/Profile/profile.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:random_pk/random_pk.dart';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart' ;
List<CameraDescription> cameras;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  runApp(
    MaterialApp(
      routes:<String,WidgetBuilder>{
        '/Home1':(BuildContext context)=>MainScreen(cameras:cameras),
        '/Home2':(BuildContext context)=>Profile1(cameras:cameras),
        '/Home3':(BuildContext context)=>MainScreen1(),
        '/Home4':(BuildContext context)=>Home4(),
      },
      home: Home4(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    ),
  );
}
class Home4 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home4> with SingleTickerProviderStateMixin{
  AnimationController _animationController;


   @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat();
  }
  
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return Scaffold(
      body: Center(
        child: RandomContainer(
          height:230,
          width:230,
          
          child:AnimatedBuilder(
            animation: _animationController,
            child:InkWell(
                          child: Card(
                            child: Container(
                  height:50.0,
                  width:50.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                       image:f==0?a:b,
                       //ExactAssetImage("images/neon.jpeg"),
                      //
                    fit: BoxFit.fill
                    )
                  ),
                ),
              ),
              onTap: (){
                 showCupertinoModalPopup(context: context, 
                builder: (BuildContext context)=>
                CupertinoActionSheet(
                  title: Text("Choose The Mode",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    CupertinoActionSheetAction(onPressed: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile1(cameras: cameras,)));  
                    Navigator.of(context).pushNamedAndRemoveUntil('/Home2',ModalRoute.withName('/Home4'));
          
                    }, child: Text("User Mode")
                    ),
                     CupertinoActionSheetAction(onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder:(context)=>MainScreen(cameras: cameras,)));
                     Navigator.of(context).pushNamedAndRemoveUntil('/Home1',ModalRoute.withName('/Home4'));
                    }, child: Text("Default Mode")
                    ),
                  ],
        cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
              
              Navigator.pop(context, 'Cancel');
        },
      )
                ),
                );
              },
            ),
            builder:(context,child)=>
              Transform.rotate(
                child: child,
                angle: _animationController.value *2.0 *pi,),
                  
          )
        ),
      ),
      
    );
  }
}