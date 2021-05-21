import 'package:flutter/material.dart';
import 'package:pickmeup/Screens/loginScreen.dart';
import 'package:pickmeup/wrapper/Authenticate.dart';
import 'package:pickmeup/wrapper/secureStorage.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Home'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                //sign Out functions
                storage.deleteToken().then((_) => {
                      print("token deleted"),
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Authenticate()))
                    });
              },
              icon: Icon(Icons.person),
              label: Text('Logout'))
        ],
      ),
      body: Center(
        child: Text("This is the driver home page"),
      ),
    );
  }
}
