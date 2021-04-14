// import 'dart:html';
import 'package:travel_advisor/AuthService.dart';
import 'package:travel_advisor/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travel_advisor/main.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password;

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Advisor"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            'Sign up to begin your National Park journeys!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // NEW form
          SizedBox(height: 20.0),
          Form(
            key: formKey,
            child: Column(
              children: buildInputs(),
            ),
          ),

          SizedBox(height: 20.0),

          // Could add error messages if wrong
          ElevatedButton(
            child: Text("SIGN UP"),
            onPressed: () {
              if (validate()) {
                context
                    .read<AuthenticationService>()
                    .signUp(email: _email.trim(), password: _password.trim());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthenticationWrapper()));
              }
            },
          ),
          SizedBox(height: 10.0),
          TextButton(
              child: Text('Already have an account? Log in!'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
        ]),
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    textFields.add(
      TextFormField(
        validator: context.read<AuthenticationService>().validateEmail,
        decoration: InputDecoration(
          hintText: "Email Address",
        ),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(
      TextFormField(
        validator: context.read<AuthenticationService>().validatePassword,
        decoration: InputDecoration(
          hintText: "Password",
        ),
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    );
    textFields.add(SizedBox(
      height: 20,
    ));
    return textFields;
  }
}
