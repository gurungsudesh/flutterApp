import 'dart:convert';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pickmeup/Screens/DriverScreens/driverHome.dart';
import 'package:pickmeup/Screens/register.dart';
import 'package:pickmeup/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:pickmeup/wrapper/Authenticate.dart';
import 'package:http/http.dart' as http;
import '../../wrapper/secureStorage.dart';

class DriverRegisterPage extends StatefulWidget {
  @override
  _DriverRegisterPageState createState() => _DriverRegisterPageState();
}

class _DriverRegisterPageState extends State<DriverRegisterPage> {
  Storage storage = Storage();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _corrPassword;
  String _dob;
  String _address;
  String _vehicleType;
  String _liscencePlate;
  bool _autovalidate = false;
  bool _errorShow = false;
  bool _isLoading = false;
  String _error = '';

  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _corrPassController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _liscencePlateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            //backgroundColor: Color(0xFF99ffe4),
            body: ColorfulSafeArea(
                child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Text('Sign Up hurry',
                            style: TextStyle(
                                fontSize: 24.0, fontStyle: FontStyle.italic)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  maxLength: 25,
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    icon: Icon(Icons.person),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Please enter the full name";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _name = value;
                                  },
                                ),
                                TextFormField(
                                  //obscureText: true,
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Password field is empty";
                                    } else if (value.length < 6) {
                                      return "*password must be longer than six letters";
                                    } else
                                      return null;
                                  },

                                  onSaved: (value) {
                                    _password = value;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: _corrPassController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Correct Password',
                                    icon: Icon(Icons.lock_outline),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Password field is empty";
                                    } else if (value.length < 6) {
                                      return "*password must be longer than six letters";
                                    } else if (_passwordController.text !=
                                        value) {
                                      return "*passwords donot match";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _corrPassword = value;
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    icon: Icon(Icons.mail_outline),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
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
                                DateTimeField(
                                  format: format,
                                  controller: _dobController,
                                  decoration: InputDecoration(
                                    labelText: 'Birth date',
                                    icon: Icon(Icons.calendar_today),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                  validator: (currentValue) {
                                    if (currentValue == null) {
                                      return "*choose the date of birth";
                                    } else
                                      return null;
                                  },
                                  onSaved: (currentValue) {
                                    //formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd])
                                    _dob = formatDate(
                                        currentValue, [yyyy, '-', mm, '-', dd]);
                                  },
                                ),
                                TextFormField(
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    icon: Icon(Icons.home),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*address is empty";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _address = value;
                                  },
                                ),
                                TextFormField(
                                  controller: _vehicleTypeController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Vehicle type',
                                    icon: Icon(Icons.directions_car),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Vehicle type is empty";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _vehicleType = value;
                                  },
                                ),
                                TextFormField(
                                  controller: _liscencePlateController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Liscence plate number',
                                    icon: Icon(Icons.confirmation_number),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*liscence plate number is empty";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _liscencePlate = value;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    //padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: RaisedButton(
                                        // padding: EdgeInsets.all(8.0),
                                        color: Color(0xFF809fff),
                                        child: Text(
                                          'Sign up as a driver',
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

                                            print(_passwordController.text);

                                            var url =
                                                "http://localhost:3000/user/register";
                                            var response = await http.post(url,
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body:
                                                    jsonEncode(<String, String>{
                                                  'email': _email,
                                                  'password': _password,
                                                  'name': _name,
                                                  'role': 'driver',
                                                  'dob': _dob,
                                                  'address': _address,
                                                  'vehicleType': _vehicleType,
                                                  'liscencePlate':
                                                      _liscencePlate
                                                }));

                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201) {
                                              final json =
                                                  jsonDecode(response.body);

                                              storage
                                                  .saveToken(json['token'])
                                                  .then((_) => {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Authenticate()))
                                                      });
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              final json =
                                                  jsonDecode(response.body);
                                              setState(() {
                                                _error = json['msg'];
                                                _errorShow = true;
                                              });
                                              _nameController.text = "";
                                              _passwordController.text = "";
                                              _corrPassController.text = "";
                                              _emailController.text = "";
                                              _dobController.text = "";
                                              _addressController.text = "";
                                              _vehicleTypeController.text = "";
                                              _liscencePlateController.text =
                                                  "";
                                            }

                                            //Navigate to home page of driver

                                            // Navigator.of(context)
                                            //     .pushReplacement(
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 DriverHomePage()));

                                            //print(result);

                                            // if (result ==
                                            //     AuthResultStatus.successful) {
                                            //   _nameController.text = "";
                                            //   _passwordController.text = "";
                                            //   _corrPassController.text = "";
                                            //   _emailController.text = "";
                                            //   _dobController.text = "";
                                            //   _addressController.text = "";
                                            //   _vehicleTypeController.text = "";
                                            //   _liscencePlateController.text =
                                            //       "";
                                            //   // Navigator.pop(context);
                                            //   // Navigate to success page
                                            // } else {
                                            //   setState(() {
                                            //     _isLoading = false;
                                            //     _errorShow = true;
                                            //     _error = AuthExceptionHandler
                                            //         .generateExceptionMessage(
                                            //             result);
                                            //   });
                                            //   _nameController.text = "";
                                            //   _passwordController.text = "";
                                            //   _corrPassController.text = "";
                                            //   _emailController.text = "";
                                            //   _dobController.text = "";
                                            //   _addressController.text = "";
                                            //   _vehicleTypeController.text = "";
                                            //   _liscencePlateController.text =
                                            //       "";
                                            // }
                                          } else {
                                            setState(() {
                                              _autovalidate = true;
                                            });
                                          }
                                        })),
                                SizedBox(height: 5.0),
                                Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: RaisedButton(
                                      // padding: EdgeInsets.all(8.0),
                                      color: Color(0xFF809fff),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'Go back',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        //widget.toggleViewToSignUp();
                                        Navigator.of(context).pop(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPage()));
                                      }),
                                ),
                                SizedBox(height: 5.0),
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
                                              _error,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFdf9f9f),
                                                  fontSize: 12.0),
                                            )
                                          ],
                                        ),
                                        //IconButton(icon: Icon(Icons.close), onPressed: null)
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
  }
}
