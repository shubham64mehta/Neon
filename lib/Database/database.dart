import 'dart:core';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/Global/global.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:uuid/uuid.dart';
//ye hai pura loading wala
//So tera problem ye hai ki colors bahut saare load ho rahe hai but database me usse kam values hai. Right? yes ok.
//Easy solution

class SolidColor extends StatefulWidget {
  @override
  _SolidColorState createState() => _SolidColorState();
}

class _SolidColorState extends State<SolidColor>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  Future<String> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("User")
        .once()
        .then((DataSnapshot snapshot) {
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
      //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      color.clear();
      array.clear();
      color4.clear();
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("User")
            .child(key)
            .child("Hexcolor")
            .once()
            .then((DataSnapshot s) {
          //run
          color.add(Color(s.value));
          color4.add(Color(s.value));
          array.add(s.value);
        });
        //print(value);
      });
    });
    return 'success';
  }

  void choosecolor() {}

  @override
  void initState() {
    super.initState();
    read();
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
    return Container(
      width: 200,
      height: 200,
      child: ListView.builder(
        itemCount: color.length,
        itemBuilder: (builder, index) {
          return AnimatedBuilder(
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
                      width: MediaQuery.of(context).size.width / 4,
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
                      builder: (BuildContext context) => CupertinoActionSheet(
                          message: Text(
                            "Press yes and select any one  color  from the List",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          title: Text(
                            "Convert it into gradient",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                              itemCount: color4.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        23)),
                                                    child: Container(
                                                      height: 200.0,
                                                      width: 50.0,
                                                      decoration: BoxDecoration(
                                                          color: color4[index],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      23)),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    colors2 = color4[index];
                                                    var d = array[index];
                                                    uploadtoStorage(c, d);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              }),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      elevation: 20);
                                },
                                child: Text("Yes")),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Cancel'),
                            isDefaultAction: true,
                            onPressed: () {
                              read();
                              Navigator.pop(context, 'Cancel');
                            },
                          )),
                    );
                  },
                  onTap: () {
                    if (_animationStatus == AnimationStatus.dismissed) {
                      animationController.forward();
                    } else {
                      animationController.reverse();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
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
      database.reference().child("Gradient").child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "Hexcolor1": "true",
      "Hexcolor2": "true",
    }).then((_) {
      print('Transaction  committed.');
    });
  } else {
    print('Transaction not committed.');
    if (transactionResult.error != null) {
      print(transactionResult.error.message);
    }
  }
  _color2.set({"Hexcolor1": color1, "hexcolor2": color2});
  //read();
}
