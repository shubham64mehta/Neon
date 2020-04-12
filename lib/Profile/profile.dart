import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neon/colorpicker/code.dart';
import 'package:uuid/uuid.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
         CircleAvatar(
           child: IconButton(icon: Icon(Icons.add_a_photo), onPressed:(){
            uploadToStorage();
           }
           ),
         ),
        ],
      ),
      
    );
  }
}

  Future uploadToStorage() async {
try {
  final DateTime now = DateTime.now();
  final int millSeconds = now.millisecondsSinceEpoch;
  final String month = now.month.toString();
  final String date = now.day.toString();
  final String storageId = (millSeconds.toString() + uid.toString());
  final String today = ('$month-$date'); 

 final file =  await ImagePicker.pickImage(source: ImageSource.gallery);
 uploadimage(file);

} catch (error) {
  print(error);
  }

}
String downloadUrl;
Future<String>uploadimage(var videofile)async{
   var uuid = new Uuid().v1();
  StorageReference ref = FirebaseStorage.instance.ref().child("post_$uuid.jpg");
  
  await ref.put(videofile).onComplete.then((val) {
                
                val.ref.getDownloadURL().then((val) {
                  print(val);
                  downloadUrl = val;
                
                   // addUrl(downloadUrl);//Val here is Already String
                });
              });
  return downloadUrl;

}
