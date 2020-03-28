import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_sports_app/Confirm_Booking.dart';
import 'package:next_gen_sports_app/SlotDetails.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:next_gen_sports_app/VenueDetails.dart';

class ScheduleSlot extends StatefulWidget {
  String date;
  VenueDetails venue;
  UserDetails user;
  ScheduleSlot(this.date,this.user,this.venue);
  @override
  _ScheduleSlotState createState() => _ScheduleSlotState(date,user,venue);
}

class _ScheduleSlotState extends State<ScheduleSlot> {
  String date;
  UserDetails user;
  VenueDetails venue;
  _ScheduleSlotState(this.date,this.user,this.venue);
  String session = "Night";
  int buffer = 0;
  var _keyDialog = Key("initial");
  List<String> times = [
    '12AM-1AM',
    '1AM-2AM',
    '2AM-3AM',
    '3AM-4AM',
    '4AM-5AM',
    '5AM-6AM',
    '6AM-7AM',
    '7AM-8AM',
    '8AM-9AM',
    '9AM-10AM',
    '10AM-11AM',
    '11AM-12PM',
    '12PM-1PM',
    '1PM-2PM',
    '2PM-3PM',
    '3PM-4PM',
    '4PM-5PM',
    '5PM-6PM',
    '6PM-7PM',
    '7PM-8PM',
    '8PM-9PM',
    '9PM-10PM',
    '10PM-11PM',
    '11PM-12AM',
  ];
  List<SlotDetails> slots = List<SlotDetails>();
  int venueID = 1;
  List<Color> slotColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> borderColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  Map<String, int> cost = Map<String, int>();
  List<String> sessions = ["Night", "Morning", "Afternoon", "Evening"];
  List<int> status = List<int>();

