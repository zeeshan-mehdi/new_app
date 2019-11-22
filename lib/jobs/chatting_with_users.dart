

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_hire/settings/RoutesGenerator.dart';

import 'jobs.dart';

class ChattingWith extends StatefulWidget {
  @override
  _ChattingWithState createState() {

    return _ChattingWithState();
  }
}

class _ChattingWithState extends State<ChattingWith> {
  @override
  Widget build(BuildContext context) {

    if(Jobs.user==null){
      return Center(child: Text('You are not logged In',style: TextStyle(fontSize: 20),));
    }

    return StreamBuilder(
      stream: Firestore.instance
          .collection("chat")
          .where('to',isEqualTo:Jobs.user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(ds['name']),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(ds['photoUrl']),
                        backgroundColor: Colors.transparent,
                      ),
                      trailing: FlatButton(
                        child: Text(
                          'See Messages',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          openChat(ds['from'],ds['photoUrl']);
                        },
                      ),
                      onTap: () {
                        //viewApplications(index);
                      },
                    ),
                );
              });
        } else {
          return Text('No Chat Found');
        }
      },
    );
  }

  void openChat(peerId,peerPhotoUrl)async {
    RouteGenerator.peerId = peerId;
    RouteGenerator.peerAvatar = peerPhotoUrl;
    Navigator.pushNamed(context, '/chat');
  }
}
