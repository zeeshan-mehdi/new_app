import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/model/Job.dart';
import 'package:match_hire/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationsPage extends StatefulWidget {
  final Job job;

  ApplicationsPage(this.job);

  @override
  _ApplicationsPageState createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  List<User> users = new List<User>();

  List<String> ids = new List<String>();

  bool _progressBarActive = true;

  @override
  void initState() {
    // TODO: implement initState
    _progressBarActive = true;
    fetchApplicants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            'Applications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            _progressBarActive == true
                ? Center(child: const CircularProgressIndicator())
                : new Container(),
            ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(users[index].nickname),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(users[index].photoUrl),
                        backgroundColor: Colors.transparent,
                      ),
                      trailing: FlatButton(
                        child: Text(
                          'View Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          viewProfile(users[index]);
                        },
                      ),
                      onTap: () {
                        //viewApplications(index);
                      },
                    ),
                  );
                }),
          ],
        ));
  }

  fetchApplicants() async {
    Firestore.instance
        .collection("applications")
        .document(widget.job.jobId)
        .collection('users')
        .getDocuments()
        .then((snapshot) {
      print(snapshot);
      snapshot.documents.forEach((req) {
        ids.add(req['userId']);
      });

      print(ids.length);

      if(ids.length == 0){
        Fluttertoast.showToast(msg: 'No Application Found');
        setState(() {
          _progressBarActive = false;
        });
      }


      for (int i = 0; i < ids.length; i++) {
        print(ids[i]);
        fetchUsers(ids[i]);
      }
    });
  }

  fetchUsers(req) async {

      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();

      sharedPreferences.setString('jobId', widget.job.jobId);

      DocumentReference shot =
      Firestore.instance.collection("users").document(req);

      DocumentSnapshot ref = await shot
          .snapshots()
          .first;

      print(ref);

      if (ref == null) {
        print('ITS NULL');
        return;
      }

      String name;

      try {
        name = ref.data['nickname'];

        if (name == null) {
          name = ref['name'];
        }
      } catch (e) {
        print(e);
      }

      User user = new User.create(
          name,
          ref['email'],
          ref['photoUrl'],
          ref['password'],
          ref['height'],
          ref['weight'],
          ref['hairStyle'],
          ref['waist'],
          ref['userType'],
          ref['subscription'],
          ref['gender'],
          ref['country'],
          ref['phone'],
          ref['hairColor'],
          ref['eyeColor'],
          ref['shoeSize'],
          ref['dressSize'],
          ref['ethnicity'],
          ref['about'],
          ref['skills'],
          ref['video'],
          ref['age'],
          ref['chest'],
          userId: req);

      setState(() {
        _progressBarActive = false;
        users.add(user);
      });

  }

  void viewProfile(user) {
    Navigator.pushNamed(context, '/talentprofile', arguments: user);
  }
}