  _scheduleSlot() {
   Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmBook(user, slots,venue)));
  }


  Future<void> _getCost() async {
    for (int i = 1; i <= 4; i++) {
      await FirebaseDatabase.instance
          .reference()
          .child("Cost")
          .child("1")
          .child(sessions[i-1])
          .once()
          .then((DataSnapshot snapshot) {
        cost[sessions[i-1]] = snapshot.value["Cost"];
      });
      print(cost[sessions[i-1]]);
    }
  }

  Future<void> _getStatus() async {
    int count;
    List<String> datesplit = date.split("/");
    int day = int.parse(datesplit[0]);
    int mon = int.parse(datesplit[1]);
    int yr = int.parse(datesplit[2]);
    int dateCount = yr*10000 + mon*100 + day;
    await FirebaseDatabase.instance.reference().child("Scheduled List").child(dateCount.toString()).child("1").once().then((DataSnapshot snapshot){
      count = snapshot.value["Count"];
    });
    for (int i =1;i<=count;i++)
    {
      await FirebaseDatabase.instance.reference().child("Scheduled List").child(dateCount.toString()).child(i.toString()).once().then((DataSnapshot snapshot){
        borderColor[snapshot.value["Index"]] = Colors.red;
      });
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _getStatus();
    _getCost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: MediaQuery.of(context).size.width / 20,
                color: Colors.grey[700],
              ),
              onPressed: () {}),
          title: Text(
            'Schedule Your Slot',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: Text(
                    "Date: " + date,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 30),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    buffer = 0;
                                    _keyDialog = Key("Night");
                                    session = "Night";
                                    setState(() {});
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                        color: (buffer == 0)
                                            ? Colors.redAccent
                                            : Colors.grey[
                                                100] //Conditional statement
                                        ),
                                    child: Center(
                                        child: Text(
                                      "Night",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    buffer = 6;
                                    _keyDialog = Key("Morning");
                                    session = "Morning";
                                    setState(() {});
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2.0),
                                        color: (buffer == 6)
                                            ? Colors.redAccent
                                            : Colors.grey[
                                                100] //Conditional statement
                                        ),
                                    child: Center(
                                        child: Text(
                                      "Morning",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    buffer = 12;
                                    _keyDialog = Key("Afternoon");
                                    session = "Afternoon";
                                    setState(() {});
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2.0),
                                        color: (buffer == 12)
                                            ? Colors.redAccent
                                            : Colors.grey[
                                                100] //Conditional statement
                                        ),
                                    child: Center(
                                        child: Text(
                                      "Afternoon",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    buffer = 18;
                                    _keyDialog = Key("Evening");
                                    session = "Evening";
                                    setState(() {});
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                        color: (buffer == 18)
                                            ? Colors.redAccent
                                            : Colors.grey[
                                                100] //Conditional statement
                                        ),
                                    child: Center(
                                        child: Text(
                                      "Evening",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 40),
                                color: Colors.grey[300],
                              ),
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width,
                              child: dialogContent(buffer),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 30),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 20),
                            child: Center(
                              child: GestureDetector(
                                onTap: _scheduleSlot,
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 20.0,
                                  width: MediaQuery.of(context).size.width / 3,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[600],
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width /
                                              40)),
                                  child: Center(
                                    child: Text(
                                      'Schedule',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }


  Widget dialogContent(int buffer) {
    print(buffer);
    return GridView.count(
      key: _keyDialog,
      crossAxisCount: 3,
      primary: false,
      shrinkWrap: true,
      crossAxisSpacing: 10.0,
      childAspectRatio: 2.0,
      mainAxisSpacing: 10.0,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if(borderColor[0+buffer] != Colors.red)
            {
              if (slotColors[0 + buffer] == Colors.white) {
                slotColors[0 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[0 + buffer], date, "B", user.uid, session, cost[session],0 + buffer);
                slots.add(slot);
              } else {
                slotColors[0 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[0 + buffer], date, "B", user.uid, session, cost[session],0 + buffer);
                slots.removeWhere((item) => item.time == times[0+buffer]);              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[0 + buffer],
                border: Border.all(color: borderColor[0 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[0 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {

            if(borderColor[1 + buffer] != Colors.red){
              if (slotColors[1 + buffer] == Colors.white) {
                slotColors[1 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[1 + buffer], date, "B", user.uid, session, cost[session],1 + buffer);
                slots.add(slot);
              } else {
                slotColors[1 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[1 + buffer], date, "B", user.uid, session, cost[session],1 + buffer);
                slots.removeWhere((item) => item.time == times[1+buffer]);              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[1 + buffer],
                border: Border.all(color: borderColor[1 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[1 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(borderColor[2+buffer] != Colors.red){
              if (slotColors[2 + buffer] == Colors.white) {
                slotColors[2 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[2 + buffer], date, "B", user.uid, session, cost[session],2 + buffer);
                slots.add(slot);
              } else {
                slotColors[2 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[2 + buffer], date, "B", user.uid, session, cost[session],2 + buffer);
                slots.removeWhere((item) => item.time == times[2+buffer]);              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[2 + buffer],
                border: Border.all(color: borderColor[2 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[2 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(borderColor[3 + buffer] != Colors.red){
              if (slotColors[3 + buffer] == Colors.white) {
                slotColors[3 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[3 + buffer], date, "B", user.uid, session, cost[session],3 + buffer);
                slots.add(slot);
              } else {
                slotColors[3 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[3 + buffer], date, "B", user.uid, session, cost[session],3 + buffer);
                slots.removeWhere((item) => item.time == times[3+buffer]);              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[3 + buffer],
                border: Border.all(color: borderColor[3 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[3 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(borderColor[4+buffer] != Colors.red){
              if (slotColors[4 + buffer] == Colors.white) {
                slotColors[4 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[4 + buffer], date, "B", user.uid, session, cost[session],4 + buffer);
                slots.add(slot);
              } else {
                slotColors[4 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[4 + buffer], date, "B", user.uid, session, cost[session],4 + buffer);
                slots.removeWhere((item) => item.time == times[4+buffer]);              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[4 + buffer],
                border: Border.all(color: borderColor[4 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[4 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(borderColor[5+buffer] != Colors.red){
              if (slotColors[5 + buffer] == Colors.white) {
                slotColors[5 + buffer] = Colors.amber;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[5 + buffer], date, "B", user.uid, session, cost[session],5 + buffer);
                slots.add(slot);
              } else {
                slotColors[5 + buffer] = Colors.white;
                SlotDetails slot = SlotDetails();
                slot.getDetails2(
                    times[5 + buffer], date, "B", user.uid, session, cost[session],5 + buffer);
                slots.removeWhere((item) => item.time == times[5+buffer]);
              }
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: slotColors[5 + buffer],
                border: Border.all(color: borderColor[5 + buffer], width: 2.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                times[5 + buffer],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
