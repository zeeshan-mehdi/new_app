import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_hire/model/Job.dart';


class AddJobScreen extends StatefulWidget {

  AddJobScreen({Key key}) : super(key: key);

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  var _locations = ['ACTOR','MODEL','SINGER','MUSICIAN','DANCE','PHOTOGRAPHER'];

  var _selected;

  DateTime selectedDate = DateTime.now();

  var _locationsController = TextEditingController();
  var _agencyController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
//    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('length ............................................'+length.toString());

    //Fluttertoast.showToast(msg: 'Length' + LoginPage.users.length.toString());


    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Add Project'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          Padding(
            child: TextFormField(
              controller: _titleController,
              decoration: new InputDecoration(
                labelText: "Project Title",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "title cannot be empty";
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
              child:DropdownButton(
            hint: Text('Please choose a Talent Type'), // Not necessary for Option 1
            value: _selected,
            onChanged: (newValue) {
              setState(() {
                _selected = newValue;
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),padding: EdgeInsets.all(8),
          ),
          Padding(
            child: TextFormField(
              maxLines: null,
              controller: _descController,
              decoration: new InputDecoration(
                labelText: "Job Details",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Job Details cannot be empty";
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
              controller: _locationsController,
              decoration: new InputDecoration(
                labelText: "Location e.g London UK",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Location cannot be empty";
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
              controller: _budgetController,
              decoration: new InputDecoration(
                labelText: "Budget in \$ like 20",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Budget cannot be empty";
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
              controller: _agencyController,
              decoration: new InputDecoration(
                labelText: "Agency Details",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Agency Detail Field cannot be empty";
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
            child: Column(
              children: <Widget>[
                Text("Start Date ${selectedDate.toLocal()}"),
                SizedBox(height: 20.0,),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select start date'),
                ),
              ],
            ),
            padding: EdgeInsets.all(5),
          ),
          Padding(
            child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(2.0),
                        side: BorderSide(color: Theme.of(context).accentColor)),
                    color: Theme.of(context).accentColor,
                    onPressed: createJob,
                    child: const Text(
                      "Add Project",
                      style: TextStyle(color: Colors.white),
                    ))),
            padding: EdgeInsets.all(8),
          )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void createJob() async{

    var userId = await FirebaseAuth.instance.currentUser();
    final newJob = Firestore.instance.collection("jobs").document('user').collection("jobs");

    print(selectedDate);
    print(_selected);

    Job job = new Job(_titleController.text, _descController.text, _budgetController.text, selectedDate.toString(), userId.photoUrl, userId.uid, _selected, _locationsController.text,_agencyController.text);

    newJob.add(job.toJson());


    Fluttertoast.showToast(msg: 'Job Added');

    Navigator.of(context).pop();
  }
}
