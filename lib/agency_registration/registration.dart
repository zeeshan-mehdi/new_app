import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match_hire/model/Agency.dart';
import 'package:match_hire/model/User.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';


// ignore: must_be_immutable
class AgencyRegisterPage extends StatefulWidget {
  String title;

  AgencyRegisterPage({this.title});

  @override
  _AgencyRegisterPageState createState() => _AgencyRegisterPageState();
}

class _AgencyRegisterPageState extends State<AgencyRegisterPage> {
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _image;

  var _imagePath = "images/upload1.jpg";

  static bool isLoading = false;

  File image;
  Agency agency;

  var _uploadedFileURL;

  SharedPreferences prefs;


  Widget loadingIndicator = isLoading? new Container(
    color: Colors.grey[300],
    width: 70.0,
    height: 70.0,
    child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
  ):new Container();

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
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
                controller: _nameController,
                decoration: new InputDecoration(
                  labelText: "Agency Name",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Agency Name cannot be empty";
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
                controller: _aboutController,
                decoration: new InputDecoration(
                  labelText: "About Agency",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "About Agency cannot be empty";
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
                controller: _contactController,
                decoration: new InputDecoration(
                  labelText: "Contact Person",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Contact Person cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.phone,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: TextFormField(
                controller: _addressController,
                decoration: new InputDecoration(
                  labelText: "Address",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Address cannot be empty";
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
                controller: _websiteController,
                decoration: new InputDecoration(
                  labelText: "Website",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Website cannot be empty";
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
                controller: _phoneNumberController,
                decoration: new InputDecoration(
                  labelText:
                  "Enter Phone Number with country code e.g. +12025550178",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Phone Number cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.phone,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),

            Padding(
              child: TextFormField(
                controller: _emailController,
                decoration: new InputDecoration(
                  labelText: "Enter Email Address ",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              padding: EdgeInsets.all(8),
            ),
            Padding(
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: new InputDecoration(
                  labelText: "Password ",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
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
                        "Create Profile",
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
        this.agency = new Agency(_nameController.text, _aboutController.text, _contactController.text, _addressController.text, _imagePath, _phoneNumberController.text, _websiteController.text, _emailController.text,_passwordController.text);
        uploadFile();
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
      print('user null');
      try {
        user = (await _auth.createUserWithEmailAndPassword(
          email: agency.email,
          password: agency.password,
        ));
      } catch (e) {
        print(e);
        var result = (await _auth.signInWithEmailAndPassword(
            email: agency.email, password: agency.password));
        user = result;
      }
    }else{
      print('${user.email}');
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
        agency.photoUrl = _uploadedFileURL;
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
        agency.photoUrl = _uploadedFileURL;

        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData(agency.toJson());

        // Write data to local
        await prefs.setString('id', user.uid);
        await prefs.setString('nickname', agency.nickname);
        await prefs.setString('photoUrl', agency.photoUrl);
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

        Navigator.popAndPushNamed(context, '/dashboard',arguments: user);
      });
    }
  }




}
