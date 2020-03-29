import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:next_gen_sports_app/Confirm_Booking.dart';
import 'package:next_gen_sports_app/ScheduleSlot.dart';
import 'package:next_gen_sports_app/SlotDetails.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:next_gen_sports_app/VenueDetails.dart';

class BookingsPage extends StatefulWidget {
VenueDetails venue;
UserDetails user;
  BookingsPage(this.venue,this.user);
  @override
  _BookingsPageState createState() => _BookingsPageState(venue,user);
}

class _BookingsPageState extends State<BookingsPage> {
  VenueDetails venue;
  String convertedDate;
  UserDetails user;
  _BookingsPageState(this.venue,this.user);
  List<SlotDetails> slots = List<SlotDetails>();
  Key _key;
  SlotDetails slot = SlotDetails();
  int photoIndex = 0;
  List<int> indexlist = new List<int>();
  List<String> sessionList = new List<String>();
  List<String> photos = [
    'https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1551782450-17144efb9c50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  ];




  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  String session;
  int day;
  int _day;
  int _month;
  String month;
  int year;
  int tile = 0;
  int isSelected1 = 0;
  bool list1 = true;

  List<Color> mor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> aft = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> eve = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> nig = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  final timeout = const Duration(seconds: 60);
  final ms = const Duration(milliseconds: 1);


  daytimeFunc(int _day, int _mon, int _year) {
    switch (_mon) {
      case 1:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Feb";
          _month = 2;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Jan";
          _month = 1;
          year = DateTime.now().year;
        }
        break;
      case 2:
        if (year % 4 == 0) {
          if (year % 100 == 0) {
            if (year % 400 == 0) {
              //leap
              if (_day - 29 > 0) {
                day = _day - 29;
                month = "Feb";
                _month = 2;
                year = DateTime.now().year;
              } else {
                day = _day;
                month = "Jan";
                _month = 1;
                year = DateTime.now().year;
              }
            } else {
              if (_day - 28 > 0) {
                day = _day - 28;
                month = "Feb";
                _month = 2;
                year = DateTime.now().year;
              } else {
                day = _day;
                month = "Jan";
                _month = 1;
                year = DateTime.now().year;
              }
            }
          } else {
            //leap
            if (_day - 29 > 0) {
              day = _day - 29;
              month = "Feb";
              _month = 2;
              year = DateTime.now().year;
            } else {
              day = _day;
              month = "Jan";
              _month = 1;
              year = DateTime.now().year;
            }
          }
        } else {
          //not leap
          if (_day - 28 > 0) {
            day = _day - 28;
            month = "Feb";
            _month = 2;
            year = DateTime.now().year;
          } else {
            day = _day;
            month = "Jan";
            _month = 1;
            year = DateTime.now().year;
          }
        }
        break;
      case 3:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Apr";
          _month = 4;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Mar";
          _month = 3;
          year = DateTime.now().year;
        }
        break;
      case 4:
        if (_day - 30 > 0) {
          day = _day - 30;
          month = "May";
          _month = 5;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Apr";
          _month = 4;
          year = DateTime.now().year;
        }
        break;
      case 5:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Jun";
          _month = 6;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "May";
          _month = 5;
          year = DateTime.now().year;
        }
        break;
      case 6:
        if (_day - 30 > 0) {
          day = _day - 30;
          month = "Jul";
          _month = 7;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Jun";
          _month = 6;
          year = DateTime.now().year;
        }
        break;
      case 7:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Aug";
          _month = 8;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Jul";
          _month = 7;
          year = DateTime.now().year;
        }
        break;
      case 8:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Sep";
          _month = 9;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Aug";
          _month = 8;
          year = DateTime.now().year;
        }
        break;
      case 9:
        if (_day - 30 > 0) {
          day = _day - 30;
          month = "Oct";
          _month = 10;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Sep";
          _month = 9;
          year = DateTime.now().year;
        }
        break;
      case 10:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Nov";
          _month = 11;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Oct";
          _month = 10;
          year = DateTime.now().year;
        }
        break;
      case 11:
        if (_day - 30 > 0) {
          day = _day - 30;
          month = "Dec";
          _month = 12;
          year = DateTime.now().year;
        } else {
          day = _day;
          month = "Nov";
          _month = 11;
          year = DateTime.now().year;
        }
        break;
      case 12:
        if (_day - 31 > 0) {
          day = _day - 31;
          month = "Jan";
          _month = 1;
          year = DateTime.now().year + 1;
        } else {
          day = _day;
          month = "Dec";
          _month = 12;
          year = DateTime.now().year;
        }
        break;
    }
  }


  _resetDate() async {
    int _day = DateTime.now().day +6;
    int _mon = DateTime.now().month;
    int _yr = DateTime.now().year;
    daytimeFunc(_day, _mon, _yr);
    int day1 = day;
    print(day1);
    try{    print(day1);

    await FirebaseDatabase.instance.reference().child("Dates").child(day1.toString()).once().then((DataSnapshot snapshot){
        int count = snapshot.value['DateCount'];
      });
    }catch(e){
      print(e);
      print("asada");
      await FirebaseDatabase.instance.reference().child("Dates").child(day1.toString()).set({
        "Day" : day1,
        "Month" : month,
        "Year" : year,
        "DateCount" : year*10000 + _month*100 + day1,
      });
      put(day1);
    }
    day = DateTime.now().day;
    _month = DateTime.now().month;
    year = DateTime.now().year;
  }

  put(day) async {
    List<String> session = ["Night","Morning","Afternoon","Evening"];
    List<List<String>> slotTime =[["12 AM - 1 AM","1 AM - 2 AM","2 AM - 3 AM","3 AM - 4 AM","4 AM - 5 AM", "5 AM - 6 AM"],
      ["6 AM - 7 AM","7 AM - 8 AM","8 AM - 9 AM","9 AM - 10 AM","10 AM - 11 AM", "11 AM - 12 PM"],
      ["12 PM - 1 PM","1 PM - 2 PM","2 PM - 3 PM","3 PM - 4 PM","4 PM - 5 PM", "5 PM - 6 PM"],
      ["6 PM - 7 PM","7 PM - 8 PM","8 PM - 9 PM","9 PM - 10 PM","10 PM - 11 PM", "11 PM - 12 AM"]
    ];
    for(int j =0;j<4;j++)
    {
      for(int i =1;i<=6;i++)
      {
        await FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString()).child(day.toString()).child(session[j]).child(i.toString()).set({
          "Status" : "NB",
          "BookingId" : "blah",
          "Time" : slotTime[j][i-1],
          "Cost" : 2000,
          "Count" : i
        });
      }
    }
    int count,dateCount;
    dateCount = year*10000 + _month*100 + day;
      await FirebaseDatabase.instance.reference().child("Scheduled List").child(venue.id.toString()).child(dateCount.toString()).child("1").once().then((DataSnapshot snapshot){
      count = snapshot.value["Count"];
    });
      print(count);
    List<SlotDetails> tempslots = List<SlotDetails>();
    for(int i=1;i<=count;i++){
      SlotDetails temp = SlotDetails();
      await FirebaseDatabase.instance.reference().child("Scheduled List").child(venue.id.toString()).child(dateCount.toString()).child(i.toString()).once().then((DataSnapshot snapshot){
        temp.bookingID = snapshot.value["BookingId"];
        print(temp.bookingID);
        print("asdassdasdasdasdasdasd");
        temp.time = snapshot.value["Time"];
        temp.session = snapshot.value["Session"];
        temp.index = snapshot.value["Index"];
      });
      tempslots.add(temp);
    }
      tempslots.forEach((temp){
        print(temp.index);
        if(temp.session == "Night"){
      FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString()).child(day.toString()).
      child(temp.session).child((temp.index+1).toString()).update({
        "Status" :  "B",
        "BookingId" : temp.bookingID,
      });
      }
      else if(temp.session == "Morning"){
        FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString()).child(day.toString()).
        child(temp.session).child((temp.index+1-6).toString()).update({
          "Status" :  "B",
          "BookingId" : temp.bookingID,
        });
      }
      else if(temp.session == "Afternoon") {
        FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString()).child(day.toString()).
        child(temp.session).child((temp.index+1-12).toString()).update({
          "Status" :  "B",
          "BookingId" : temp.bookingID,
        });
      }
      else {
        FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString()).child(day.toString()).
        child(temp.session).child((temp.index+1-18).toString()).update({
          "Status" :  "B",
          "BookingId" : temp.bookingID,
        });
      }
      });
  }


  _setSession() {
    print(DateTime.now().hour);
    if(DateTime.now().hour >=0 && DateTime.now().hour < 5) { session = "Night";}
    else if(DateTime.now().hour >=5 && DateTime.now().hour < 11) { session = "Morning";}
    else if(DateTime.now().hour >=11 && DateTime.now().hour < 17) { session = "Afternoon";}
    else { session = "Evening";}
  }

  _setSlot(){
    for(int j=0;j<4;j++)
    {
      for(int i=0;i<6;i++)
      {
        if(j==0)
        {
          if(0+i <= DateTime.now().hour) nig[i] = Colors.grey;
        }
        if(j==1)
        {
          if(6+i <= DateTime.now().hour) mor[i] = Colors.grey;
        }
        if(j==2)
        {
          if(12+i <= DateTime.now().hour) aft[i] = Colors.grey;
        }
        if(j==3)
        {
          if(18+i <= DateTime.now().hour) eve[i] = Colors.grey;
        }
      }
    }
  }


  _startTimer([int milliseconds]) async{
      var duration = milliseconds == null ? timeout : ms * milliseconds;
      return new Timer(duration, _sessionTimeout);
  }

  _sessionTimeout() async {
    int pday = day;
    for(int i =0;i<indexlist.length;i++){
      if(sessionList[i] == "Night"){
        nig[indexlist[i]] = Colors.white;
      }
      else if(sessionList[i] == "Morning"){
        mor[indexlist[i]] = Colors.white;
      }
      else if(sessionList[i] == "Afternoon"){
        aft[indexlist[i]] = Colors.white;
      }
      else {
        eve[indexlist[i]] = Colors.white;
      }
    }
    setState(() {
    });
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Container(height: MediaQuery.of(context).size.height/6,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Session Timed Out",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width/20
                    ),),
                  Center(
                    child: Text("All your selected slots will be unblocked!",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/25
                      ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/70),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.cyan[600],
                        child: Text(
                          'OK',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _startTimer();
                        }),
                  )
                ],
              ),
            ),
          );
        });
    for (int i = 0;
    i < indexlist.length;
    i++) {
      await FirebaseDatabase.instance
          .reference()
          .child("Bookings")
          .child(venue.id.toString())
          .child(pday.toString())
          .child(sessionList[i])
          .child((indexlist[i] + 1)
          .toString())
          .update({
        "Status": "NB",
      });
    }
    indexlist.clear();
    sessionList.clear();
    slots.clear();
  }

  @override
  void initState() {
    super.initState();
    _resetDate();
    _setSession();
    _setSlot();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: MediaQuery.of(context).size.width / 20,
              color: Colors.grey[700],
            ),
            onPressed: () {}),
        title: Text(
          'Book Your Slot',
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 20,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 20),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                'Nxt Gen Sports Academy, MM Nagar',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: MediaQuery.of(context).size.width / 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 50,
                left: MediaQuery.of(context).size.width / 50,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              photos[photoIndex],
                            ),
                            fit: BoxFit.cover)),
                  ),
                  GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                    ),
                    onTap: _nextImage,
                  ),
                  GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.transparent,
                    ),
                    onTap: _previousImage,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SelectedPhoto(
                            photoIndex: photoIndex, numberOfDots: photos.length)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                // top: MediaQuery.of(context).size.height/90,
                left: MediaQuery.of(context).size.height / 40,
                right: MediaQuery.of(context).size.height / 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(venue.desc,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 25,
                            bottom: MediaQuery.of(context).size.width / 25),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan[600],
                              borderRadius: BorderRadius.circular(17.0)),
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 8,
                          child: IconButton(
                              icon: Icon(
                                Icons.location_on,
                                size: MediaQuery.of(context).size.width / 13,
                                color: Colors.black,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 25,
                            bottom: MediaQuery.of(context).size.width / 25),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan[600],
                              borderRadius: BorderRadius.circular(17.0)),
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 8,
                          child: IconButton(
                              icon: Icon(
                                Icons.phone,
                                size: MediaQuery.of(context).size.width / 13,
                                color: Colors.black,
                              ),
                              onPressed: null),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 200),
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 30,
                        bottom: MediaQuery.of(context).size.width / 30,
                        left: MediaQuery.of(context).size.width / 30,
                        right: MediaQuery.of(context).size.width / 30),
                    child: GestureDetector(
                      onTap: (){
                        showDatePicker(context: context,
                          initialDate: DateTime.now().add(Duration(days: 7)),
                          firstDate: DateTime.now().add(Duration(days: 6)),
                          lastDate: DateTime(DateTime
                              .now()
                              .year + 10),
                        ).then((val) {
                          setState(() {
                            convertedDate = new DateFormat("dd/MM/yyyy").format(val);
                          });
                          // ignore: unnecessary_statements
                          (convertedDate != null)?
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ScheduleSlot(convertedDate,user,venue))):null;
                        });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(MediaQuery.of(context).size.width/70),
                        height: MediaQuery.of(context).size.width / 7.5,
                        width: MediaQuery.of(context).size.width / 8,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width / 13,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      //right:  MediaQuery.of(context).size.width/30,
                    ),
                    child: FirebaseAnimatedList(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 30,
                        bottom: MediaQuery.of(context).size.width / 30,
                      ),
                      scrollDirection: Axis.horizontal,
                      query: FirebaseDatabase.instance
                          .reference()
                          .child("Dates")
                          .orderByChild("DateCount").startAt((DateTime.now().year*10000 + DateTime.now().month*100 + DateTime.now().day)),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation animation, int index) {
                        return GestureDetector(
                          onTap: () async {
                            month = snapshot.value['Month'];
                            // ignore: unnecessary_statements
                            (snapshot.value['Day'] == DateTime.now().day)?_setSession():null;
                            // ignore: unnecessary_statements
                            if(snapshot.value['Day'] == DateTime.now().day){_setSlot();}
                            else {
                              mor = [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white
                              ];
                              aft = [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white
                              ];
                              eve = [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white
                              ];
                              nig = [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white
                              ];
                            }
                            if (indexlist.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Do you want to cancel the selected slots?"),
                                      actions: <Widget>[
                                        GestureDetector(
                                            onTap: () async {
                                              int pday = day;
                                              setState(() {
                                                mor = [
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white
                                                ];
                                                aft = [
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white
                                                ];
                                                eve = [
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white
                                                ];
                                                nig = [
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white,
                                                  Colors.white
                                                ];
                                                day = snapshot.value['Day'];
                                                _key = Key(day.toString());
                                              });
                                              for (int i = 0;
                                              i < indexlist.length;
                                              i++) {
                                                await FirebaseDatabase.instance
                                                    .reference()
                                                    .child("Bookings")
                                                    .child(venue.id.toString())
                                                    .child(pday.toString())
                                                    .child(sessionList[i])
                                                    .child((indexlist[i] + 1)
                                                    .toString())
                                                    .update({
                                                  "Status": "NB",
                                                });
                                              }

                                              Navigator.pop(context);
                                              indexlist.clear();
                                              sessionList.clear();
                                              slots.clear();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      20),
                                              child: Text("Yes"),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      20),
                                              child: Text("No"),
                                            ))
                                      ],
                                    );
                                  });
                            } else {
                              setState(() {
                                day = snapshot.value['Day'];
                                _key = Key(day.toString());
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                MediaQuery.of(context).size.width / 50),
                            child: Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 70),
                              height: MediaQuery.of(context).size.width / 8,
                              width: MediaQuery.of(context).size.width / 8,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: day == snapshot.value['Day']
                                          ? Colors.redAccent
                                          : Colors.white,
                                      width: 2.0),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    snapshot.value['Month'].toString(),
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.value['Day'].toString(),
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.width /
                                            25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 40,
                //bottom: MediaQuery.of(context).size.width / 40
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // ignore: unnecessary_statements
                          ((day == DateTime.now().day)&& DateTime.now().hour>=5)?null:
                          setState(() {
                            session = "Night";
                            _key = Key(session);
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: (session == "Night")
                                ? Colors.redAccent
                                : ((day == DateTime.now().day)&& DateTime.now().hour>=5)? Colors.grey:Colors.white,
                          ),
                          child: Center(
                            child: Image(
                                image: NetworkImage(
                                    'https://static.thenounproject.com/png/493-200.png')),
                          ),
                        ),
                      ),
                      GestureDetector(
                        // ignore: unnecessary_statements
                        onTap: () {((day == DateTime.now().day)&& DateTime.now().hour>=11)?null:
                        setState(() {
                          session = "Morning";
                          _key = Key(session);
                        });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: session == "Morning"
                                  ? Colors.redAccent
                                  : ((day == DateTime.now().day)&& DateTime.now().hour>=11)? Colors.grey:Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://static.thenounproject.com/png/493-200.png'))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // ignore: unnecessary_statements
                          ((day == DateTime.now().day)&& DateTime.now().hour>=17)?null:
                          setState(() {
                            session = "Afternoon";
                            _key = Key(session);
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: session == "Afternoon"
                                  ? Colors.redAccent
                                  : ((day == DateTime.now().day)&& DateTime.now().hour>=17)?Colors.grey:Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://static.thenounproject.com/png/493-200.png'))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            session = "Evening";
                            _key = Key(session);
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: session == "Evening"
                                  ? Colors.redAccent
                                  : Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://static.thenounproject.com/png/493-200.png'))),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80),
                    child: Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height / 6,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            /* padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width/40,
                              horizontal:MediaQuery.of(context).size.width/40
                            ),*/
                            child: FirebaseAnimatedList(
                              key: _key,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              query: FirebaseDatabase.instance
                                  .reference()
                                  .child("Bookings")
                                  .child(venue.id.toString())
                                  .child(day.toString())
                                  .child(session)
                                  .orderByChild('Count')
                                  .startAt(1)
                                  .endAt(3),
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation animation,
                                  int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    if(!(session == "Morning" && mor[index] == Colors.grey) &&
                                        !(session == "Night" && nig[index]==Colors.grey) &&
                                        !(session == "Afternoon" &&aft[index]==Colors.grey) &&
                                        !(session == "Evening" &&eve[index]==Colors.grey))
                                    {
                                      if (session == "Morning") {
                                        if (mor[index] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          mor[index] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index);
                                          slots.add(slot);
                                          indexlist.add(index);
                                          sessionList.add(session);
                                        } else if (mor[index] == Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          mor[index] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index);
                                          sessionList.remove("Morning");
                                        } else {
                                          mor[index] = Colors.white;
                                        }
                                      }
                                      if (session == "Afternoon") {
                                        if (aft[index] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          aft[index] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index);
                                          slots.add(slot);
                                          indexlist.add(index);
                                          sessionList.add(session);
                                        } else if (aft[index] == Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          aft[index] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index);
                                          sessionList.remove("Afternoon");
                                        } else {
                                          aft[index] = Colors.white;
                                        }
                                      }
                                      if (session == "Evening") {
                                        if (eve[index] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          eve[index] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index);
                                          slots.add(slot);
                                          indexlist.add(index);
                                          sessionList.add(session);
                                        } else if (eve[index] == Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          eve[index] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index);
                                          sessionList.remove("Evening");
                                        } else {
                                          eve[index] = Colors.white;
                                        }
                                      }
                                      if (session == "Night") {
                                        if (nig[index] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          nig[index] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index);
                                          slots.add(slot);
                                          indexlist.add(index);
                                          sessionList.add(session);
                                        } else if (nig[index] == Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          nig[index] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 1).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index);
                                          sessionList.remove("Night");
                                        } else {
                                          nig[index] = Colors.white;
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height /
                                            50,
                                        left:
                                        MediaQuery.of(context).size.width /
                                            16),
                                    child: Container(
                                      width:
                                      MediaQuery.of(context).size.width / 4,
                                      //height: MediaQuery.of(context).size.width / 50,
                                      decoration: BoxDecoration(
                                          color: (session == "Morning")
                                              ? mor[index]
                                              : (session == "Afternoon")
                                              ? aft[index]
                                              : (session == "Evening")
                                              ? eve[index]
                                              : (session == "Night")
                                              ? nig[index]
                                              : Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: (snapshot
                                                  .value['Status'] ==
                                                  'B')
                                                  ? Colors.redAccent
                                                  : (snapshot.value['Status'] ==
                                                  "CUB")
                                                  ? Colors.amber
                                                  : Colors.black,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  150)),
                                      child: Center(
                                          child: Text(
                                            snapshot.value['Time'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    33),
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            /* padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width/40,
                              horizontal:MediaQuery.of(context).size.width/40
                            ),*/
                            child: FirebaseAnimatedList(
                              key: _key,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              query: FirebaseDatabase.instance
                                  .reference()
                                  .child("Bookings")
                                  .child(venue.id.toString())
                                  .child(day.toString())
                                  .child(session)
                                  .orderByChild('Count')
                                  .startAt(4)
                                  .endAt(6),
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation animation,
                                  int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    if(!(session == "Morning" && mor[index+3] == Colors.grey) &&
                                        !(session == "Night" && nig[index+3]==Colors.grey) &&
                                        !(session == "Afternoon" &&aft[index+3]==Colors.grey)&&
                                        !(session == "Evening" && eve[index+3]==Colors.grey))
                                    {
                                      if (session == "Morning") {
                                        if (mor[index + 3] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          mor[index + 3] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index+4);
                                          slots.add(slot);
                                          indexlist.add(index + 3);
                                          sessionList.add(session);
                                        } else if (mor[index + 3] ==
                                            Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          mor[index + 3] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index+3);
                                          sessionList.remove("Morning");
                                        } else {
                                          mor[index + 3] = Colors.white;
                                        }
                                      }
                                      if (session == "Afternoon") {
                                        if (aft[index + 3] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          aft[index + 3] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index+4);
                                          slots.add(slot);
                                          indexlist.add(index + 3);
                                          sessionList.add(session);
                                        } else if (aft[index + 3] ==
                                            Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          aft[index + 3] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index+3);
                                          sessionList.remove("Afternoon");
                                        } else {
                                          aft[index + 3] = Colors.white;
                                        }
                                      }
                                      if (session == "Evening") {
                                        if (eve[index + 3] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          eve[index + 3] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          print("asa");
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index+4);
                                          slots.add(slot);
                                          indexlist.add(index + 3);
                                          sessionList.add(session);
                                        } else if (eve[index + 3] ==
                                            Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          eve[index + 3] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          print("asasda");
//                                          SlotDetails slot = SlotDetails();
//                                          slot.getDetails(snapshot.value["Time"],day,month,year,
//                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"]);
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index+3);
                                          sessionList.remove("Evening");
                                        } else {
                                          eve[index + 3] = Colors.white;
                                        }
                                      }
                                      if (session == "Night") {
                                        if (nig[index + 3] == Colors.white &&
                                            snapshot.value['Status'] != "B" &&
                                            snapshot.value['Status'] != "CUB") {
                                          nig[index + 3] = Colors.amber;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "CUB",
                                          });
                                          SlotDetails slot = SlotDetails();
                                          slot.getDetails(snapshot.value["Time"],day,month,year,
                                              snapshot.value["Status"], snapshot.value["BookingId"], session, snapshot.value["Cost"],index+4);
                                          slots.add(slot);
                                          indexlist.add(index + 3);
                                          sessionList.add(session);
                                        } else if (nig[index + 3] ==
                                            Colors.amber &&
                                            snapshot.value['Status'] == "CUB") {
                                          nig[index + 3] = Colors.white;
                                          await FirebaseDatabase.instance
                                              .reference()
                                              .child("Bookings")
                                              .child(venue.id.toString())
                                              .child(day.toString())
                                              .child(session)
                                              .child((index + 4).toString())
                                              .update({
                                            "Status": "NB",
                                          });
                                          slots.removeWhere((item) => item.time == snapshot.value['Time']);
                                          indexlist.remove(index+3);
                                          sessionList.remove("Night");
                                        } else {
                                          nig[index + 3] = Colors.white;
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height /
                                            50,
                                        left:
                                        MediaQuery.of(context).size.width /
                                            16),
                                    child: Container(
                                      width:
                                      MediaQuery.of(context).size.width / 4,
                                      //height: MediaQuery.of(context).size.width / 50,
                                      decoration: BoxDecoration(
                                          color: (session == "Morning")
                                              ? mor[index + 3]
                                              : (session == "Afternoon")
                                              ? aft[index + 3]
                                              : (session == "Evening")
                                              ? eve[index + 3]
                                              : (session == "Night")
                                              ? nig[index + 3]
                                              : Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: (snapshot
                                                  .value['Status'] ==
                                                  'B')
                                                  ? Colors.redAccent
                                                  : (snapshot.value['Status'] ==
                                                  "CUB")
                                                  ? Colors.amber
                                                  : Colors.black,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  150)),
                                      child: Center(
                                          child: Text(
                                            snapshot.value['Time'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    33),
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                  top: MediaQuery.of(context).size.width / 15),
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width / 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.cyan[600],
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    if(slots.length == 0)
                    {
                      Fluttertoast.showToast(
                        msg: "Please select a slot to continue!",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black.withOpacity(0.8),
                        textColor: Colors.white,
                        fontSize: MediaQuery.of(context).size.width/30,
                      );
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmBook(user,slots,venue)));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }


  Widget _slotTimes() {
    return Container(
      width: MediaQuery.of(context).size.width / 20,
      height: MediaQuery.of(context).size.width / 20,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width / 20,
          left: MediaQuery.of(context).size.width / 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Widget _timings(String iconURL) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 7,
        height: MediaQuery.of(context).size.width / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red, width: 3.0),
            color: Colors.transparent,
            image: DecorationImage(image: NetworkImage(iconURL))),
      ),
    );
  }

//  Widget tiles(date) {
//    return Container(
//      padding: EdgeInsets.all(5.0),
//      height: MediaQuery.of(context).size.width / 20,
//      width: MediaQuery.of(context).size.width / 20,
//      decoration: BoxDecoration(
//          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            daytimeFunc(),
//            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
//          ),
//          Text(
//            date1,
//            style: TextStyle(fontSize: 15.0),
//          )
//        ],
//      ),
//    );
//  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto(context) {
    return new Container(
        child: new Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.width / 50,
            width: MediaQuery.of(context).size.width / 50,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
          ),
        ));
  }

  Widget _activePhoto(context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.width / 50,
          width: MediaQuery.of(context).size.width / 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots(context) {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(
          i == photoIndex ? _activePhoto(context) : _inactivePhoto(context));
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(context),
      ),
    );
  }
}
