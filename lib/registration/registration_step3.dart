import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match_hire/model/User.dart';
import 'package:match_hire/settings/settings.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

User newUser;



// ignore: must_be_immutable
class RegisterThirdPage extends StatefulWidget {
  User user;

  RegisterThirdPage({this.user});

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _videoController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _image = false;

  var image;
  var firebaseUser;

  //var _imagePath = "https://support.hostgator.com/img/articles/weebly_image_sample.png";
  var _imagePath = "images/upload1.jpg";
  final _formKey = GlobalKey<FormState>();

  var _uploadedFileURL;

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = isLoading? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();

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
      ),
      body: Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            Padding(
              child: GestureDetector(
                onTap: chooseFile,
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage(_imagePath, scale: .7),
                  radius: 90,
                ),
              ),
              padding: EdgeInsets.only(left: 50, right: 50, top: 5),
            ),
            Align(child: loadingIndicator,alignment: FractionalOffset.center,),
            Padding(
              child: TextFormField(
                maxLines: null,
                controller: _aboutController,
                decoration: new InputDecoration(
                  labelText: "About You",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "About You cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: TextFormField(
                maxLines: null,
                controller: _skillsController,
                decoration: new InputDecoration(
                  labelText: "Training | Skills | Experience",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Training | Skills | Experience cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: TextFormField(
                maxLines: null,
                controller: _videoController,
                decoration: new InputDecoration(
                  labelText: "Youtube Video Url",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Video Url cannot be empty";
                  }else if(!val.contains('youtube.com')){
                    return "Enter Valid Youtube Url";
                  }
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: TextFormField(
                controller: _countryController,
                decoration: new InputDecoration(
                  labelText: "Country",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "country cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                      color: Theme.of(context).accentColor,
                      onPressed: fetchAndForward,
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ))),
              padding: EdgeInsets.all(8),
            ),

          ],
        ),
      ),
    );
  }

  void fetchAndForward() {
    if (_formKey.currentState.validate()) {
      User user = widget.user;

      user.about = _aboutController.text;

      user.skills = _skillsController.text;

      user.video = _videoController.text;

      user.country = _countryController.text;

      user.userType = "talent";

      newUser = user;
      if (this._image)
        uploadFile();
      else
        Fluttertoast.showToast(msg: 'upload Picture First');
    } else {
      return;
    }
  }

  Future chooseFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    this._image = true;
    setState(() {
      this.image = image;
      _imagePath = image.path;
    });
  }

  Future uploadFile() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      try {
        user = (await _auth.createUserWithEmailAndPassword(
          email: newUser.email,
          password: newUser.password,
        ));
      } catch (e) {
          var result = (await _auth.signInWithEmailAndPassword(
              email: newUser.email, password: newUser.password));
           user = result;
      }
    }

    Fluttertoast.showToast(msg: 'please wait we are creating profile',toastLength: Toast.LENGTH_LONG);

    setState(() {
      isLoading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_imagePath)}}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('image Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        print(fileURL);
        _uploadedFileURL = fileURL;
        createProfile(user);
      });
    });
  }

  void createProfile(user) async {
    prefs = await SharedPreferences.getInstance();

    if (user != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        newUser.photoUrl = _uploadedFileURL;
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData(newUser.toJson());

        // Write data to local
        await prefs.setString('id', user.uid);
        await prefs.setString('nickname', newUser.nickname);
        await prefs.setString('photoUrl', newUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('about', documents[0]['about']);
      }

      setState(() {
        isLoading = false;
        Fluttertoast.showToast(msg: "Sign in success");

        Navigator.pushReplacementNamed(context, '/home',arguments: user);
      });
    }
  }
}
