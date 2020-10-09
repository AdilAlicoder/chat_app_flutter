import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/user_request.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Homepage.dart';
import 'adaptar_class.dart';
class friend_tab extends StatefulWidget {
  @override
  _friend_tabState createState() => _friend_tabState();
}

class _friend_tabState extends State<friend_tab> {
  String currentid;
  int indexs;
  String name;
  String img;
  List<user_request> users=[];
  FirebaseAuth auth=FirebaseAuth.instance;
  final fb=FirebaseDatabase.instance.reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentusergetid();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Route route=MaterialPageRoute(builder: (context) => Homepage());
        Navigator.push(context, route);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Requests'),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (
              ){
            Route route=MaterialPageRoute(builder: (context) => Homepage());
            Navigator.push(context, route);
          },),
        ),
        body:Container(
          width: MediaQuery.of(context).size.width,
                  child: users.length == 0 ? Container(
                    child: SpinKitCircle(
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ) : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, indexs){
                      return GestureDetector(
                          onTap: () {
                          },
                          child: Ui(users[indexs].fullname,users[indexs].image,users[indexs].request,users[indexs].pakkey));
                    },
                  )
        ),
      ),
    );
  }
  Widget Ui(String fullname,String image,String request,String pakkey){
    return new Container(
      child:SingleChildScrollView(
         scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 30.0,
                ),
              ),
            ),
                   Text(
                    fullname,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                Padding(
                  padding:EdgeInsets.only(left: 20.0),
                      child: RaisedButton(
                        color: Colors.orange,
                        splashColor: Colors.white,
                        elevation: 10.0,
                        child: Text(request,style: TextStyle(fontSize: 20.0,color: Colors.white),),
                        onPressed: () {
                            fb.child("friends").child(currentid)
                                .child(pakkey)
                                .set({
                              'fullname': fullname,
                              'image': image,
                            });
                            fb.child("friends").child(pakkey).child(currentid).set({
                              'fullname' : name,
                              'image' : img,
                            });
                            fb.child("Request").child(currentid)
                                .child(pakkey)
                                .remove();
                        },
                      ),
                ),
          ],
        ),
      ),
    );
  }

  Future<void> currentusergetid() async {
    final FirebaseUser user=await auth.currentUser();
    setState(() {
      currentid=user.uid;
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
    });
    fb.child("Request").child(currentid).once().then((DataSnapshot snasshot){
      var keys=snasshot.value.keys;
      var Data=snasshot.value;
      for(var pakkey in keys) {
        {
          user_request geo = new user_request(
            Data[pakkey]['fullname'],
            Data[pakkey]['image'],
            Data[pakkey]['request'],
            pakkey,
          );
          users.add(geo);
          setState(() {
          });
        }
      }
    });
  }
}
