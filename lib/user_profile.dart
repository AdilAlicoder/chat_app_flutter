import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Homepage.dart';
import 'adaptar_class.dart';
import 'contacts.dart';
class messagesendpage extends StatefulWidget {
  messagesendpage(this.getuid);
  final String getuid;
  @override
  _messagesendpageState createState() => _messagesendpageState(getuid);
}

class _messagesendpageState extends State<messagesendpage> {
  _messagesendpageState(this.getuid);

  final String getuid;
  String currentid;
  String imagelink;
  String fullname;
  String name, img;
  FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentusergetid();
    fb.child("Userdata").child(getuid).child("image").once().then((
        DataSnapshot data) {
      setState(() {
        imagelink = data.value;
      });
    });
    fb.child("Userdata").child(getuid).child("fullname").once().then((
        DataSnapshot deta) {
      setState(() {
        fullname = deta.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.of(context).pop(true);
      return false;
    },
    child: Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('User'),
        backgroundColor: Colors.teal,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Route route=MaterialPageRoute(builder: (context) => contacts());
          Navigator.push(context, route);
        },),
      ),
      body:
      Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 75.0, left: 110.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('$imagelink'),
                backgroundColor: Colors.white,
                radius: 80.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 100.0),
            child: Text('$fullname',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 90.0),
            child: Container(
              width: 170.0,
              height: 40.0,
              child: RaisedButton(
                child: Text('Add Friend', style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.yellow)
                ),
                color: Colors.orange,
                splashColor: Colors.white,
                elevation: 20.0,
                onPressed: () {
                  fb.child("Request").child(getuid).child(currentid).set({
                    'fullname': name,
                    'image': img,
                    'request':'confirm',
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Future<void> currentusergetid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      currentid = user.uid;
    });
    fb.child("Userdata").child(currentid).child("fullname").once().then((
        DataSnapshot snap) {
      setState(() {
        name = snap.value;
      });
    });
    fb.child("Userdata").child(currentid).child("image").once().then((
        DataSnapshot snap) {
      setState(() {
        img = snap.value;
      });
    });
  }
}