import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:next_gen_sports_app/Booking.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:next_gen_sports_app/LoginPage.dart';
import 'package:firebase_database/firebase_database.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UserDetails user = UserDetails();
  //var that stores the url of the logo
  String logoUrl;
  List<Marker> markers = [];

  
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }




  _navigate() async {
    SharedPreferences _uid = await SharedPreferences.getInstance();
   String uid = _uid.getString('userUid');
    user.uid = uid;
    if(uid!=null){
      await FirebaseDatabase.instance.reference().child("Users").child(uid).once().then((DataSnapshot snapshot){
        user.getDetails(snapshot.value['Name'], snapshot.value['Email'], snapshot.value['DOB']);
      }).catchError((e){
        print(e);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      });
      //await _getMarkers();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)));

    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }


  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, _navigate);
  }
  _put() async
  {
    for(int i =0;i<=6;i++)
    {
      await FirebaseDatabase.instance.reference().child("Bookings").child("1").child((DateTime.now().day+i).toString()).child("Morning").child(i.toString())
          .update({
        "Time" : "6 AM - 7 AM",
      });
    }
  }
  @override
  void initState() {
    super.initState();
    startTime();
    //_put();
    //  _messaging.getToken().then((token){
    // print(token);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(color: Colors.white,
        child: Column(
          children: <Widget>[
           Padding(
             padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
             child: Row(mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQLZ6yTmg3ucwhZdXwhFLac_vEykBest-mvFWOawTJglUPHIcIb",
                 height: MediaQuery.of(context).size.height/7,
                   width: MediaQuery.of(context).size.height/7,),
               ],
             ),
           ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
              child: Text("Welcome to NextGen Sports",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width/17
              ),),
            ),

            Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/4),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      )
    );
  }
}
