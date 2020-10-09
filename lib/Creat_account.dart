import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'add_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Creat_account extends StatefulWidget {
  @override
  _Creat_accountState createState() => _Creat_accountState();
}

class _Creat_accountState extends State<Creat_account> {
  String uid;
  String fullnametxt;
  bool _obsuretext=true;
  final FirebaseAuth auth=FirebaseAuth.instance;
  final fb=FirebaseDatabase.instance.reference();
  final _key=GlobalKey<FormState>();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController fullname=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:65.0,left: 25.0),
                child: Text(
                  'Creat Account,',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top:8.0,left: 25.0),
                child: Text(
                  'Sinup up to get started!',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ),
               Padding(
                 padding: EdgeInsets.only(left: 100.0,top: 27.0),
                 child: Text(
                   'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 45.0,
                      color: Colors.deepPurple,
                    ),
                 ),
               ),
               Padding(
                 padding:  EdgeInsets.only(top: 40.0,left: 25.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width/1.2,
                   child: TextFormField(
                           controller: fullname,
                     validator: (String name){
                       if(name.isEmpty){
                         return 'Please Enter Name';
                       }else if(name.length<=2) return 'Name to short';
                       return null;
                     },
                            decoration: InputDecoration(
                            hintText: "Full Name",
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.red),
                       borderRadius: BorderRadius.circular(8.0),
                      ),
             border:  OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8.0)),
            filled: true,
               fillColor: Colors.white70,
    ),
    ),
                 ),
               ),
             SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                      child: TextFormField(
                        controller: email,
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Email';
                          }else if(value.length<=1) return 'Email to short';
                            return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          border:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8.0)),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                      obscureText: _obsuretext,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please Enter Password';
                        }else if(value.length<=4) return 'Password to short';
                        return null;
                      },
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: (){
                            setState(() {
                              _obsuretext=!_obsuretext;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.0)),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(left: 80.0,top: 7.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    splashColor: Colors.yellow,
                    onPressed: (){
                      signupclick();
                    },
                    child: Text('Sign Up',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    ),),
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signupclick() async {
    if(_key.currentState.validate()){
      FirebaseUser user;
      user=(await auth.createUserWithEmailAndPassword(email: email.text, password: password.text)).user;
       uid=user.uid;
       fullnametxt=fullname.text;
      Route route=MaterialPageRoute(builder: (context) => add_image(uid,fullnametxt));
      Navigator.push(context, route);
    }
  }
}