import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/usermode/Profile1/SpecificProfile/specificuser.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:neon/usermode/google/google.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _profilePictureAnimation;
  Animation _contentAnimation;
  Animation _listAnimation;

  Future<String> read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Profiles")
        .once()
        .then((DataSnapshot snapshot) {
//should be "user"
//Baad mai small case se name karna. Nahi toh galat progrramming practice hai
      //Ek cheee bata a hu. database ke values hamesha camel case me honge which is first word is small and se ek second kya
      Map<dynamic, dynamic> values;
      values = snapshot.value;
      image.clear();
      name1.clear();
      userid.clear();
      values.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child("Profiles")
            .child(key)
            .child("Image")
            .once()
            .then((DataSnapshot s) {
          //run
          image.add(s.value);
          //print(array.length);
        });
        FirebaseDatabase.instance
            .reference()
            .child("Profiles")
            .child(key)
            .child("Name")
            .once()
            .then((DataSnapshot f) {
          //run
          name1.add(f.value);
          //print(array.length);
        });
        //print(value);
        FirebaseDatabase.instance
            .reference()
            .child("Profiles")
            .child(key)
            .child("Uid")
            .once()
            .then((DataSnapshot k) {
          //run
          userid.add(k.value);
          //prin(arrayt.length);
        });
      });
    });
    return b = 'success';
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
    _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.20, 0.40, curve: Curves.easeOut)));
    _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.40, 0.75, curve: Curves.easeOut)));

    _controller.forward();
    _controller.addListener(() {
      setState(() {
        name1.remove(name);
        image.remove(imageUrl);
        userid.remove(user1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("images/Animation.gif"),
                    fit: BoxFit.fill))),
        Positioned(
            bottom: c / 1.3,
            child: Text(
              "Here is the list of profiles",
              style: GoogleFonts.dancingScript(
                  color: Colors.white,
                  fontSize: _contentAnimation.value,
                  shadows: [
                    Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(10.0, 10.0))
                  ],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400),
            )),
        Positioned(
            bottom: c / 9,
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width / 1,
              color: Colors.transparent,
              child: Opacity(
                opacity: _listAnimation.value,
                child: Container(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: name1.length,
                      itemBuilder: (context, index) {
                        return FlatButton(
                          onPressed: () {
                            image1 = image[index];
                            name2 = name1[index];
                            users4 = userid[index];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpecificUser()));
                          },
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(image[index]),
                              ),
                              SizedBox(width: 25),
                              Text(
                                name1[index],
                                style: GoogleFonts.dancingScript(
                                    color: Colors.white,
                                    fontSize: _contentAnimation.value,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(10.0, 10.0))
                                    ],
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ))
      ],
    ));
  }
}
