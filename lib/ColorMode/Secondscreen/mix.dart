import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:neon/usermode/global/global1.dart';

DatabaseReference database1;

class Mix extends StatefulWidget {
  @override
  _MixState createState() => _MixState();
}

class _MixState extends State<Mix> {
  @override
  void initState() {
    super.initState();
    database1 =
        FirebaseDatabase.instance.reference().child("Color").child(user1);
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
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 40,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                        snapshot1.data.value["color1"],
                                        snapshot1.data.value['color2'],
                                        snapshot1.data.value['color3'],
                                        snapshot1.data.value['opacity']),
                                    borderRadius: BorderRadius.circular(20))),
                          ))
                      : Container();
                });
          }),
    ));
  }
}
