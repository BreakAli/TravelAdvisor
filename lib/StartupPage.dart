// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:travel_advisor/LoginPage.dart';
import 'package:travel_advisor/SignupPage.dart';

class StartupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Start up Page"),
      //   backgroundColor: Colors.black87,
      // ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/StartupPage.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: <Widget>[
          SizedBox(height: 50.0),
          SizedBox(
            child: Center(
              child: Text(
                'Travel Advisor',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                // Josh: don't know how to use LicenseRegistry, may need it if using googlefonts
                // style: GoogleFonts.frederickaTheGreat(),
              ),
            ),
          ),
          SizedBox(height: 240.0),
          // Could add error messages if wrong
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown[400])),
              child: Text("LOG IN"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
          SizedBox(height: 30.0),
          Text(
            "Don't have an account? ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown[400])),
              child: Text("Sign up"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              }),
        ]),
      ),
    );
  }
}
