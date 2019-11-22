import 'package:flutter/material.dart';
import 'package:match_hire/model/User.dart';
import 'package:match_hire/settings/settings.dart';


// ignore: must_be_immutable
class RegisterOnePage extends StatefulWidget {
  String title;

  RegisterOnePage({this.title});

  @override
  _RegisterOnePageState createState() => _RegisterOnePageState();
}

class _RegisterOnePageState extends State<RegisterOnePage> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _wieghtController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

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
        child: ListView(
          children: <Widget>[
            Padding(
              child: TextFormField(
                controller: _nameController,
                decoration: new InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Name cannot be empty";
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
                controller: _genderController,
                decoration: new InputDecoration(
                  labelText: "Gender e.g male or female",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Gender cannot be empty";
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
                controller: _ageController,
                decoration: new InputDecoration(
                  labelText: "Age",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Age cannot be empty";
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
                controller: _wieghtController,
                decoration: new InputDecoration(
                  labelText: "Wieght in kg",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Weight  cannot be empty";
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
      User user = new User();

      user.email = _emailController.text;

      user.phone = _phoneNumberController.text;

      user.gender = _genderController.text;

      user.nickname = _nameController.text;

      user.age = _ageController.text;

      user.weight = _wieghtController.text;

      user.password = _passwordController.text;

      Navigator.pushNamed(context, '/register2',arguments: user);
    } else {
      return;
    }


  }




}
