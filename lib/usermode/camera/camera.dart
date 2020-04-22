import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:neon/main.dart';
import 'package:neon/usermode/colorpickerwidget/colorPicker.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class Camera1 extends StatefulWidget {
   List<CameraDescription> cameras;
  Camera1({this.cameras});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Camera1> {
 
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ColorPickerWidget1(imagePath:path)),);
              }catch(e){
                print(e);
              }
          } ),
        ),
                        
          ),
         /* Positioned(
            right:MediaQuery.of(context).size.width/0.5,
            left: 20,
            bottom: 208,
            
            child: IconButton(icon: Icon(Icons.switch_camera,size:30,), onPressed:(){
              
            },
            
            )
            
          ),*/
      ],
    ),
      /*floatingActionButton: FloatingActionButton(
        elevation: 15,
        autofocus: true,

        child: Icon(Icons.camera_alt),
        onPressed: ()async{
          try{
            await initializedControllerFuture;
            final path =join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png'
            );
            await controller.takePicture(path);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayPictureScreen(imagePath:path)),);
          }catch(e){
            print(e);
          }
        }),*/
  );
  }


/*Future<void> oncameraswitch() async{
  final CameraDescription cameraDescription =(controller.description == cameras[0])?cameras[1] :cameras[0];
  if(controller!=null){
    await controller.dispose();
  }
  controller=CameraController(cameraDescription, ResolutionPreset.ultraHigh);
  controller.addListener((){
    if(mounted)setState(() {
      
    });
    if(controller.value.hasError){
      showInSnackBar('Camera error ${controller.value.errorDescription}');
    }
  });
  try{
    await controller.initialize();
  }on CameraException catch(e){
    showCameraException(e);
  }
  if(mounted){
    setState(() {
      
    });
  }
}
void showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

 void showInSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }*/

}
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

 DisplayPictureScreen({ this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
