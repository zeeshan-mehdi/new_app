import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_hire/model/Job.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Job> allJobs = new List<Job>();

  var _progressBarActive = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _progressBarActive == true
          ? Center(child: const CircularProgressIndicator())
          : new Container(),
      StreamBuilder(
          stream: Firestore.instance
              .collection("jobs")
              .document('user')
              .collection('jobs')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];

                  Job job = Job.fromJson(ds);

                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title:job.title.length > 27
                          ? Text(job.title.substring(0, 27) + '..')
                          : Text(job.title),
                      subtitle: job.description.length > 27
                          ? Text(job.description.substring(0, 27) +
                              '..')
                          : Text(job.description),
                      trailing: FlatButton(
                        child: Text(
                          'View Applicants',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          viewApplications(index);
                        },
                      )
                    ),
                  );
                },
              );
            }else{
              return Text('No Job Found');
            }
          }),
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchJobs();
    super.initState();
  }


  void fetchJobs() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    CollectionReference snapshot = Firestore.instance
        .collection("jobs")
        .document('user')
        .collection('jobs');

    snapshot.getDocuments().then((jobs) {
      print(jobs);
      jobs.documents.forEach((job) {
        print(job['title']);
        if (job['agency'] == user.uid) {
          print('true');
          Job job1 = new Job(
              job['title'],
              job['description'],
              job['budget'],
              job['time'],
              job['fileUrl'],
              job['agency'],
              job['category'],
              job['location'],
              job['detials'],
              jobId: job.documentID);

          setState(() {
            _progressBarActive = false;
            allJobs.add(job1);
          });
        }
      });
    });
  }

  void viewApplications(index) {
    Navigator.pushNamed(context, '/applications', arguments: allJobs[index]);
    setState(() {

    });
  }
}
