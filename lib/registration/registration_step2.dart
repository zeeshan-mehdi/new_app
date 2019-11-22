import 'package:flutter/material.dart';
import 'package:match_hire/model/User.dart';
import 'package:match_hire/settings/settings.dart';


// ignore: must_be_immutable
class RegisterSecondPage extends StatefulWidget {
  User user;

  RegisterSecondPage({this.user});

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _hairColorController = TextEditingController();
  TextEditingController _hairStyleController = TextEditingController();
  TextEditingController _waistController = TextEditingController();
  TextEditingController _shoeSizeController = TextEditingController();
  TextEditingController _ethnicityController = TextEditingController();
  TextEditingController _chestController = TextEditingController();
  TextEditingController _dressSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
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
              child: TextFormField(
                controller: _heightController,
                decoration: new InputDecoration(
                  labelText: "Height",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Height cannot be empty";
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
                controller: _hairStyleController,
                decoration: new InputDecoration(
                  labelText: "Hair Style",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Hair Style cannot be empty";
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
                controller: _hairColorController,
                decoration: new InputDecoration(
                  labelText: "Hair Color",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Hair Color cannot be empty";
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
                controller: _shoeSizeController,
                decoration: new InputDecoration(
                  labelText: "Shoe Size",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Shoe Size cannot be empty";
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
                controller: _dressSizeController,
                decoration: new InputDecoration(
                  labelText: "Dress Size (woman)",
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
              child: TextFormField(
                controller: _waistController,
                decoration: new InputDecoration(
                  labelText: "Bust/Hips/waist (females) ",
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
              child: TextFormField(
                controller: _chestController,
                decoration: new InputDecoration(
                  labelText: "Chest Size (Male) ",
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
              child: TextFormField(
                controller: _ethnicityController,
                decoration: new InputDecoration(
                  labelText: "Ethnicity",
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
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ))),
              padding: EdgeInsets.all(8),
            )
          ],
        ),
      ),
    );
  }

  void fetchAndForward() {
    if (_formKey.currentState.validate()) {
      User user = widget.user;

      user.height = _heightController.text;

      user.hairStyle = _hairStyleController.text;

      user.hairColor = _hairColorController.text;

      user.shoeSize = _shoeSizeController.text;

      user.dressSize = _dressSizeController.text;

      user.waist = _waistController.text;

      user.chest= _chestController.text;

      user.ethnicity = _ethnicityController.text;

      Navigator.pushNamed(context, '/register3',arguments: user);
    } else {
      return;
    }
  }
}
