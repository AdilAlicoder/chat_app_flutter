import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Creat_account.dart';
import 'Homepage.dart';
class Log_in extends StatefulWidget {
  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  bool _obsuretext=true;
  final _key=GlobalKey<FormState>();
 final  FirebaseAuth auth=FirebaseAuth.instance;
 TextEditingController email=new TextEditingController();
 TextEditingController password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Stack(
          children: [
           Container(
           child: Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('images/loginback.jpg'),
              fit: BoxFit.cover
    )
            ),
              ),
    ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 70.0),
                    child: Center(
                      child: Image(
                        height:200,
                        width: 300,
                        image: AssetImage('images/avatar.png'),
                      ),
                    ),
                  ),
                    Stack(
                      children: [
                          Card(
                           color: Colors.green,
                           elevation: 60.0,
                         child: Container(
                           width: MediaQuery.of(context).size.width/1.1,
                           height: MediaQuery.of(context).size.height/2,
                         ),
                     ),
                        Column(
                          children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 33.0,left: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.2,
                            child: TextFormField(
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0,left: 10.0),
                              child: Container(
                              width: MediaQuery.of(context).size.width/1.2,
                              child: TextFormField(
                                obscureText: _obsuretext,
                                validator: (String value){
                                  if(value.isEmpty){
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                controller: password,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: (){
                                      setState(() {
                                        _obsuretext=!_obsuretext;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.greenAccent,
                                ),
                              ),
                        ),
                            ),
                             Container(
                               padding: EdgeInsets.only(left: 180.0,top: 5.0),
                               width: MediaQuery.of(context).size.width/1.1,
                              child: Text('Forgot Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),),
                            ),
                             Padding(
                               padding:  EdgeInsets.only(top:8.0),
                               child: RaisedButton(
                                elevation: 35.0,
                                onPressed:() {
                                  loginuser();
                                },
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 100.0),
                                color: Colors.blue[800],
                                splashColor: Colors.amber,
                                child: Text("Log in",
                                  style:TextStyle(fontSize: 20.0,color: Colors.white),),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                                ),
                            ),
                             ),
                           Container(
                             padding: EdgeInsets.only(top: 10.0),
                             width: MediaQuery.of(context).size.width/2,
                             child: RaisedButton(
                              elevation: 20.0,
                              onPressed:() {
                                Route route=MaterialPageRoute(builder: (context) => Creat_account());
                                Navigator.push(context, route);
                              },
                              color: Colors.red,
                              splashColor: Colors.amber,
                              child: Text("CREAT ACCOUNT",
                                style:TextStyle(fontSize: 15.0,color: Colors.white),),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0)
                              ),
                          ),
                           ),
                              ],
                        ),
                       ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> loginuser() async {
    if(_key.currentState.validate()){}
    FirebaseUser user;
     user = (await auth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    )).user;
    if(user==null){
      Fluttertoast.showToast(
          msg: "Please Enter Correct Email and paaword",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Route route=MaterialPageRoute(builder: (context) => Homepage());
      Navigator.push(context, route);
    }
  }
}
