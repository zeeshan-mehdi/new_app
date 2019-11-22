import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_hire/model/Application.dart';
import 'package:match_hire/model/Job.dart';
import 'package:match_hire/settings/settings.dart';

// ignore: must_be_immutable
class JobsDetailScreen extends StatefulWidget {
  Job job;

  JobsDetailScreen({this.job});

  @override
  _JobsDetailScreenState createState() => _JobsDetailScreenState();
}

class _JobsDetailScreenState extends State<JobsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Job Detail',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )),
        body: Card(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: Constants().gray,
                child: Padding(
                  child: Text(
                    widget.job.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  child: Text(
                    widget.job.description,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ),
              Container(
                color: Constants().gray,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Budget : ' + widget.job.budget),
                      Text('Time : ' + widget.job.time),
                      widget.job.details!=null?Text('Agency : ' + widget.job.details):Container()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: HexColor('#0dd958'),
                    child: Text('Apply For Job',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: applyForJob,
                  ),
                ),
              ),
            ],
          ),
          elevation: 10,
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
        ));
  }


  void applyForJob() async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if(user==null){
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }


    final application = Firestore.instance.collection("applications").document(widget.job.jobId).collection('users');

    Application app = new Application(user.uid, user.displayName, widget.job.jobId, user.photoUrl);

    application.add(app.toJson());

    _showDialog();

  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Application"),
          content: new Text("You have Applied to the Job Successfully !!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
