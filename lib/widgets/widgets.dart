import 'package:flutter/material.dart';

Widget verticalText() {
  return Padding(
    padding: const EdgeInsets.only(top: 60, left: 10),
    child: RotatedBox(
      quarterTurns: -1,
      child: Text(
        'Sign In',
        style: TextStyle(
            color: Color(0xFF809fff),
            fontSize: 38,
            fontWeight: FontWeight.w800),
      ),
    ),
  );
}

Widget textLogin() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
    child: Container(
      //color: Colors.green,
      height: 200,
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          Center(
            child: Text(
              "Let's get started with pick me up. ",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF809fff),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget verticalTextSignUp() {
  return Padding(
    padding: const EdgeInsets.only(top: 60, left: 10),
    child: RotatedBox(
      quarterTurns: -1,
      child: Text(
        'Sign Up',
        style: TextStyle(
            color: Color(0xFF809fff),
            fontSize: 38,
            fontWeight: FontWeight.w800),
      ),
    ),
  );
}

Widget signupText() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
    child: Container(
      //color: Colors.green,
      height: 200,
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          Center(
            child: Text(
              "Let's get started with pick me up. ",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF809fff),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget inputEmail(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
    child: Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            fillColor: Color(0xFF0b665a),
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white70),
            focusColor: Colors.white),
      ),
    ),
  );
}
