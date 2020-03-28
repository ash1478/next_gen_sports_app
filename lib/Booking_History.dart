import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';

class BookingHistory extends StatefulWidget {
  UserDetails user;
  List<int> monthCount = List<int>();
  BookingHistory(this.user, this.monthCount);
  @override
  _BookingHistoryState createState() => _BookingHistoryState(user, monthCount);
}

class monthPermonth {
  final String month;
  final int bookings;
  final charts.Color color;

  monthPermonth(this.month, this.bookings, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _BookingHistoryState extends State<BookingHistory> {
  UserDetails user;
  _BookingHistoryState(this.user, this.monthCount);
  bool isPrevious = false;
  List<int> monInteger = List<int>();
  List<int> monthCount = List<int>();
  List<String> monthString = List<String>();

  _getMonthInt() {
    int curMonth;
    curMonth = DateTime.now().month;
    int mon1, mon2, mon3;
    mon1 = curMonth - 2;
    if (mon1 == 0) {
      mon1 = 12;
    }
    if (mon1 == -1) {
      mon1 = 11;
    }
    mon2 = curMonth - 1;
    if (mon2 == 0) {
      mon2 = 12;
    }
    mon3 = curMonth;
    monInteger.add(mon1);
    monInteger.add(mon2);
    monInteger.add(mon3);
  }

  _getMonthStr(int mon) {
    String nowMonth;
    switch (mon) {
      case 1:
        nowMonth = 'Jan';
        break;
      case 2:
        nowMonth = 'Feb';
        break;
      case 3:
        nowMonth = 'Mar';
        break;
      case 4:
        nowMonth = 'Apl';
        break;
      case 5:
        nowMonth = 'May';
        break;
      case 6:
        nowMonth = 'Jun';
        break;
      case 7:
        nowMonth = 'Jly';
        break;
      case 8:
        nowMonth = 'Aug';
        break;
      case 9:
        nowMonth = 'Sep';
        break;
      case 10:
        nowMonth = 'Oct';
        break;
      case 11:
        nowMonth = 'Nov';
        break;
      case 12:
        nowMonth = 'Dec';
        break;
    }

    return nowMonth;
  }

  _getMonths() {
    monthString.add(_getMonthStr(monInteger[0]));
    monthString.add(_getMonthStr(monInteger[1]));
    monthString.add(_getMonthStr(monInteger[2]));
    print(monthString[0]);
  }

  @override
  void initState() {
    super.initState();
    _getMonthInt();
    _getMonths();
    //_getMonthCount();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      monthPermonth(monthString[0], monthCount[0], Colors.red),
      monthPermonth(monthString[1], monthCount[1], Colors.yellow),
      monthPermonth(monthString[2], monthCount[2], Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (monthPermonth clickData, _) => clickData.month,
        measureFn: (monthPermonth clickData, _) => clickData.bookings,
        colorFn: (monthPermonth clickData, _) => clickData.color,
        id: 'Bookings',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          index: 0,
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
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage(user)));
            }
          }),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
            onPressed: null),
        title: Text(
          'My Bookings',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.width / 20,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 30,
            right: MediaQuery.of(context).size.width / 30,
            top: MediaQuery.of(context).size.width / 35),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 30,
              right: MediaQuery.of(context).size.width / 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    isPrevious = true;
                    setState(() {});
                  },
                  child: Text(
                    'Previous',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color:
                            (isPrevious) ? Colors.redAccent : Colors.grey[600]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isPrevious = false;
                    setState(() {});
                  },
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: (!isPrevious)
                            ? Colors.redAccent
                            : Colors.grey[600]),
                  ),
                )
              ],
            ),
          ),
          !isPrevious
              ? _upcoming()
              : Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 10),
                  child: Center(child: chartWidget),
                ),
          Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 5,
              ),
              child: RaisedButton(
                onPressed: () {},
                elevation: 1.0,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 30),
                    Text(
                      'Give us feedback',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width / 20),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _upcoming() {
    return Container(height: MediaQuery.of(context).size.height/2,
      child: FirebaseAnimatedList(
        physics: ClampingScrollPhysics(),
        query: FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(user.uid)
            .child("Bookings")
            .child("1")
            .child(monthString[2])
            .orderByChild("DateCount")
            .startAt((DateTime.now().year * 10000 +
                DateTime.now().month * 100 +
                DateTime.now().day)),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation animation, int index) {
          return Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.white, Colors.cyan])),
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 30,
                          bottom: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 30),
                      child: Container(
                        //padding: EdgeInsets.all(MediaQuery.of(context).size.width/70),
                        height: MediaQuery.of(context).size.width / 4.5,
                        width: MediaQuery.of(context).size.width / 4.5,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Icon(Icons.done,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width / 7),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Venue',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'NxtGen, MM Nagar',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Match Date',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  snapshot.value['Date'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Match Time',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  snapshot.value['Slots'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Cost',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  snapshot.value['Cost'].toString(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
