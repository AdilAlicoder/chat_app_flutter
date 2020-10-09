import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/friends_request.dart';
import 'package:flutter_app/profile_show.dart';
import 'Homepage.dart';
import 'Log_in.dart';
import 'checkuser.dart';
import 'user_profile.dart';
void main(){
  runApp(Chat_app());
}
class Chat_app extends StatefulWidget {
  @override
  _Chat_appState createState() => _Chat_appState();
}

class _Chat_appState extends State<Chat_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat_App',
      home:checkuser(),
    );
  }
}

