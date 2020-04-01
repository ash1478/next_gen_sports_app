import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_sports_app/Booking_History.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/LoginPage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  UserDetails user;
  Profile(this.user);
  @override
  _ProfileState createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  UserDetails user;
  _ProfileState(this.user);
  int userSlotCount;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl =
        'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg';

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        index: 2,
        buttonBackgroundColor: Colors.redAccent,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.history,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: Colors.cyan[600],
        onTap: (index){
          if(index == 1){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)));
          }
          else if(index == 0){
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingHistory(user, monthCount)));
          }
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () async {
                SharedPreferences pref_email =
                    await SharedPreferences.getInstance();
                SharedPreferences pref_uid =
                    await SharedPreferences.getInstance();
                pref_email.remove('userEmail');
                pref_uid.remove('userUid');
                FirebaseAuth.instance.signOut().then((val) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height / 25.0,
              ),
              CircleAvatar(
                radius: _width < _height ? _width / 6 : _height / 6,
                backgroundImage: NetworkImage(imgUrl),
              ),
              SizedBox(
                height: _height / 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 15,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _height / 50, left: _width / 8, right: _width / 8),
                child: Text(
                  user.phone,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                      color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(children: <Widget>[
                // Divider(height: _height / 20, color: Colors.teal,),
                SizedBox(
                  height: _height / 25,
                ),

                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(_width / 30),
                      border: Border.all(width: 1)),
                  margin:
                      EdgeInsets.only(left: _width / 20, right: _width / 20),
                  padding:
                      EdgeInsets.only(top: _height / 40, bottom: _height / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text(user.slotCount.toString(),
                            style: TextStyle(
                                fontSize: _width / 6, color: Colors.tealAccent),
                            textAlign: TextAlign.center),
                        Text('Total Slots\nBooked',
                            style: TextStyle(
                                fontSize: _width / 25, color: Colors.teal),
                            textAlign: TextAlign.center)
                      ]),
                      Column(children: <Widget>[
                        Text('2',
                            style: TextStyle(
                                fontSize: _width / 6, color: Colors.tealAccent),
                            textAlign: TextAlign.center),
                        Text('Games \nToday',
                            style: TextStyle(
                                fontSize: _width / 25, color: Colors.teal),
                            textAlign: TextAlign.center)
                      ]),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: _height / 40),
              Padding(
                padding: EdgeInsets.only(left: _width / 5, right: _width / 5),
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: _width / 30, vertical: _height / 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.credit_card,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: _width / 30,
                          ),
                          Text('Membership Payments',
                              style: TextStyle(
                                  fontSize: _width / 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      color: Colors.redAccent[400],
                    ),
                    SizedBox(height: _height / 40),
                    RaisedButton(
                      onPressed: () {},
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: _width / 30, vertical: _height / 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: _width / 30,
                          ),
                          Text('Give us a feedback',
                              style: TextStyle(
                                  fontSize: _width / 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
