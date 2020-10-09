import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Homepage.dart';
import 'user_profile.dart';
import 'model_class.dart';
import 'package:flutter_app/model_class.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
class contacts extends StatefulWidget {
  @override
  _contactsState createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tab',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[600],
      ),
      home:homepage(),
    );
  }
}
class  homepage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<homepage> {
  FirebaseAuth auth=FirebaseAuth.instance;
  String currentuid;
  List<model_class> user=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentuser();
    DatabaseReference reference=FirebaseDatabase.instance.reference().child("Userdata");
    reference.once().then((DataSnapshot snasshot){
      var keys=snasshot.value.keys;
      var Data=snasshot.value;
      user.clear();
      for(var pakkey in keys) {
        {
          if (pakkey == currentuid) {
          }
          else {
            model_class model = new model_class(
              Data[pakkey]['fullname'],
              Data[pakkey]['image'],
              pakkey,
            );
            user.add(model);
            setState(() {

            });
          }
        }
      }
    });
  }
  Future<bool> backbutton(){
    Navigator.of(context).pop(true);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:backbutton,
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text('Contacts'),
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (
                ){
              Route route=MaterialPageRoute(builder: (context) => Homepage());
              Navigator.push(context, route);
            },),
          ),
          body: Container(

            child:Container(
                  child: user.length == 0 ? Container(
                    color: Colors.red,
                    child: SpinKitWave(
                    color: Colors.white,
                    size: 60.0,
                  ),) : ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (_, index){
                      return GestureDetector(
                        onTap: () {
                          String getuid=user[index].pakkey;
                          Route route=MaterialPageRoute(builder: (context) => messagesendpage(getuid));
                          Navigator.push(context, route);
                        },
                          child: Ui(user[index].fullname,user[index].image));
                    },
                  )
              ),
          ),
      ),
    );
  }
  Widget Ui(String fullname,String image){
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(3.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      backgroundColor: Colors.white,
                      radius: 35.0,
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 60,
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      fullname,
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> currentuser() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      currentuid = user.uid;
    });
  }
}


