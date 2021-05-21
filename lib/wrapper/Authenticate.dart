import 'package:flutter/material.dart';
import 'package:pickmeup/Screens/loginScreen.dart';
import 'package:pickmeup/Screens/navigateScreen.dart';
import '../wrapper/secureStorage.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  Storage storage = Storage();
  String token = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: storage.readToken(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            token = snapshot.data;

            return NavigateScreen(
              token: token,
            );
          } else {
            return LoginPage();
          }
        });
  }
}
