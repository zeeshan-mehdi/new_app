import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/model/User.dart';
import 'package:match_hire/model/chat_model.dart';
import 'package:match_hire/model/hired_user.dart';
import 'package:match_hire/settings/RoutesGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TalentProfile extends StatefulWidget {
  final User user;

  TalentProfile(this.user);

  @override
  _TalentProfileState createState() => _TalentProfileState();
}

class _TalentProfileState extends State<TalentProfile> {
  bool showProgressBar = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
        'Telent Profile',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    ),
    centerTitle: true,
    ),
    body: Stack(
      children: <Widget>[
        showProgressBar==true ? Center(child: const CircularProgressIndicator(),): Container(),
        ListView(
          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.user.photoUrl),
                  ),
                  Text(widget.user.nickname,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30),)
                ],
              ),
            ),

            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user.ethnicity,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user.skills,style: TextStyle(fontSize: 15),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user.about,style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gender :  '+widget.user.gender,style: TextStyle(fontSize: 15),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Height :  '+widget.user.height,style: TextStyle(fontSize: 15),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hair Style :  '+widget.user.hairStyle,style: TextStyle(fontSize: 15),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hair Color :  '+widget.user.hairColor,style: TextStyle(fontSize: 15),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Country :  '+widget.user.country,style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(width:MediaQuery.of(context).size.width-50,child: FlatButton(child: Text('Watch Video',style: TextStyle(color: Colors.white),),onPressed: watchVideo,color: Colors.red,)),
                  Container(width:MediaQuery.of(context).size.width-50,child: FlatButton(child: Text('Chat',style: TextStyle(color: Colors.white)),onPressed: openChat,color: Colors.blue,)),
                  Container(width:MediaQuery.of(context).size.width-50,child: FlatButton(child: Text('Hire',style: TextStyle(color: Colors.white)),onPressed: hire,color: Colors.green,)),

                ],
              ),
            )
          ],
        ),
      ],

    ),);
  }

  void openChat()async {
    RouteGenerator.peerId = widget.user.userId;
    RouteGenerator.peerAvatar = widget.user.photoUrl;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Chat chat = new Chat(prefs.get('id'), widget.user.userId, widget.user.nickname, widget.user.photoUrl);

    await Firestore.instance.collection('chat').add(chat.toJson());


    Navigator.pushNamed(context, '/chat');
  }

  void watchVideo() async{
    String url = widget.user.video;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      Fluttertoast.showToast(msg: 'cannot launch this url');
    }
  }

  void hire() async {

    setState(() {
      showProgressBar = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');

    var jobId = prefs.get('jobId');

    HiredUser hiredUser = new HiredUser(widget.user.userId, widget.user.nickname, widget.user.photoUrl, jobId, id);

    Firestore.instance.collection('hired').document(id).setData(hiredUser.toJson());

    setState(() {
      showSuccess();
      showProgressBar = false;
    });

  }

  showSuccess(){
    showDialog(context: context,builder: (context){
      return AlertDialog(title: Text('Hiring Successful'),content: Text('You have successfully hired this talent Now this will be visible under hired section'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }


}
