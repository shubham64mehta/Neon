import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/Mainscreen.dart';
import 'package:neon/usermode/Home/home.dart';
import 'package:neon/usermode/Profile/profile.dart';
import 'package:neon/usermode/Profile1/AnimatedBackground.dart';
import 'package:neon/usermode/Profile1/TextAnimation/textanimation.dart';
import 'package:neon/usermode/Profile1/User/user.dart';
import 'package:neon/usermode/comments/comment.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:neon/usermode/settings/settings.dart';
import 'package:random_pk/random_pk.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  user1 = prefs.get("alreadyregistered");
  name = prefs.get("name");
  imageUrl = prefs.get("image");
  runApp(
    MaterialApp(
      routes: <String, WidgetBuilder>{
        '/Home1': (BuildContext context) => MainScreen(cameras: cameras),
        '/Home2': (BuildContext context) => Profile1(
              cameras: cameras,
            ),
        '/Home3': (BuildContext context) => MainScreen1(
              cameras: cameras,
            ),
        '/Home4': (BuildContext context) => Home4(),
        '/Home5': (BuildContext context) => FancyBackground(),
        '/Home6': (BuildContext context) => User(),
        '/Home7': (BuildContext context) => Home1(),
        '/Home8': (BuildContext context) => TextAnim()
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

class _HomeState extends State<Home4> with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AnimationController _animationController;

  List<String> string = ["User Mode", "Default Mode"];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print(message);
      return;
    }, onLaunch: (Map<String, dynamic> message) async {
      print(message);
      return;
    }, onResume: (Map<String, dynamic> message) async {
      print(message);
      return;
    });
    _firebaseMessaging
        .subscribeToTopic('Comments')
        .then((_) => print("Subscribed"));
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("images/background.gif"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Card(
                elevation: 80,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 70)
                  ]),
                  child: RandomContainer(
                      height: 230,
                      width: 230,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: f == 0 ? ab : b,
                          ),
                        ),
                        builder: (context, child) => Transform.rotate(
                          child: child,
                          angle: _animationController.value * 2.0 * pi,
                        ),
                      )),
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
            maxHeight: MediaQuery.of(context).size.height / 5,
            minHeight: 55,
            backdropEnabled: true,
            color: Colors.transparent,
            collapsed: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0)),
              ),
              child: Column(
                children: [
                  Center(
                      child: Icon(
                    Icons.drag_handle,
                    size: 30,
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Choose The Mode",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ),
                ],
              ),
            ),
            panel: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FlatButton(
                        onPressed: () async {
                          if (string[index] == "User Mode") {
                            SharedPreferences prefs1 =
                                await SharedPreferences.getInstance();
                            bool check =
                                prefs1.containsKey('alreadyregistered');
                            check == false
                                ? Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/Home2', ModalRoute.withName('/Home4'))
                                : Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/Home3', ModalRoute.withName('/Home4'));
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/Home1', ModalRoute.withName('/Home4'));
                          }
                        },
                        child: Center(
                          child: Text(
                            string[index],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 21.5,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                itemCount: 2),
          )
        ],
      ),
    );
  }
}
