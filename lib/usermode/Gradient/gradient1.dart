import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:share/share.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:path/path.dart';
var b,c;
DataSnapshot s;
class Gradient2 extends StatefulWidget {
  @override
  _GradientState createState() => _GradientState();
}

class _GradientState extends State<Gradient2> with SingleTickerProviderStateMixin{
  AnimationController _animationController;

Future<String>read()async {
  FirebaseDatabase.instance.reference().child("Usergradient").child(user1).once().then((DataSnapshot snapshot){
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
    //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
    Map <dynamic,dynamic> values;
    values = snapshot.value;
    gradient1.clear();
    array1.clear();
    array2.clear();
    gradient2.clear();//Run kar wait
    values.forEach((key,value){
       FirebaseDatabase.instance.reference().child("Usergradient").child(user1).child(key).child("hexcolor1").once().then((DataSnapshot s){//run
         gradient1.add(Color(s.value));
         array1.add(s.value);//array of hexcolor1
        
      
  });
   FirebaseDatabase.instance.reference().child("Usergradient").child(user1).child(key).child("hexcolor2").once().then((DataSnapshot f){//run
         gradient2.add(Color(f.value));
         array2.add(s.value);//array of hexcolor2
  });
    
  });
  

  
});
return'success';
}
@override
  void initState() {
    super.initState();
    read();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
          _animationController.forward();
          _animationController.addListener((){
            setState(() {
              
            });
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
      width:200,
      height:200,
      child:ListView.builder(
        itemCount: gradient1.length,
        itemBuilder: (context,index){
        return AnimatedBuilder(
          animation: _animationController,
          builder:(context,child)=>
              Transform.rotate(
                child: child,
                angle: _animationController.value *2.0 *pi,),
                  child: SizedBox(
            height: 200,
            width:130,
            child: GestureDetector(
                          child: Card(
                elevation: 20,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                child:Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    gradient:LinearGradient(
                      colors: [gradient1[index],gradient2[index]],
                      begin:Alignment.bottomLeft,
                      end:Alignment.topRight,
                      tileMode: TileMode.repeated
                    ),
                  ),
                ),
              ),
              onTap: (){
                showDialog(context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)
                    ),
                    content: Center(
                      child: ScaleAnimatedTextKit(text: ["Post", "to"," Profile"],
                      duration: Duration(milliseconds:2000),
                      isRepeatingAnimation: true,
                      totalRepeatCount: 4,
                      textStyle: TextStyle(fontWeight:FontWeight.bold,fontSize:20.0),
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        children: <Widget>[
                          RaisedButton(onPressed: (){

                          },
                          child:Text("Yes",
                          style: TextStyle(fontWeight:FontWeight.bold),
                          ),
                          ),
                           RaisedButton(onPressed: (){
                             Navigator.pop(context);
                          },
                          child:Text("Cancel",
                          style: TextStyle(fontWeight:FontWeight.bold),
                          ),
                          ),

                        ],
                      ),
                    ],
                  );
                }
                );

               
              },
            ),
          ),
        );
      }
      ),
    );
    
  }
 
}