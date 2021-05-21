import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:pickmeup/wrapper/Authenticate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    );
  }
  /*
  
  

  
   */
}

//GOOGLE MAPS---->
//ANDRIOD KEY = AIzaSyC2R2p6U2_3lXs8FCMhS9yV1K08bBXMdNI
//IOS KEY = AIzaSyDxa1vYbjjruwbIqTS6sPbifcW0y-gQw2U
