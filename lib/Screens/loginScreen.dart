import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickmeup/Models/response.dart';

// ignore: unused_import
import 'package:pickmeup/Screens/UserScreens/userHome.dart';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:pickmeup/Screens/register.dart';
import 'package:pickmeup/widgets/loading.dart';
import 'package:pickmeup/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pickmeup/wrapper/Authenticate.dart';

import '../wrapper/secureStorage.dart';
import '../Models/response.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Storage storage = Storage();
  Response response = Response();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool _autovalidate = false;
  bool _errorShow = false;
  bool _isLoading = false;

  String error = "";

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            //key: _scaffoldKey,
            resizeToAvoidBottomInset: true,
            //backgroundColor: Color(0xFF99ffe4),
            body: ColorfulSafeArea(
              child: Container(
                // decoration: BoxDecoration(
                //     // gradient: LinearGradient(
                //     //     begin: Alignment.topRight,
                //     //     end: Alignment.bottomLeft,
                //     //     colors: [Color(0xFF99ffe4), Color(0xFF4dffcf)])
                //     ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [verticalText(), textLogin()],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Color(0xFF809fff)),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF809fff),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0, 0)),
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);

                                    if (value.isEmpty) {
                                      return 'Please enter the email';
                                    } else if (!regex.hasMatch(value))
                                      return '*Enter a valid email';
                                    else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _email = value; // or value
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: TextStyle(color: Color(0xFF809fff)),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF809fff),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0, 0)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '*Please enter the password';
                                    } else if (value.length < 6) {
                                      return "*Password should't be less than 6 characters";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _password = value; // or value
                                  },
                                ),
                                SizedBox(height: 20.0),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Forgot Password?',
                                      style:
                                          TextStyle(color: Color(0xFF809fff)),
                                    ),
                                  ),
                                  onTap: () {
                                    print("forgot password");
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    child: RaisedButton(
                                        padding: EdgeInsets.all(8.0),
                                        color: Color(0xFF809fff),
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              //color: Color(0xFF99ffe4),
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            var json;
                                            var url =
                                                "http://localhost:3000/user/login";
                                            //var response = await http.post(url,
                                            await http
                                                .post(url,
                                                    headers: <String, String>{
                                                      'Content-Type':
                                                          'application/json; charset=UTF-8',
                                                    },
                                                    body: jsonEncode(<String,
                                                        String>{
                                                      'email': _email,
                                                      'password': _password,
                                                    }))
                                                .then((response) => {
                                                      if (response.statusCode ==
                                                              200 ||
                                                          response.statusCode ==
                                                              201)
                                                        {
                                                          json = jsonDecode(
                                                              response.body),

                                                          // print(json);
                                                          storage
                                                              .saveToken(
                                                                  json['token'])
                                                              .then((_) => {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushReplacement(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Authenticate()))
                                                                  }),
                                                        }
                                                      else if (response
                                                                  .statusCode ==
                                                              400 ||
                                                          response.statusCode ==
                                                              401)
                                                        {
                                                          setState(() {
                                                            _isLoading = false;
                                                          }),
                                                          json = jsonDecode(
                                                              response.body),
                                                          setState(() {
                                                            error = json['msg'];
                                                            _errorShow = true;
                                                          }),
                                                          _emailController
                                                              .text = "",
                                                          _passwordController
                                                              .text = "",
                                                        }
                                                    })
                                                .catchError((error) {
                                              print(error);
                                              setState(() {
                                                _autovalidate = true;

                                                error =
                                                    "Cannot connect to internet";
                                                _errorShow = true;
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              _autovalidate = true;
                                            });
                                          }
                                        })),
                                SizedBox(height: 20.0),
                                Container(
                                    child: Row(children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        color: Color(0xFFdf9f9f),
                                        fontSize: 16.0),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      child: Text('Sign up',
                                          style: TextStyle(
                                              color: Color(0xFF809fff),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0)),
                                    ),
                                    onTap: () {
                                      //widget.toggleView();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                                    },
                                  )
                                ])),
                                SizedBox(height: 20.0),
                                _errorShow
                                    ? Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error,
                                              color: Color(0xFFdf9f9f),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              error,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFdf9f9f),
                                                  fontSize: 16.0),
                                            )
                                          ],
                                        ),
                                        //IconButton(icon: Icon(Icons.close), onPressed: null)
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
