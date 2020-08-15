import 'dart:core';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/Gradient/gradient.dart';
import 'package:neon/colorpicker/code.dart';

import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:uuid/uuid.dart';

Future<List> colors3;

class SolidColor1 extends StatefulWidget {
  @override
  _SolidColorState createState() => _SolidColorState();
}

class _SolidColorState extends State<SolidColor1>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  Future<List> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Usermode")
        .child(user1)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      color.clear(); //Run kar wait
      array.clear();
      color4.clear();
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("Usermode")
            .child(user1)
            .child(key)
            .child("hexcolor")
            .once()
            .then((DataSnapshot s) {
          //run
          color.add(Color(s.value));
          color4.add(Color(s.value));
          array.add(s.value);
          //print(array.length);
        });
        //print(value);
      });
    });
    return color;
  }

  @override
  void initState() {
    super.initState();
    colors3 = read();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween<double>(end: 1.0, begin: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.5, curve: Curves.linear)))
      ..addStatusListener((status) {
        _animationStatus = status;
      });
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: colors3,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: 200,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: color.length,
                itemBuilder: (builder, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.005)
                            ..rotateX(2 * pi * animation.value),
                          child: GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23)),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: color[index],
                                  borderRadius: BorderRadius.circular(23),
                                ),
                              ),
                            ),
                            onLongPress: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder:
                                    (BuildContext context) =>
                                        CupertinoActionSheet(
                                            message: Text(
                                              "Press yes and select any one  color  from the List",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            title: Text(
                                              "Convert it into gradient",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: <Widget>[
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    colors1 = color[index];
                                                    var c = array[index];
                                                    setState(() {
                                                      color4.removeAt(index);
                                                      array.removeAt(index);
                                                    });
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ListView
                                                                .builder(
                                                                    itemCount:
                                                                        color4
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return GestureDetector(
                                                                        child:
                                                                            Card(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                200.0,
                                                                            width:
                                                                                40.0,
                                                                            decoration:
                                                                                BoxDecoration(color: color4[index], borderRadius: BorderRadius.circular(23)),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          colors2 =
                                                                              color4[index];
                                                                          var d =
                                                                              array[index];
                                                                          uploadtoStorage(
                                                                              c,
                                                                              d);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      );
                                                                    }),
                                                          );
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        23)),
                                                        elevation: 20);
                                                  },
                                                  child: Text("Yes")),
                                            ],
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                              child: const Text('Cancel'),
                                              isDefaultAction: true,
                                              onPressed: () {
                                                read();
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                            )),
                              );
                            },
                            onTap: () {
                              if (_animationStatus ==
                                  AnimationStatus.dismissed) {
                                animationController.forward();
                              } else {
                                animationController.reverse();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Future uploadtoStorage(var d, var e) async {
  try {
    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = (millSeconds.toString() + uid.toString());
    final String today = ('$month-$date');

    var file = d;
    var file1 = e;
    add(file, file1);
  } catch (error) {
    print(error);
  }
}

Future<void> add(var color1, var color2) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 =
      database.reference().child("Usergradient").child(user1).child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "hexcolor1": "true",
      "hexcolor2": "true",
    }).then((_) {
      print('Transaction  committed.');
    });
  } else {
    print('Transaction not committed.');
    if (transactionResult.error != null) {
      print(transactionResult.error.message);
    }
  }
  _color2.set({"hexcolor1": color1, "hexcolor2": color2});
  //read();
}
