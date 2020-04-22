import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/usermode/Profile1/Profiles/profiles.dart';
import 'package:neon/usermode/Profile1/User/signout.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User>with SingleTickerProviderStateMixin {

AnimationController _controller;

 Animation _profilePictureAnimation;
double _width =90;
double _height=90;


void updatestate(){
  setState(() {
    _width=_profilePictureAnimation.value;
    _height =_profilePictureAnimation.value;
  });
}
/*void updatestate1(){
  setState(() {
    _width=90;
    _height =90;
  });
}*/

Future<String>read()async {
  FirebaseDatabase.instance.reference().child("Usergradient").child(user1).once().then((DataSnapshot snapshot){
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
    //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
    Map <dynamic,dynamic> values;
    values = snapshot.value;
    gradient3.clear();
    gradient4.clear();//Run kar wait
    values.forEach((key,value){
       FirebaseDatabase.instance.reference().child("Usergradient").child(user1).child(key).child("hexcolor1").once().then((DataSnapshot s){//run
         gradient3.add(Color(s.value));//array of hexcolor1
        
      
  });
   FirebaseDatabase.instance.reference().child("Usergradient").child(user1).child(key).child("hexcolor2").once().then((DataSnapshot f){//run
         gradient4.add(Color(f.value));//array of hexcolor2
  });
    
  });
  

  
});
return'success';
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

             _controller.forward();
   _controller.addListener(() {
     setState(() {});
   });
  }


  @override
  Widget build(BuildContext context) {
    //Tween<double> tween = Tween<double>(begin: 1,end: 2);
    final c =MediaQuery.of(context).size.width;
    final d= MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: c,
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
              color:Colors.deepPurpleAccent,
               borderRadius: BorderRadius.only(bottomRight:Radius.lerp(Radius.circular(10),Radius.circular(20),40.0) ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 150,
                  left:c/4,
                  child: Text(name,
                  style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize:40,fontStyle: FontStyle.italic),
                  )
                  ),
                Positioned(
                  bottom: 1,
                left: c/2.7,
                                  child: InkWell(
                                     child: Container(
                                       width: _width,
                                       height: _height,
                                      // curve: Curves.bounceOut,
                                      //duration: Duration(milliseconds:40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(image: NetworkImage(imageUrl),
                      fit: BoxFit.cover
                      )

                    ),

                  ),
                  onTap: (){
                    updatestate();
                  },
                            ),
                ),
                Positioned(
                  bottom: 220,
                  child: IconButton(icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FancyBackground1()));
                },
                ),
                ),
                Positioned(
                  left: c/2,
                  bottom: 220,
                  child: Row(
                    children: <Widget>[
                      Text("UserProfiles",
                      style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize: 20),
                      ),
                      IconButton(icon: Icon(Icons.person), onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profiles()));
                      }
                      ),
                    ],
                  )),
              ],
            ),
          ),
          SizedBox(height:d/80 ,),
          Expanded(
            child:Container(
              width:c,
              child:GridView.builder(
                 itemCount:gradient3.length,
    gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount:2 ),
    itemBuilder: (BuildContext context, int index) {
      return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24.0)),
                    child: Container(
                      height:800.0,
                      width:200.0,
                      decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(24.0),
                      gradient: LinearGradient(colors: [gradient3[index],gradient4[index]],
                       begin:Alignment.bottomLeft,
                      end:Alignment.topRight,
                      tileMode: TileMode.repeated  
                      ),
                      ),
                    ),
                  );
    }

              ),
              
            )
          ),

        ],
      ),
      
    );
  }
}