
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:neon/usermode/global/global1.dart';
class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles>with SingleTickerProviderStateMixin {

AnimationController _controller;

 Animation _profilePictureAnimation;
  Animation _contentAnimation;
Animation _listAnimation;

Future<String>read()async {
  FirebaseDatabase.instance.reference().child("Profiles").once().then((DataSnapshot snapshot){
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
    //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
    Map <dynamic,dynamic> values;
    values = snapshot.value;
    image.clear();
    name1.clear();
    values.forEach((key,value){
       FirebaseDatabase.instance.reference().child("Profiles").child(key).child("Image").once().then((DataSnapshot s){//run
         image.add(s.value);
         //print(array.length);
  });
  FirebaseDatabase.instance.reference().child("Profiles").child(key).child("Name").once().then((DataSnapshot f){//run
         name1.add(f.value);
         //print(array.length);
  });
    //print(value);
  });

  
});
return b='success';
}


@override
  void initState() {
    super.initState();
    read();
    _controller =
       AnimationController(vsync: this, duration: Duration(seconds: 4));
   _profilePictureAnimation = Tween(begin: 0.0, end: 50.0).animate(
       CurvedAnimation(
           parent: _controller,
           curve: Interval(0.0, 0.20, curve: Curves.easeOut)));
           _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
       parent: _controller,
       curve: Interval(0.20, 0.40, curve: Curves.easeOut)));
        _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
       parent: _controller,
       curve: Interval(0.40, 0.75, curve: Curves.easeOut)));

             _controller.forward();
   _controller.addListener(() {
     setState(() {});
   });
  }
  @override
  Widget build(BuildContext context) {
    var c=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
         brightness: Brightness.light,
     backgroundColor: Colors.transparent,
     actions: <Widget>[
       IconButton(
         icon: Icon(Icons.supervised_user_circle),
         color: Colors.white,
         onPressed: () {},
        iconSize: _profilePictureAnimation.value
        
       ),
     ],
     elevation: 0.0,
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:c/12),
          Text(
                "Here is the list of profiles",
                 style: TextStyle(fontSize: _contentAnimation.value, fontWeight: FontWeight.w600,),
               ),
          SizedBox(height:c/9 ,),
          Expanded(
            flex: 3,
            child: Opacity(
              opacity:_listAnimation.value ,
                          child: Container(
              child: ListView.separated(
                separatorBuilder: (context,index)=>Divider(),
                itemCount: image.length,
                itemBuilder: (context,index){
                  return FlatButton(onPressed: (){}, 
                  child:
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius:25,
                         backgroundImage: NetworkImage(
                           image[index]
                         ),
                      ),
                      SizedBox(width:25),
                      Text(name1[index],
                      style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize:25,fontStyle: FontStyle.italic),
                      )
                    ],

                  ),
                  );

              }),
          ),
            )),
        ],
      )
    );
  }
}
