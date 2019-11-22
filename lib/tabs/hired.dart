import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/model/Job.dart';
import 'package:match_hire/model/chat_model.dart';
import 'package:match_hire/model/hired_user.dart';
import 'package:match_hire/settings/RoutesGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiredWidget extends StatefulWidget {
  @override
  _HiredWidgetState createState() => _HiredWidgetState();


}

class _HiredWidgetState extends State<HiredWidget> {
  List<HiredUser> users = new List<HiredUser>();

  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
  }

  var _progressBarActive = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _progressBarActive == true?Center(child: const CircularProgressIndicator()):new Container(),
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
                    child: Text('Chat',style: TextStyle(color: Colors.white),),
                    color: Colors.green,
                    onPressed:(){
                        openChat(users[index]);
                    },
                  ),
                  onTap: () {
                    //viewApplications(index);
                  },
                ),);
            }),
      ],
    );
  }

  fetchUsers()async{

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var id = prefs.get('id');
      Firestore.instance
          .collection("hired")
          .document(id).snapshots().forEach((snapshot) {
        setState(() {
          _progressBarActive = false;
        });

        HiredUser user = HiredUser.empty();
        try {
          user.fromJson(snapshot.data);

          users.add(user);
        }catch(e){
          print(e);
        }
        if(users.length==0) Fluttertoast.showToast(msg: 'No One Hired !!!');
      });
    }catch(e){
      print(e);
      Fluttertoast.showToast(msg: 'something went wrong!!!');
    }

  }

  void openChat(user) async{
    RouteGenerator.peerId = user.id;
    RouteGenerator.peerAvatar = user.photoUrl;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Chat chat = new Chat(prefs.get('id'), user.userId, user.nickname, user.photoUrl);

    await Firestore.instance.collection('chat').add(chat.toJson());

    Navigator.pushNamed(context, '/chat');
  }



}
