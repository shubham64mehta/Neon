import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'colorpicker/code.dart';


class Camera extends StatefulWidget {
   List<CameraDescription> cameras;
  Camera({this.cameras});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Camera> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraApp(cameras:widget.cameras,),
      floatingActionButton: null,
      
    );
  }
}

class CameraApp extends StatefulWidget {
    List<CameraDescription>cameras;
  CameraApp({this.cameras});
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> initializedControllerFuture;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.ultraHigh);
    initializedControllerFuture=controller.initialize();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      children: <Widget>[
        FutureBuilder<void>(
          future: initializedControllerFuture,
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done)
            {
              return CameraPreview(controller);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
          Positioned(
            right: 20,
            left: 20,
            bottom: 48,

        child: SizedBox(
          height: 150,
          width: 150,
                  child: FloatingActionButton(
            elevation: 20,
            backgroundColor: Colors.grey,
            highlightElevation: 20,
            
                onPressed: ()async{
              try{
                await initializedControllerFuture;
                final path =join(
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png'
                );
                await controller.takePicture(path);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ColorPickerWidget(imagePath:path)),);
              }catch(e){
                print(e);
              }
          } ),
        ),
                        
          ),
         
      ],
    ),
      
  );
  }


}