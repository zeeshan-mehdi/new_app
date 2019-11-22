import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  String title;

  LoginPage({this.title});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            'Elite Talent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                child: TextFormField(
                  controller: _emailController,
                  decoration: new InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                padding: EdgeInsets.all(8),
              ),
              Padding(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                padding: EdgeInsets.all(8),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text('Login',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: login,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void login() async {

    try {
      print('inside');
      FirebaseUser user = await _auth.currentUser();
      if (user == null) {
        print('null');
        var result = await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        user = result;
        assert(user != null);
        assert(await user.getIdToken() != null);

        user = await _auth.currentUser();


        if (user != null) {
          print('inside');
          final QuerySnapshot result = await Firestore.instance
              .collection('users')
              .where('email', isEqualTo: user.email)
              .getDocuments();
          setId(user);

          final List<DocumentSnapshot> documents = result.documents;
          if (documents.length != 0) {
            setLocalInfo(documents[0]);
            if (documents[0]['userType'] == 'agency') {
              print('agency');
              Navigator.popAndPushNamed(context, '/dashboard');
            } else {
              print('home');
              Navigator.popAndPushNamed(context, '/home',arguments: user);
            }
          } else {
            print('could not sign in');
            Fluttertoast.showToast(msg: 'Could not sign in try again');
          }
        } else {
          print('could not sign in');
          Fluttertoast.showToast(msg: 'Could not sign in try again');
        }
      } else {
        print('inside else${user.uid} ${user.email} ');

        setId(user);

        DocumentReference result =
        Firestore.instance.collection('users').document(user.uid);

        result
            .snapshots()
            .first
            .then((onValue) {
          print(onValue['userType']);
          if (onValue != null) {
            setLocalInfo(onValue);
            if (onValue['userType'] == 'agency') {
              print('agency');
              Navigator.popAndPushNamed(context, '/dashboard');
            } else {
              print('home');
              Navigator.popAndPushNamed(context, '/home',arguments: user);
            }
          } else {
            Fluttertoast.showToast(msg: 'Could not sign in try again');
          }
        });
      }
    }catch(e){
      print(e);
    }
  }

  setId(user)async{
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.uid);
  }

  setLocalInfo(user) async{
    try {
      await prefs.setString('nickname', user['nickname']);
      await prefs.setString('photoUrl', user['photoUrl']);
      await prefs.setString('about', user['about']);
    }catch(e){
      print(e.toString());
    }
  }
}
