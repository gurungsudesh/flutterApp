import 'package:flutter/material.dart';
import 'package:pickmeup/Screens/DriverScreens/driverRegister.dart';
import 'package:pickmeup/Screens/UserScreens/userRegister.dart';
import 'package:pickmeup/Screens/loginScreen.dart';
import 'package:pickmeup/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          //color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [verticalTextSignUp(), signupText()],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: Text(
                  'How would you like to join the pick me up team. As a driver or a user?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 5,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card 1 tapped.');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserRegister()));
                      },
                      child: Container(
                        //width: 190,
                        width: MediaQuery.of(context).size.width / 2.5,
                        //height: ,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Icon(Icons.person, size: 80, color: Colors.grey),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'as a user',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card 2 tapped.');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DriverRegisterPage()));
                      },
                      child: Container(
                        //width: 190,
                        width: MediaQuery.of(context).size.width / 2.5,
                        //height: ,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 80,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('as a driver',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  color: Color(0xFF809fff),
                  child: Text("Go back to Login",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: () {
                    //widget.toggleView();

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
