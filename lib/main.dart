import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/SplashScreen.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

