import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
class name_update extends StatefulWidget {
  @override
  _name_updateState createState() => _name_updateState();
}

class _name_updateState extends State<name_update> {
  final _key=GlobalKey<FormState>();
  String uid;
  String image;
  final fb=FirebaseDatabase.instance.reference();
  FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController fullname=new TextEditingController();
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
        title: Text('Name Update'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(
               child: TextFormField(
                 controller: fullname,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  filled: true,
                ),
            ),
             ),
            RaisedButton(
              splashColor: Colors.black,
              color: Colors.blue,
              onPressed:namesave,
              child: Text('Save',style: TextStyle(fontSize: 20.0,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
  void namesave() {
      fb.child("Userdata").child(uid).set({
        'fullname' : fullname.text,
        'image' : image,
      });
    }
  Future<void> curentuid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      uid = user.uid;
    });
    fb.child("Userdata").child(uid).child("image").once().then((DataSnapshot snap){
      setState(() {
        image=snap.value;
      });
    });
  }
}
