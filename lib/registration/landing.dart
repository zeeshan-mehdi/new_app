import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/settings/RoutesGenerator.dart';
import 'package:match_hire/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';






class Landing extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite Talent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  String title;

  LandingPage({this.title});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'elite',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  'talent',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color:HexColor('#0dd958')),
                ),
              ],
            ),

          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Jobs | Auditions | Castings',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: HexColor('#0dd958'),
                    child: Text('Find Job',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: findJob,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Join For Free',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: HexColor('#0dd958'),
                    child: Text('Find Talent',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: lookForJob,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'List Job For Free',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: Colors.lightBlue,
                    child: Text('Search Jobs',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Look For Talent Jobs',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: Colors.lightBlue,
                    child: Text('Login',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Actors | Models | Singers |',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    'Musicians | Dance | Photographers |',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }


  void lookForJob() {
    Navigator.popAndPushNamed(context, '/agency');
  }

  void findJob() {
    Navigator.popAndPushNamed(context, '/register1');
  }

  void checkLoginStatus() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {

      setId(user);
      DocumentReference result =
      Firestore.instance.collection('users').document(user.uid);
      result.snapshots().first.then((onValue) {
        //print(onValue['userType']);
        if (onValue!=null) {
          setLocalInfo(onValue);
          if (onValue['userType'] == 'agency') {
            print('agency');
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            print('home');
            Navigator.pushReplacementNamed(context, '/home',arguments: user);
          }
        } else {
          Fluttertoast.showToast(msg: 'Could not sign in try again');
        }
      });
      }else{
      }

  }
  setId(user)async{
    try {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', user.uid);
    }catch(e){
      print(e);
    }
  }

  setLocalInfo(user) async{
    try {
      await prefs.setString('nickname', user['nickname']);
      await prefs.setString('photoUrl', user['photoUrl']);
      await prefs.setString('about', user['about']);
    }catch(e){
      print(e);
    }
  }
}
