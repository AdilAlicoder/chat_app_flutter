import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Log_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Homepage.dart';
class checkuser extends StatefulWidget {
  @override
  _checkuserState createState() => _checkuserState();
}

class _checkuserState extends State<checkuser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void geo() {
    FirebaseAuth.instance.currentUser().then((firebaseUser){
      if(firebaseUser == null)
      {
        Route route =MaterialPageRoute(builder: (context) => Log_in());
        Navigator.push(context, route);
      }
      else{
        Route route =MaterialPageRoute(builder: (context) => Homepage());
        Navigator.push(context, route);
      }
    });
  }
}
