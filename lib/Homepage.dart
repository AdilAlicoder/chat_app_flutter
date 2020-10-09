import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter_app/Log_in.dart';
import 'package:flutter_app/friends_model.dart';
import 'package:flutter_app/friends_request.dart';
import 'package:flutter_app/pakkeyget.dart';
import 'package:flutter_app/profile_show.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'messagesendpage.dart';
import 'model_class.dart';
import 'chat_adaptar.dart';
import 'contacts.dart';
import 'package:flutter_app/model_class.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
  String curentuid;
  List <friends_model> user=[];
  List <chat_adaptar> chat_user=[];
  FirebaseAuth auth = FirebaseAuth.instance;
  final fb=FirebaseDatabase.instance.reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curentuser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black54,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => contacts());
            Navigator.push(context, route);
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text("Tabbar"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            SizedBox(width: 23.0),
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings', 'Profile', 'Requests'}.map((
                    String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Friends'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                child: chat_user.length == 0 ? Container(
                  color: Colors.black,
                  child: SpinKitDualRing(
                    color: Colors.white,
                    size: 60.0,
                  ),) : ListView.builder(
                  itemCount: chat_user.length,
                  itemBuilder: (_, index){
                    return GestureDetector(
                       onTap: (){
                        /*  String getuid=user[index].pakkey;
                          Route route=MaterialPageRoute(builder: (context) => messagesendpage(getuid));
                          Navigator.push(context, route);*/
                        },
                        child: Us(chat_user[index].fullname,chat_user[index].image,chat_user[index].pakkey));
                  },
                )
            ),
            Container(
                child: user.length == 0 ? Container(
                  color: Colors.black,
                  child: SpinKitCubeGrid(
                    color: Colors.white,
                    size: 60.0,
                  ),) : ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (_, index){
                        return GestureDetector(
                          onTap: (){
                            String getuid=user[index].pakkey;
                            Route route=MaterialPageRoute(builder: (context) => messagesendpage(getuid));
                            Navigator.push(context, route);
                          },
                            child: Ui(user[index].fullname,user[index].image,user[index].pakkey));
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget Ui(String fullname,String image,String pakkey){
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
  Widget Us(String fullname,String image,String pakkey){
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
  void handleClick(value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
      case 'Profile':
        break;
      case 'Requests':
        break;
    }
    if (value == 'Requests') {
      Route route = MaterialPageRoute(builder: (context) => friend_tab());
      Navigator.push(context, route);
    }
    else if (value == 'Profile') {
      Route route = MaterialPageRoute(builder: (context) => profile_show());
      Navigator.push(context, route);
    }
    else if (value == 'Logout') {
      FirebaseAuth.instance.signOut();
      Route route = MaterialPageRoute(builder: (context) => Log_in());
      Navigator.push(context, route);
    }
  }

  Future<void> curentuser() async {
    final FirebaseUser users = await auth.currentUser();
    setState(() {
      curentuid = users.uid;
      fb.child("chats").child(curentuid).once().then((DataSnapshot snap){
        var keys=snap.value.keys;
        var Data=snap.value;
        chat_user.clear();
        for(var pakkey in keys) {
          {
            chat_adaptar model = new chat_adaptar(
              Data[pakkey]['fullname'],
              Data[pakkey]['image'],
              pakkey,
            );
            chat_user.add(model);
            setState(() {
            });
          }
        }
      });
    });
    fb.child("friends").child(curentuid).once().then((DataSnapshot snasshot){
      var keys=snasshot.value.keys;
      var Data=snasshot.value;
      user.clear();
      for(var pakkey in keys) {
        {
            friends_model model = new friends_model(
              Data[pakkey]['fullname'],
              Data[pakkey]['image'],
              pakkey,
            );
            user.add(model);
            setState(() {
            });
        }
      }
    });
  }
}