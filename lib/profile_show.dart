import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/profile_image_update.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Homepage.dart';
import 'adaptar_class.dart';
import 'name_update.dart';
class profile_show extends StatefulWidget {
  @override
  _profile_showState createState() => _profile_showState();
}

class _profile_showState extends State<profile_show> {
  String currentid;
  String imagelink;
  String fullname;
  FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentusergetid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Route route=MaterialPageRoute(builder: (context) => Homepage());
          Navigator.push(context, route);
        },),
      ),
      body:
      Column(
        children: [
          Padding(
            padding:EdgeInsets.only(top: 100.0),
            child: Center(
              child: Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('$imagelink'),
                    backgroundColor: Colors.white,
                    radius: 80.0,
                  ),
                ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text('$fullname',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              splashColor: Colors.orange,
              onTap: (){
                Route route=MaterialPageRoute(builder: (context) => profile_image_update());
                Navigator.push(context, route);
              },
              child: Card(
                child: Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/15,
                  child: Center(
                    child: Text('Change photo',style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
              splashColor: Colors.orange,
              onTap: (){
                Route route=MaterialPageRoute(builder: (context) => name_update());
                Navigator.push(context, route);
              },
              child: Card(
                child: Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/15,
                  child: Center(
                    child: Text('Change Name',style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> currentusergetid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      currentid = user.uid;
    });
    fb.child("Userdata").child(currentid).child("image").once().then((DataSnapshot data) {
      setState(() {
        imagelink = data.value;
      });
    });
    fb.child("Userdata").child(currentid).child("fullname").once().then((DataSnapshot data) {
      setState(() {
        fullname = data.value;
      });
    });
  }
}