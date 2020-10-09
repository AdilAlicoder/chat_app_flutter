import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter_app/profile_show.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
class profile_image_update extends StatefulWidget {
  @override
  _profile_image_updateState createState() => _profile_image_updateState();
}

class _profile_image_updateState extends State<profile_image_update> {
  String uid;
  String fullname;
  FirebaseAuth auth=FirebaseAuth.instance;
  bool isenable=true;
  File _image;
  int imagenext=0;
  final fb=FirebaseDatabase.instance.reference();
  String _uploadedFileURL;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curentuid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Selected Image'),
              _image != null
                  ? Image.asset(
                _image.path,
                height: 150,
              )
                  : Container(height: 150),
              _image == null
                  ? RaisedButton(
                child: Text('Choose File'),
                onPressed: chooseFile,
                color: Colors.cyan,
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Upload File'),
                onPressed: uploadFile,
                color: Colors.cyan,
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Clear Selection'),
                onPressed: (){},
              )
                  : Container(),
              Text('Uploaded Image'),
              _uploadedFileURL != null
                  ? Image.network(
                _uploadedFileURL,
                height: 150,
              )
                  : Container(),
              RaisedButton(
                child: Text('Next'),
                onPressed:(){
                  next();
                },
              )
            ],
          ),
        ),
    );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    imagenext=1;
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
      imageurladd();
    });
  }
  void next(){
    if(imagenext==0){
      Fluttertoast.showToast(
          msg: "Please add image",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Route route=MaterialPageRoute(builder: (context) => profile_show());
      Navigator.push(context, route);
    }
  }

  Future<void> curentuid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      uid = user.uid;
    });
    FirebaseDatabase.instance.reference().child("Userdata").child(uid).child("fullname").once().then((DataSnapshot snap){
      setState(() {
        fullname=snap.value;
      });
    });
  }
  void imageurladd(){
    fb.child("Userdata").child(uid).set({
      'image' : _uploadedFileURL,
      'fullname' : fullname,
    });
  }
}