import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_advisor/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String name;
  String email;
  String phoneNumber;
  String comments;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var locationMessage = "";

  void getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      // locationMessage = "$position.latitude, $position.longitude";
      locationMessage = "$position";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  final refDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final reference = refDatabase.reference();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings Page"),
        backgroundColor: Colors.grey[850],
      ),
      body: new Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Sign out'),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
//             SizedBox(height: 5),
            Text(
              "Emergency Contact Form",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
//             SizedBox(height: 5),
            new Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      decoration: InputDecoration(labelText: "Enter your name"),
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Name is invalid";
                        }
                      },
                      onSaved: (String value) {
                        name = value;
                      },
                    ),
                    new TextFormField(
                      decoration:
                      InputDecoration(labelText: "Enter your Email"),
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email is invalid";
                        }

                        if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Email is invalid";
                        }
                      },

                      onSaved: (String value) {
                        email = value;
                      },
                    ),
                    new TextFormField(
                      decoration:
                      InputDecoration(labelText: "Enter your Phone Number"),
                      keyboardType: TextInputType.number,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Phone Number is invalid";
                        }
                      },

                      onSaved: (String value) {
                        phoneNumber = value;
                      },
                    ),
                    new TextFormField(
                      maxLines: 3,
                      decoration:
                      InputDecoration(labelText: "Additional comments"),
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Comments are Required";
                        }
                      },

                      onSaved: (String value) {
                        comments = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade400,
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          _formKey.currentState.save();
                          print("Name: " + name);
                          print("Email: " + email);
                          print("Phone Number: " + phoneNumber);
                          print("Comment: " + comments);

                          getLocation();

                          reference.child('Emergency Information').push().set({
                            'name': name,
                            'email': email,
                            'phone': phoneNumber,
                            'comments': comments,
                            'location': locationMessage
                          }).asStream();

                          // print(locationMessage);

                          showDialog(
                              context: context,
                              builder: (_) => ActionDialog(name, email,
                                  phoneNumber, comments, locationMessage));
                        },
                        child: Text("Submit"))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget ActionDialog(String name, String email, String phoneNumber,
      String comments, var location) {
    // print(location);
    return AlertDialog(
      title: Text("Emergency Information Submitted"),
      content: Column(
        children: <Widget>[
          Text("Help is on the way! Do not move from your position."),
          Text(
              "Please always stay aware, if you are with someone,  stay together"),
          Text("Stay Calm"),
          Text("Stay Put"),
          Text("Stay On the Trails if possible"),
          Text("Find a shelter if weather gets bad. "),
          SizedBox(height: 10),
          Text(name),
          Text(email),
          Text(phoneNumber),
          Text(comments),
          Text(location),
        ],
      ),
      elevation: 24.0,
      backgroundColor: Colors.red.shade300,
    );
  }
}
