import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neon/Mainscreen.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      elevation: 0.0,
      leading:IconButton(icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));

      },
      color: Colors.blue,
      ),
      title: Text("neon",
      style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold),
      textAlign:TextAlign.start,
      ),
    ),
    body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Settings",
            style:TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.white)
            ),
          ),
          SizedBox(height:6),
          Card(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
            elevation: 20.0,
            child: Container(
              width: 500,
              height: 200,
              decoration:BoxDecoration(borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(image: ExactAssetImage("images/banner.jpg"),
              fit: BoxFit.fill
              ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Tap the banner above to see available tripping options",
            style:TextStyle(color: Colors.grey)
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("INFO AND PREFERENCES",
            style:TextStyle(color: Colors.grey,fontSize:17,)
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
            elevation: 15.0,
            child:Container(
              width: 500,
              height:270,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                color: Colors.black38
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height:20),
                  Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Icons.rate_review ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Write a Review",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2.9),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon( Typicons.social_tumbler_circular,color: Colors.blue,),
                      SizedBox(width:35),
                      FittedBox(
                                              child: Text("Tweet@neontheapp",
                        style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/4.3),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Icons.bug_report ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Report a Bug",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2.6),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Typicons.th_large_outline ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Change App Icon",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/3.5),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("DEVELOPER INFO",
            style: TextStyle(color:Colors.grey,fontSize:17),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
            elevation: 15.0,
            child:Container(
              width: 500,
              height:270,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                color: Colors.black38
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height:20),
                  Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Icons.language ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Website",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon( FontAwesome.instagram,color: Colors.blue,),
                      SizedBox(width:35),
                      FittedBox(
                                              child: Text("Instagram",
                        style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2.3),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Typicons.social_github_circular ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Github",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                  Divider(
                        color: Colors.grey,
                        indent: 35
                      ),
                        Row(
                    children: <Widget>[
                      SizedBox(width:10),
                      Icon(Typicons.social_tumbler_circular ,color: Colors.blue,),
                      SizedBox(width:35),
                      Text("Twitter",
                      style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width/2),
                      IconButton(icon:Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
      
    );
  }
}