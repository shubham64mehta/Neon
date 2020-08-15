import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

var b, c;
DataSnapshot s;

class Gradient2 extends StatefulWidget {
  @override
  _GradientState createState() => _GradientState();
}

class _GradientState extends State<Gradient2>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Future<String> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Usergradient")
        .child(user1)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      gradient1.clear();
      array1.clear();
      array2.clear();
      gradient2.clear(); //Run kar wait
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("Usergradient")
            .child(user1)
            .child(key)
            .child("hexcolor1")
            .once()
            .then((DataSnapshot s) {
          //run
          gradient1.add(Color(s.value));
          array1.add(s.value); //array of hexcolor1
        });
        FirebaseDatabase.instance
            .reference()
            .child("Usergradient")
            .child(user1)
            .child(key)
            .child("hexcolor2")
            .once()
            .then((DataSnapshot f) {
          //run
          gradient2.add(Color(f.value));
          array2.add(f.value);
        });
      });
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    read();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
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
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: gradient1.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.rotate(
                    child: child,
                    angle: _animationController.value * 2.0 * pi,
                  ),
                  child: SizedBox(
                    height: 200,
                    width: 50,
                    child: GestureDetector(
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            gradient: LinearGradient(
                                colors: [gradient1[index], gradient2[index]],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                tileMode: TileMode.repeated),
                          ),
                        ),
                      ),
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                                  message: Text(
                                    "Share your views about the gradient with others",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 17.0),
                                  ),
                                  title: Text("Post to Profile"),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: Text(
                                                    " write something about the gradient",
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  ),
                                                  content: Text(
                                                    "It will be displayed in your profile",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: Text("yes"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                content:
                                                                    TextField(
                                                                  autocorrect:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  maxLines:
                                                                      null,
                                                                  onSubmitted:
                                                                      (String
                                                                          str) {
                                                                    var c = array1[
                                                                        index];
                                                                    var d = array2[
                                                                        index];
                                                                    uploadpost(
                                                                        c,
                                                                        d,
                                                                        str);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Share your thoughts",
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .kaushanScript(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Text("Yes")),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: const Text('Cancel'),
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                    },
                                  )),
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Future uploadpost(var f, var h, var k) async {
  try {
    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = (millSeconds.toString() + uid.toString());
    final String today = ('$month-$date');

    var file = f;
    var file1 = h;
    var file3 = k;
    add(file, file1, file3);
  } catch (error) {
    print(error);
  }
}

Future<void> add(var color1, var color2, var color3) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 =
      database.reference().child("Posts").child(user1).child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "hexcolor1": "true",
      "hexcolor2": "true",
      "uid": "true",
      "review": "true"
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
    "hexcolor1": color1,
    "hexcolor2": color2,
    "uid": uuid,
    "review": color3
  });
  //read();
}
