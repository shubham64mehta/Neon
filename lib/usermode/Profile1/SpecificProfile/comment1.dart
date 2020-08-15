import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:uuid/uuid.dart';

FirebaseDatabase database = new FirebaseDatabase();
DatabaseReference database1;
final databasereference = Firestore.instance;
var uuid = new Uuid().v1();

class Comments1 extends StatefulWidget {
  int a, b;
  Comments1({this.a, this.b});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments1>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _listAnimation;

  @override
  void initState() {
    super.initState();
    database1 =
        FirebaseDatabase.instance.reference().child("Comments").child(result1);
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

  Future<void> add(String comment1, String comment2) async {
    var uuid = new Uuid().v1();
    DatabaseReference _color2 = database
        .reference()
        .child("Reply")
        .child(result1)
        .child(result4)
        .child(uuid);
    final TransactionResult transactionResult =
        await _color2.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });
    if (transactionResult.committed) {
      _color2.push().set(<String, String>{
        "reply": "true",
        "image": "true",
        "name": "true",
        "name1": "true",
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
      "reply": comment1,
      "image": imageUrl,
      "name": result6,
      "name1": name,
      "time": comment2
    });
    //read();
  }

  void add3(String comment1) async {
    await databasereference
        .collection("Comments")
        .document(user1)
        .collection(result)
        .document(uuid)
        .setData({
      "comment": comment1,
      "review": array5,
      "image": imageUrl,
      "name": name,
    });
  }

  @override
  Widget build(BuildContext context) {
    var e = MediaQuery.of(context).size.height / 14;
    final c = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Comment",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              child: Container(
                height: c / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  gradient: LinearGradient(
                      colors: [Color(widget.a), Color(widget.b)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.repeated),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                array5,
              ),
            ),
            FlatButton(
              child: Text("Add a comment"),
              color: Colors.transparent,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: e,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          maxLines: null,
                          onTap: () {
                            setState(() {
                              e = MediaQuery.of(context).size.height / 2.3;
                            });
                          },
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(imageUrl),
                                  radius: 10,
                                ),
                              ),
                              hintText: "Add a comment",
                              border: InputBorder.none),
                          autocorrect: true,
                          onSubmitted: (String str) {
                            var now = DateTime.now();
                            var date =
                                DateFormat("dd-MM-yyyy hh:mm:ss").format(now);
                            add2(str, date.toString());
                            add3(str);
                            setState(() {
                              e = MediaQuery.of(context).size.height / 14;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    });
              },
            ),
            Expanded(
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
                                      onLongPress: () {
                                        result4 = snapshot1.data.value['uid'];
                                        DatabaseReference database =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child("Reply")
                                                .child(result1)
                                                .child(snapshot1
                                                    .data.value['uid']);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                elevation: 15.0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: Container(
                                                    color: Colors.black,
                                                    width: 700,
                                                    height: 450,
                                                    child: FirebaseAnimatedList(
                                                        defaultChild: Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                        query: database
                                                            .orderByKey(),
                                                        sort: (a, b) => (b.key
                                                            .compareTo(a.key)),
                                                        itemBuilder: (_,
                                                            DataSnapshot
                                                                snapshot,
                                                            Animation<double>
                                                                animation,
                                                            int index) {
                                                          return FutureBuilder<
                                                                  DataSnapshot>(
                                                              future: database
                                                                  .reference()
                                                                  .child(
                                                                      snapshot
                                                                          .key)
                                                                  .once(),
                                                              builder: (context,
                                                                  snapshot1) {
                                                                return snapshot1
                                                                        .hasData
                                                                    ? Column(
                                                                        children: <
                                                                            Widget>[
                                                                          ListTile(
                                                                              leading: CircleAvatar(
                                                                                backgroundImage: NetworkImage(snapshot1.data.value['image']),
                                                                                radius: 10,
                                                                              ),
                                                                              title: Text(snapshot1.data.value['name1'] + " @" + snapshot1.data.value['name'] + ": " + snapshot1.data.value['reply'])),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: <Widget>[
                                                                              Text(snapshot1.data.value['time']),
                                                                              FlatButton(
                                                                                color: Colors.transparent,
                                                                                onPressed: () {
                                                                                  result6 = snapshot1.data.value['name1'];

                                                                                  showModalBottomSheet(
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return Container(
                                                                                          height: e,
                                                                                          child: TextField(
                                                                                            keyboardType: TextInputType.multiline,
                                                                                            textInputAction: TextInputAction.done,
                                                                                            maxLines: null,
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                e = MediaQuery.of(context).size.height / 2.3;
                                                                                              });
                                                                                            },
                                                                                            decoration: InputDecoration(
                                                                                                prefixIcon: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: CircleAvatar(
                                                                                                    backgroundImage: NetworkImage(imageUrl),
                                                                                                    radius: 10,
                                                                                                  ),
                                                                                                ),
                                                                                                hintText: "Reply",
                                                                                                border: InputBorder.none),
                                                                                            autocorrect: true,
                                                                                            onSubmitted: (String str) {
                                                                                              var now = DateTime.now();
                                                                                              var date = DateFormat("dd-MM-yyyy hh:mm:ss").format(now);
                                                                                              add(str, date.toString());
                                                                                              setState(() {
                                                                                                e = MediaQuery.of(context).size.height / 14;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                          ),
                                                                                        );
                                                                                      });
                                                                                },
                                                                                child: Text(
                                                                                  "reply",
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Center(
                                                                        child: CircularProgressIndicator(
                                                                            value:
                                                                                25),
                                                                      );
                                                              });
                                                        })),
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                13,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot1
                                                        .data.value['image']),
                                                radius: 15,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  snapshot1.data.value['name'] +
                                                      " :" +
                                                      snapshot1.data
                                                          .value['comment']),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6),
                                            Flexible(
                                                child: Text(snapshot1
                                                    .data.value['time'])),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        result4 = snapshot1.data.value['uid'];
                                        result6 = snapshot1.data.value['name'];
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: e,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  maxLines: null,
                                                  onTap: () {
                                                    setState(() {
                                                      e = MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2.3;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  imageUrl),
                                                          radius: 10,
                                                        ),
                                                      ),
                                                      hintText: "Reply",
                                                      border: InputBorder.none),
                                                  autocorrect: true,
                                                  onSubmitted: (String str) {
                                                    var now = DateTime.now();
                                                    var date = DateFormat(
                                                            "dd-MM-yyyy hh:mm:ss")
                                                        .format(now);
                                                    add(str, date.toString());
                                                    setState(() {
                                                      e = MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          14;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        "reply",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )
                              : CircularProgressIndicator();
                        });
                  }),
            )),
          ],
        ),
      ),
    );
  }
}

Future<void> add2(String comment1, String comment2) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 =
      database.reference().child("Comments").child(result1).child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "comment": "true",
      "review": "true",
      "image": "true",
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
    "review": array5,
    "image": imageUrl,
    "name": name,
    "uid": uuid,
    "time": comment2
  });
  //read();
}
