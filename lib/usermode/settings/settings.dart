import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neon/Mainscreen.dart';
import 'package:neon/main.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
var a = ExactAssetImage("images/neon.jpeg");

class Home1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    final c =MediaQuery.of(context).size.width/1.1;
    final appbar =AppBar(
      elevation: 0.0,
     /* leading:IconButton(icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));

      },
      color: Colors.blue,
      ),*/
      title: Text("neon",
      style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold),
      textAlign:TextAlign.start,
      ),
    );
    return Scaffold(
    appBar: appbar,
    body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Settings",
            style:TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.white)
            ),
          ),
          SizedBox(height:6),
          Card(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
            elevation: 20.0,
            child: Container(
              width:MediaQuery.of(context).size.width,              
              // 500,
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height)*0.3,
              //200,
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
              elevation: 15.0,
              child:Container(
                width:c, 
                //500,
                height:(MediaQuery.of(context).size.height-appbar.preferredSize.height)*0.54,
                //270,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  color: Colors.black38
                ),
                child: Column(
                  children: <Widget>[
                      SizedBox(height:((MediaQuery.of(context).size.height-appbar.preferredSize.height)*0.3)/5),
                    Row(
                      children: <Widget>[
                        SizedBox(width:10),
                        Icon(Icons.rate_review ,color: Colors.blue,),
                        SizedBox(width:35),
                        Text("Write a Review",
                        style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                        ),
                         SizedBox(width:c/5),
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
                       Text("Tweet@neon",
                          style:TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold),
                          ),
                        
                        SizedBox(width:c/4),
                        IconButton(icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          tweet1();
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
                        SizedBox(width:c/4),
                        IconButton(icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          contact();
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
                        SizedBox(width:c/7),
                        IconButton(icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          showDialog(context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              elevation: 25.0,
                              content: Text("Choose the icon"),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                   child: CircleAvatar(
                                     backgroundImage: ExactAssetImage("images/neon1.jpeg",                                 
                                     ),
                                     radius: 30.0,  
                                    ),
                                    onTap: (){
                                      f=1;
                                      b=ExactAssetImage("images/neon1.jpeg");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home4()));
                                    },
                                  ),
                                        ),
                                   Padding(
                                     padding: const EdgeInsets.all(5.0),
                                     child: InkWell(
                                     child: CircleAvatar(
                                       backgroundImage: ExactAssetImage("images/neon2.jpeg",                                 
                                       ),
                                       radius: 30.0,  
                                      ),
                                      onTap: (){
                                        f=1;
                                        b=ExactAssetImage("images/neon2.jpeg");
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home4()));
                                      },
                                  ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(5.0),
                                     child: InkWell(
                                     child: CircleAvatar(
                                       backgroundImage: ExactAssetImage("images/neon3.jpeg",                 
                                       ),
                                       radius: 30.0,  
                                      ),
                                      onTap: (){
                                        f=1;
                                        b=ExactAssetImage("images/neon3.jpeg");
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home4()));
                                      },
                                  ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(5.0),
                                     child: InkWell(
                                     child: CircleAvatar(
                                       backgroundImage: ExactAssetImage("images/neon4.jpeg",                                 
                                       ),
                                       radius: 30.0,  
                                      ),
                                      onTap: (){
                                        f=1;
                                        b=ExactAssetImage("images/neon4.jpeg");
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home4()));
                                      },
                                  ),
                                   ),
                                  
                                    ],
                                  ),
                                ),

                              ],
                            );
                          }
                          );
                        },
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("DEVELOPER INFO",
            style: TextStyle(color:Colors.grey,fontSize:17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
              elevation: 15.0,
              child:Container(
                width: c,
                //500,
            height:(MediaQuery.of(context).size.height-appbar.preferredSize.height)*0.43,
                //230,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  color: Colors.black38
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height:((MediaQuery.of(context).size.height-appbar.preferredSize.height)*0.4)/5),
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
                        SizedBox(width:c/3),
                        IconButton(icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          instagram();
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
                        SizedBox(width:c/2.4),
                        IconButton(icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          github();
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
                        SizedBox(width:c/2.4),
                        IconButton(
                           icon:Icon(Icons.arrow_forward_ios),
                        onPressed: (){
                          twitter();

                        },
                        ),
                       
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child:RaisedButton(
              elevation: 20,
              child: Text("Sign out"),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: (){
                signOutGoogle();
                Navigator.of(context).pushNamedAndRemoveUntil('/Home4', (Route<dynamic> route) => false);
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home4()));
              },
            ),
          )
        ],
      ),
    ),
      
    );
  }
}
void instagram()async{
  const url ='https://www.instagram.com/shubham60mehta/';
  if(await canLaunch(url)){
    await launch(url);
  }else{
    throw 'could not launch $url';
  }


}

void github()async{
  const url ='https://github.com/shubham64mehta';
  if(await canLaunch(url)){
    await launch(url);
  }else{
    throw 'could not launch $url';
  }


}
void twitter()async{
  const url ='https://twitter.com/Shubham641999';
  if(await canLaunch(url)){
    await launch(url);
  }else{
    throw 'could not launch $url';
  }


}
void tweet1()async{
  const url ='https://twitter.com/tweetneon1';
 if(await canLaunch(url)){
   await launch(url);
 }else{
   throw 'could not launch $url';
 }

}
    void contact() async {
        final url = 'mailto:shubham65mehta@gmail.com';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }

