import 'dart:core';
import 'dart:ffi';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:uuid/uuid.dart';

var a, b, c;
var abc;
Float d;
DatabaseReference database1;
int l = 0;
int g = 0;
List array9 = [];
List array10 = [];

class Color2 extends StatefulWidget {
  @override
  _SolidColorState createState() => _SolidColorState();
}

class _SolidColorState extends State<Color2>
    with SingleTickerProviderStateMixin {
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
      array10.clear();
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
          color.add(Color(s.value));
          color4.add(Color(s.value));
          array.add(s.value);
          array10.add(s.value);
        });
      });
    });
    return color;
  }

  @override
  void initState() {
    super.initState();
    database1 =
        FirebaseDatabase.instance.reference().child("Usermode").child(user1);
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: FirebaseAnimatedList(
          defaultChild: Center(child: CircularProgressIndicator()),
          query: database1,
          itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation,
              int index) {
            return FutureBuilder<DataSnapshot>(
                future: database1.reference().child(snapshot.key).once(),
                builder: (context, snapshot1) {
                  return snapshot1.hasData
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () {
                              l = 0;
                              a = snapshot1.data.value['hexcolor'];
                              showDialog(
                                context: context,
                                child: Center(
                                  child: AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.2,
                                      child: Column(
                                        children: [
                                          Container(
                                              width: 700,
                                              height: 270,
                                              color: Color(snapshot1
                                                  .data.value['hexcolor'])),
                                          CupertinoActionSheet(
                                            actions: [
                                              ListTile(
                                                tileColor: Colors.black,
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                      "Want to mix the above Color"),
                                                ),
                                                subtitle: Text(
                                                    "Select any two color from the list"),
                                                trailing: IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20))),
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          array
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                l++;
                                                                              });
                                                                              l < 3
                                                                                  ? b == null ? b = array[index] : c = array[index]
                                                                                  : showDialog(
                                                                                      context: context,
                                                                                      child: AlertDialog(
                                                                                        actions: [
                                                                                          FlatButton(
                                                                                              color: Colors.transparent,
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context);
                                                                                                showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return CupertinoAlertDialog(
                                                                                                      title: Text(
                                                                                                        " Set the Brightness of the color",
                                                                                                        style: TextStyle(fontSize: 25),
                                                                                                      ),
                                                                                                      content: Text(
                                                                                                        "Kindly enter the decimal values",
                                                                                                        style: TextStyle(fontSize: 15),
                                                                                                      ),
                                                                                                      actions: <Widget>[
                                                                                                        CupertinoDialogAction(
                                                                                                          child: Text("yes"),
                                                                                                          onPressed: () {
                                                                                                            Navigator.of(context).pop();
                                                                                                            showDialog(
                                                                                                              context: context,
                                                                                                              builder: (context) {
                                                                                                                return Container(
                                                                                                                  width: 50,
                                                                                                                  height: 70,
                                                                                                                  child: AlertDialog(
                                                                                                                    content: TextField(
                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                      onSubmitted: (value) {
                                                                                                                        abc = double.parse(value);
                                                                                                                        assert(abc is double);
                                                                                                                        Navigator.pop(context);
                                                                                                                        add(a, b, c, abc);
                                                                                                                      },
                                                                                                                      decoration: InputDecoration(
                                                                                                                        border: InputBorder.none,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                );
                                                                                                              },
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                        CupertinoDialogAction(
                                                                                                          child: Text('No'),
                                                                                                          onPressed: () {
                                                                                                            Navigator.of(context).pop();
                                                                                                          },
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                              child: Text("Okay"))
                                                                                        ],
                                                                                        content: Text(
                                                                                          "Sorry,Two Colors are already selected",
                                                                                        ),
                                                                                      ));
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                              child: Container(
                                                                                width: 50,
                                                                                height: 170,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(array[index])),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                            );
                                                          });
                                                    }),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 40,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          snapshot1.data.value['hexcolor']),
                                      borderRadius: BorderRadius.circular(20)),
                                )),
                          ),
                        )
                      : Container();
                });
          }),
    ));
  }
}

Future<void> add(var d, var e, var f, var g) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 =
      database.reference().child("Color").child(user1).child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "color1": "true",
      "color2": "true",
      "color3": "true",
      "opacity": "true"
    }).then((_) {
      print('Transaction  committed.');
    });
  } else {
    print('Transaction not committed.');
    if (transactionResult.error != null) {
      print(transactionResult.error.message);
    }
  }
  _color2.set({"color1": d, "color2": e, "color3": f, "opacity": g});
  //read();
}
