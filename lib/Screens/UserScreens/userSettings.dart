import 'package:flutter/material.dart';
import 'package:pickmeup/Screens/UserScreens/userHome.dart';
import 'package:pickmeup/wrapper/Authenticate.dart';
import 'package:pickmeup/wrapper/secureStorage.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  Storage storage = Storage();
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage.readToken().then(updateToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
            FlatButton(
                child: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                }),
            Text(token),
            RaisedButton(
                child: Icon(Icons.logout),
                onPressed: () {
                  storage.deleteToken().then((_) => {
                        print("token deleted"),
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Authenticate()))
                      });
                }),
          ]),
        ),
      ),
    );
  }

  void updateToken(String value) {
    setState(() {
      this.token = value;
    });
  }
}
