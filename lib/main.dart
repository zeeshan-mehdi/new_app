import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:match_hire/model/Job.dart';
import 'package:match_hire/settings/settings.dart';

import 'chat/settings.dart';
import 'registration/landing.dart';

void main() async {
  runApp(Landing());
}

// ignore: must_be_immutable
class JobsScreen extends StatefulWidget {
  FirebaseUser user;

  JobsScreen({this.user});

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    // isLoggedIn();
    // getJobs();

    return StreamBuilder(
      stream: Firestore.instance
          .collection("jobs")
          .document('user')
          .collection('jobs')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Card(
                  margin: EdgeInsets.all(5),
                  elevation: 3,
                  child: ListTile(
                      onTap: () {
                        handleItemClick(ds, ds.documentID);
                      },
                      title: Row(
                        children: <Widget>[
                          Text(
                            ds['title'].length > 27
                                ? ds['title'].substring(0, 27) + '..'
                                : ds['title'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: ds['saved'] == null || ds['saved'] == false
                            ? Icon(
                                Icons.favorite_border,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.blue,
                              ),
                        onPressed: () {
                          if (ds['saved'] == true)
                            saveJob(ds.documentID, Job.fromJson(ds), false);
                          else
                            saveJob(ds.documentID, Job.fromJson(ds), true);
                        },
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Align(
                            child: Text(
                              'Budget',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              ds['budget'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              'Start Date',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                                DateFormat.yMMMd()
                                    .format(DateTime.parse(ds['time']))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              ds['description'].length > 27
                                  ? ds['description'].substring(0, 27) + '..'
                                  : ds['description'],
                              style: TextStyle(fontSize: 20),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      )),
                );
              });
        } else {
          return Text('No job found');
        }
      },
    );
  }

  void handleItemClick(ds, id) {
    Job job = new Job(
        ds['title'],
        ds['description'],
        ds['budget'],
        ds['time'],
        ds['fileUrl'],
        ds['agency'],
        ds['category'],
        ds['location'],
        ds['details'],
        jobId: id);

    Navigator.pushNamed(context, '/detail', arguments: job);
  }

  void isLoggedIn() {
    if (widget.user == null) Navigator.popAndPushNamed(context, '/login');
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/landing');
  }

  void takeAction(String value) {
    if (value == Menu.settings) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    } else if (value == Menu.signOut) {
      signOut();
      Fluttertoast.showToast(msg: 'signed out......');
    }
  }

  void saveJob(id, Job job, flag) async {
    job.saved = flag;

    await Firestore.instance
        .collection("jobs")
        .document('user')
        .collection('jobs')
        .document(id)
        .updateData(job.toJson());

    setState(() {});
  }
}
