import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Homepage.dart';
import 'package:flutter_app/pakkeyget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'adaptar_class.dart';
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
  String image;
  String fullname;
  String fullname_two;
  String image_two;
  String m_check;
  List<adaptar_class> users=[];
  FirebaseAuth auth=FirebaseAuth.instance;
  final fb=FirebaseDatabase.instance.reference();
  TextEditingController messagesend=new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentusergetid();
  }
  void backbutton(){
    Navigator.pop(context);
  }
  /*Widget _detectOS(String message) {
    if (m_check == 'reciver') {
      return Container(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Card(
            child: Text(
              message,
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ),
      );
    }
  }*/
    @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(true);
          return false;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          backgroundColor:Colors.black45,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (
              ){
            Route route=MaterialPageRoute(builder: (context) => Homepage());
            Navigator.push(context, route);
          },),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black12,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.2,
                  child: users.length == 0 ? Text('No data') : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, index){
                      return Ui(users[index].message);
                    },
                  )
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                      controller:messagesend,
                      decoration: InputDecoration(
                        hintText: "Enter a message",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        border:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(3.0)),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,size: 30.0,),
                    onPressed: (){
                      fb.child("chats").child(currentid).child(getuid).set({
                        'fullname' : fullname,
                        'image' : image,
                      });
                      fb.child("chats").child(getuid).child(currentid).set({
                        'fullname' : fullname_two,
                        'image' : image_two,
                      });
                      fb.child("checkuser").child(currentid).child(getuid).set({
                        'check' : 'sender',
                      });
                      fb.child("checkuser").child(getuid).child(currentid).set({
                        'check' : 'reciver',
                      });
                      fb.child("Message").child(currentid).child(getuid).push().set({
                        'message': messagesend.text,
                      });
                      fb.child("Message").child(getuid).child(currentid).push().set({
                        'message': messagesend.text,
                      });
                      users.clear();
                      currentusergetid();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget Ui(String message){
    return Column(
      children: [
        new Container(
          //child:_detectOS(message),
        child: Align(
        alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width/4,
              height: MediaQuery.of(context).size.height/20,
              child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Future<void> currentusergetid() async {
    final FirebaseUser user=await auth.currentUser();
    setState(() {
      currentid=user.uid;
      fb.child("Userdata").child(getuid).child("fullname").once().then((DataSnapshot snap){
        fullname=snap.value;
      });
      fb.child("Userdata").child(getuid).child("image").once().then((DataSnapshot snap){
        image=snap.value;
      });
    });
    /*fb.child("checkuser").child(currentid).child(getuid).child("check").once().then((DataSnapshot snap){
      setState(() {
        m_check=snap.value;
      });
    });*/
    fb.child("Userdata").child(currentid).child("fullname").once().then((DataSnapshot sanp){
      setState(() {
        fullname_two=sanp.value;
      });
    });
    fb.child("Userdata").child(currentid).child("image").once().then((DataSnapshot sanp){
      setState(() {
        image_two=sanp.value;
      });
    });
    fb.child("Message").child(currentid).child(getuid).once().then((DataSnapshot snasshot){
      var keys=snasshot.value.keys;
      var Data=snasshot.value;
      for(var pakkey in keys) {
        {
          adaptar_class model = new adaptar_class(
            Data[pakkey]['message'],
          );
          users.add(model);
        }
      }
    });
  }
}
