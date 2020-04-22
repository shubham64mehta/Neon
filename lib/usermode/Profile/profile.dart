import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:neon/usermode/Home/home.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:uuid/uuid.dart';

var uid=Uuid();
class Profile1 extends StatefulWidget {
  List <CameraDescription>cameras;
  Profile1({this.cameras});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
           /* child: Image.asset("images/tiles.jpg",
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            ),*/
            decoration: BoxDecoration(
              
              image:DecorationImage(image: ExactAssetImage("images/tiles.jpg"),
              fit: BoxFit.fill,
             colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            
               
              )
            ),
          ),
          Positioned(
           bottom: 400,       
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Center(
                child: Text("Welcome To Neon",
                style:TextStyle(fontWeight:FontWeight.bold,fontSize:40,color: Colors.white,
                shadows:[Shadow(
                  color: Colors.black,
                  blurRadius: 20.0
                )]
                ),
                ),
              ),
            )
            
            ),
            Positioned(
              bottom: 290,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text("Neon is a brand new way of sharing",
                    style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:22,
                    shadows: [Shadow(
                      color:Colors.black,
                        blurRadius: 20.0
                    )]
                    ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text("your captured colors and gradients",
                  style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:22,
                   shadows: [Shadow(
                      color:Colors.black,
                        blurRadius: 20.0
                  )]
                  ),
                  ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text("with the world",
                    style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:22,
                     shadows: [Shadow(
                      color:Colors.black,
                        blurRadius: 20.0
                    )]
                    ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 90,
              
              child: Center(
                  child: RaisedButton(
                    color: Colors.grey,
                  elevation: 40.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/17,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/google.jpg") ,
                        ),
                        SizedBox(width: 55.0,),
                        FittedBox(
                                                  child: Text("Continue With Google ",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
             onPressed: () {
    signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return MainScreen1(cameras: widget.cameras,);
          },
        ),
      );
       uploadprofiles();
    });
   
  },
            ),
                ),
              
              )
        ],
      ),
      
    );
  }
}
Future uploadprofiles() async{
  try{
     final DateTime now = DateTime.now();
  final int millSeconds = now.millisecondsSinceEpoch;
  final String month = now.month.toString();
  final String date = now.day.toString();
  final String storageId = (millSeconds.toString() + uid.toString());
  final String today = ('$month-$date'); 

 add();
  }catch(error){
    print(error);
  }
}
Future<void> add() async{
  //var uuid = new Uuid().v1();
  DatabaseReference  _color2 = database.reference().child("Profiles").child(user1);
  final TransactionResult transactionResult = await _color2.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });
        if (transactionResult.committed) {
      _color2.push().set(<String, String>{
        "Name": "true",
        "Image":"true",
        "Uid":"true"
      }).then((_) {
        print('Transaction  committed.');
       
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
     _color2.set(
      {
        "Name": name,
        "Image":imageUrl,
        "Uid":user1,
              }
    );
}
