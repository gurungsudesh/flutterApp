import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickmeup/Screens/UserScreens/userSettings.dart';
import '../../wrapper/secureStorage.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  // final uid;
  // HomePage({this.uid});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Storage storage = Storage();
  String token = '';
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  GoogleMapController _controller;

  static const LatLng _center = const LatLng(28.2154, 83.9453);

  //-------------------------------------------------------
  Position currentLocation;
  LatLng _currentPos;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  void initState() {
    storage.readToken().then(updateToken);
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150.0,
              child: DrawerHeader(
                child: Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF809fff),
                            size: 50.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        child: Text("Sudesh Gurung",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                wordSpacing: 0.5)),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF809fff),
                ),
              ),
            ),
            ListTile(
              title: listTileText("Your Trips"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: listTileText("Wallet"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: listTileText("Help"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: listTileText("Settings"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserSettings()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.person),
        backgroundColor: Color(0xFF809fff),
        splashColor: Colors.redAccent,
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
          child: Stack(children: [
        GoogleMap(
          mapToolbarEnabled: false,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          rotateGesturesEnabled: true,
          trafficEnabled: true,
          zoomControlsEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _currentPos,
            zoom: 30.0,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: FlatButton(
              color: Colors.blueAccent,
              onPressed: _getLocation,
              child: Text('Get Location')),
        )
      ])),
    );
  }

  Future<Position> locateUser() async {
    return GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  _getLocation() async {
    currentLocation = await locateUser();
    print("location found");
    setState(() {
      _currentPos = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('mero location $_currentPos');
  }

  void updateToken(String value) {
    setState(() {
      this.token = value;
    });
  }

  Widget listTileText(_text) {
    return Text(
      _text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300),
    );
  }
}
