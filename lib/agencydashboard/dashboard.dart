import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/chat/settings.dart';
import 'package:match_hire/model/Job.dart';
import 'package:match_hire/tabs/hired.dart';
import 'package:match_hire/tabs/home.dart';
import 'package:match_hire/settings/settings.dart';

// ignore: must_be_immutable
class AgencyDashboardPage extends StatefulWidget {
  String title;

  AgencyDashboardPage({this.title});

  @override
  _AgencyDashboardPageState createState() => _AgencyDashboardPageState();
}

class _AgencyDashboardPageState extends State<AgencyDashboardPage> {


  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeWidget(),
    HiredWidget()

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
          actions: <Widget>[
            PopupMenuButton(
              onSelected: takeAction,
              itemBuilder: (context){
                return Menu.choices.map((choice){
                  return PopupMenuItem(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              },

            )
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createJob,
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Hired'),
          ),
//          new BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Profile')
//          )
        ],
      ),
    );
  }





  void createJob() {
    Navigator.pushNamed(context, '/addjob');
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/landing');
  }


  void takeAction(String value) {
    if(value==Menu.settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings()));
    }else if(value == Menu.signOut){
      signOut();
      Fluttertoast.showToast(msg: 'signed out......');
    }
  }
}
