import 'package:flutter/material.dart';
import 'package:neon/Mainscreen.dart';
import 'package:random_pk/random_pk.dart';
import 'dart:math';
import 'package:camera/camera.dart';
List<CameraDescription> cameras;

Future<Null>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    ),
  );
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
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
                    image: DecorationImage(image: ExactAssetImage("images/neon.jpeg"),
                    fit: BoxFit.fill
                    )
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>MainScreen(cameras: cameras,)));
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