import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pickmeup/Models/userModel.dart';
import 'package:pickmeup/Screens/DriverScreens/driverHome.dart';
import 'package:pickmeup/Screens/UserScreens/userHome.dart';
import 'package:pickmeup/Screens/loginScreen.dart';
import 'package:pickmeup/widgets/loading.dart';

class NavigateScreen extends StatefulWidget {
  final String token;
  NavigateScreen({this.token});
  @override
  _NavigateScreenState createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  UserModel currentUser = UserModel();

  Future authenticateToken(String token) async {
    //TODO: token expired bhayo bhane error aaucha tyo manage bachaina user model bacha matra
    var url = "http://localhost:3000/home/";
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': token
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map userData = jsonDecode(response.body);

      currentUser = UserModel.fromJson(userData);

      return true;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      //token verification failed--token expired
      return false;
    }
  }
  // Future<UserModel> authenticateToken(String token) async {

  //   //TODO: token expired bhayo bhane error aaucha tyo manage bachaina user model bacha matra
  //   var url = "http://localhost:3000/home/";
  //   var response = await http.get(url, headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'auth-token': token
  //   });

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     Map userData = jsonDecode(response.body);
  //     setState(() {
  //       currentUser = UserModel.fromJson(userData);
  //     });
  //     currentUser = UserModel.fromJson(userData);

  //     return currentUser;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authenticateToken(widget.token),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;

            if (data == true) {
              if (currentUser.role == 'user') {
                return HomePage();
              } else {
                return DriverHomePage();
              }
            } else {
              // return Loading();
              return LoginPage();
            }
          } else {
            return Loading();
          }
        });
  }
}
