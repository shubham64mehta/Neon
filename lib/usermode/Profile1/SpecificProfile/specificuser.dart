import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:neon/usermode/Profile1/SpecificProfile/comment1.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:uuid/uuid.dart';

var uuid = new Uuid().v1();
final databasereference = Firestore.instance;
var uid = Uuid();
FirebaseDatabase database = new FirebaseDatabase();
DatabaseReference database1;

class SpecificUser extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<SpecificUser>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _listAnimation;
  Animation _profilePictureAnimation;
  double _width = 90;
  double _height = 90;

  void updatestate() {
    setState(() {
      _width = _profilePictureAnimation.value;
      _height = _profilePictureAnimation.value;
    });
  }
/*void updatestate1(){
  setState(() {
    _width=90;
    _height =90;
  });
}*/

  Future<String> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(users4)
        .once()
        .then((DataSnapshot snapshot) {
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
      //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      gradient5.clear();
      gradient6.clear();
      array3.clear();
      array4.clear();
      comment13.clear();
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("Posts")
            .child(users4)
            .child(key)
            .child("hexcolor1")
            .once()
            .then((DataSnapshot s) {
          //run
          gradient5.add(Color(s.value)); //array of hexcolor1
        });
      });
    });
    return 'success';
  }

  void add3(String comment1) async {
    await databasereference
        .collection("Comments")
        .document(users4)
        .collection(result3)
        .document(uuid)
        .setData({
      "comment": comment1,
      "image": imageUrl,
      "name": name,
      "review": result7,
    });
  }

  @override
  void initState() {
    super.initState();
    database1 =
        FirebaseDatabase.instance.reference().child("Posts").child(users4);
    read();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
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
    var e = MediaQuery.of(context).size.height / 14;
    //Tween<double> tween = Tween<double>(begin: 1,end: 2);
    final c = MediaQuery.of(context).size.width;
    final d = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: c,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.lerp(
                      Radius.circular(10), Radius.circular(20), 40.0)),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                    bottom: 150,
                    left: c / 4,
                    child: Text(
                      name2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                    )),
                Positioned(
                  bottom: 1,
                  left: c / 2.7,
                  child: InkWell(
                    child: Container(
                      width: _width,
                      height: _height,
                      // curve: Curves.bounceOut,
                      //duration: Duration(milliseconds:40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: NetworkImage(image1), fit: BoxFit.cover)),
                    ),
                    onTap: () {
                      updatestate();
                    },
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: c / 9,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Posts",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        gradient5.length.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 220,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: d / 80,
          ),
          Expanded(
              child: Container(
            child: Opacity(
              opacity: _listAnimation.value,
              child: FirebaseAnimatedList(
                  defaultChild: Center(child: CircularProgressIndicator()),
                  query: database1,
                  sort: (a, b) => (b.key.compareTo(a.key)),
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return FutureBuilder<DataSnapshot>(
                        future:
                            database1.reference().child(snapshot.key).once(),
                        builder: (context, snapshot1) {
                          return snapshot1.hasData
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0)),
                                        child: Container(
                                          height: c / 3,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(snapshot1
                                                      .data.value['hexcolor1']),
                                                  Color(snapshot1
                                                      .data.value['hexcolor2'])
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                tileMode: TileMode.repeated),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(snapshot1.data.value['review']),
                                    ),
                                    FlatButton(
                                      child: Text("View all comments"),
                                      onPressed: () {
                                        result1 = snapshot1.data.value['uid'];
                                        array5 = snapshot1.data.value['review'];
                                        k = snapshot1.data.value['hexcolor1'];
                                        l = snapshot1.data.value['hexcolor2'];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Comments1(a: k, b: l)));
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(imageUrl),
                                            radius: 10,
                                          ),
                                          Expanded(
                                              child: FlatButton(
                                            child: Text("Add a comment"),
                                            color: Colors.transparent,
                                            onPressed: () {
                                              result =
                                                  snapshot1.data.value['uid'];
                                              result7 = snapshot1
                                                  .data.value['review'];
                                              k = snapshot1
                                                  .data.value['hexcolor1'];
                                              l = snapshot1
                                                  .data.value['hexcolor2'];
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      height: e,

                                                      ///f1==0?MediaQuery.of(context).size.height/8:MediaQuery.of(context).size.height/2.3,
                                                      child: TextField(
                                                        onTap: () {
                                                          setState(() {
                                                            //f1=1;
                                                            e = MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.3;
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            imageUrl),
                                                                    radius: 10,
                                                                  ),
                                                                ),
                                                                hintText:
                                                                    "Add a comment",
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        autocorrect: true,
                                                        // controller: mycontroller,
                                                        onSubmitted:
                                                            (String str) {
                                                          var now =
                                                              DateTime.now();
                                                          var date = DateFormat(
                                                                  "dd-MM-yyyy hh:mm:ss")
                                                              .format(now);
                                                          add(str,
                                                              date.toString());
                                                          add3(str);
                                                          setState(() {
                                                            e = MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                14;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    );
                                                  });
                                            },
                                          ))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : CircularProgressIndicator();
                        });
                  }),
            ),
          )),
        ],
      ),
    );
  }
}

Future<void> add(String comment1, String comment2) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 = database
      .reference()
      .child("Comments")
      .child(users4)
      .child(result)
      .child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "comment": "true",
      "image": "true",
      "review": "true",
      "name": "true",
      "uid": "true",
      "time": "true"
    }).then((_) {
      print('Transaction  committed.');
    });
  } else {
    print('Transaction not committed.');
    if (transactionResult.error != null) {
      print(transactionResult.error.message);
    }
  }
  _color2.set({
    "comment": comment1,
    "image": imageUrl,
    "review": result7,
    "name": name,
    "uid": uuid,
    "time": comment2
  });
  //read();
}
