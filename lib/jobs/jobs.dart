


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/chat/chat.dart';
import 'package:match_hire/chat/settings.dart';
import 'package:match_hire/jobs/chatting_with_users.dart';
import 'package:match_hire/jobs/saved.dart';
import 'package:match_hire/main.dart';
import 'package:match_hire/settings/settings.dart';

class Jobs extends StatefulWidget {

  static FirebaseUser user;

  Jobs({user});

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {


  int _currentIndex = 0;
  final List<Widget> _children = [
    JobsScreen(user: Jobs.user,),
    SavedJobs(),
    ChattingWith()

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setId();
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
        title:  Row(
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
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Jobs'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.save),
            title: Text('Saved Jobs'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chat')
          )
        ],
      ),
    );
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

  void setId() async {
    Jobs.user = await FirebaseAuth.instance.currentUser();
  }
}
