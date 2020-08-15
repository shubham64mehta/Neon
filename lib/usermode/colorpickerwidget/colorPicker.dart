import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_database/firebase_database.dart';
import 'package:neon/usermode/global/global1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';

var y;
Color b;
Color selectedColor;
var uid = Uuid();
FirebaseDatabase database = new FirebaseDatabase();

class ColorPickerWidget1 extends StatefulWidget {
  final String imagePath;
  ColorPickerWidget1({this.imagePath});
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget1> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();
  bool useSnapshot = true;

  GlobalKey currentKey;

  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image photo;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = useSnapshot ? "snapshot" : "basic";
    return Scaffold(
      appBar: AppBar(title: Text("Color picker $title")),
      body: StreamBuilder(
          initialData: Colors.green[500],
          stream: _stateController.stream,
          builder: (buildContext, snapshot) {
            selectedColor = snapshot.data ?? Colors.green;
            return Stack(
              children: <Widget>[
                RepaintBoundary(
                  key: paintKey,
                  child: GestureDetector(
                    onPanDown: (details) {
                      searchPixel(details.globalPosition);
                    },
                    onPanUpdate: (details) {
                      searchPixel(details.globalPosition);
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              "Want to Save the Color",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500),
                            ),
                            actions: <Widget>[
                              RaisedButton(
                                elevation: 15.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                onPressed: () {
                                  uploadtoStorage1(y);
                                  Navigator.popAndPushNamed(context, '/Home3');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen1()));
                                  //Navigator.pop(context);
                                },
                                child: Text("Save"),
                              ),
                              RaisedButton(
                                elevation: 15.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              )
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            contentPadding: EdgeInsets.all(10.0),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Image.file(
                        File(widget.imagePath),
                        key: imageKey,
                        //scale: .8,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(70),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedColor,
                      border: Border.all(width: 2.0, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ]),
                ),
                Positioned(
                  child: Text('${selectedColor}',
                      style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black54)),
                  left: 114,
                  top: 95,
                ),
              ],
            );
          }),
    );
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await (useSnapshot ? loadSnapshotBytes() : loadImageBundleBytes());
    }
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);
    //print(selectedColor);
    _stateController.add(Color(hex));
    if (hex.isFinite) {
      y = hex;
      //_showdialog(hex, context);
    }
    // uploadtoStorage();
  }

  Future<void> loadImageBundleBytes() async {
    ByteData imageBytes = await rootBundle.load(widget.imagePath);
    setImageBytes(imageBytes);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  var c = (argbColor & 0xFF00FF00) | (b << 16) | r;
  //uploadtoStorage(c);
  return c;
}

Future uploadtoStorage1(var d) async {
  try {
    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = (millSeconds.toString() + uid.toString());
    final String today = ('$month-$date');

    var file = d;
    add(file);
  } catch (error) {
    print(error);
  }
}

Future<void> add(var color1) async {
  var uuid = new Uuid().v1();
  DatabaseReference _color2 =
      database.reference().child("Usermode").child(user1).child(uuid);
  final TransactionResult transactionResult =
      await _color2.runTransaction((MutableData mutableData) async {
    mutableData.value = (mutableData.value ?? 0) + 1;

    return mutableData;
  });
  if (transactionResult.committed) {
    _color2.push().set(<String, String>{
      "hexcolor": "true",
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
    "hexcolor": color1,
  });
  //read();
}

void _showdialog(var x, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          "Want to Save the Color",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          RaisedButton(
            elevation: 15.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              uploadtoStorage1(x);
              Navigator.popAndPushNamed(context, '/Home3');
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen1()));
              //Navigator.pop(context);
            },
            child: Text("Save"),
          ),
          RaisedButton(
            elevation: 15.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          )
        ],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        contentPadding: EdgeInsets.all(10.0),
      );
    },
  );
}
