import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_sports_app/BookingsPage.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/SlotDetails.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:next_gen_sports_app/VenueDetails.dart';
import 'package:upi_india/upi_india.dart';
import 'dart:core';
import 'dart:math';

class ConfirmBook extends StatefulWidget {
  UserDetails user;
  VenueDetails venue;
  List<SlotDetails> slots;
  ConfirmBook(this.user, this.slots,this.venue);
  @override
  _ConfirmBookState createState() => _ConfirmBookState(user, slots,venue);
}

class _ConfirmBookState extends State<ConfirmBook> {
  VenueDetails venue;
  UserDetails user;
  List<SlotDetails> slots;
  _ConfirmBookState(this.user, this.slots,this.venue);

  final chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  bool pDrop = false;
  Future _transaction;
  String status;
  String txnRef;
  String txnId;
  String resCode;

  int dateCount;


  Future<bool> _backPressed()
  {
    return showDialog(context: context,
        builder: (context)=>AlertDialog(

          title: Text("Do you want to cancel the booking?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
            FlatButton(
                child: Text("Yes"),
                onPressed: _removeSlot
            ),
          ],
        )
    );

  }
   RandomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    txnRef =  result;
  }


  Future<String> initiateTransaction(String app) async {
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: 'darshans.theclimber-1@oksbi',
      receiverName: 'NxtGen Sports Academy',
      transactionRefId: txnRef,
      transactionNote: "Name: " + user.name +
          " Slot(s): " + _slotTimings() +
          " Venue: " + venue.name +
          " Date: " +  day +
          "-" +
          mon+
          "-" +
          yr,
      amount: 1.00,
    );

    String response = await upi.startTransaction();

    return response;
  }

  String _slotTimings() {
    var s = StringBuffer();
    slots.forEach((item) {
      print(item.time);
      s.writeln(item.time);
    });
    return s.toString();
  }

  int _cost() {
    int n = slots.length;
    int s = 0;
    for (int i = 0; i < n; i++) {
      s += slots[i].cost;
    }
    return s;
  }

  _getDate(){
  if(slots[0].date == null){
    day = slots[0].day.toString();
    mon = slots[0].month.toString();
    yr =  slots[0].year.toString();
    int monI = _month(mon);
    dateCount = slots[0].year * 10000 + monI*100 + slots[0].day;
  }
  else {
    List<String> datesplit = slots[0].date.split("/");
     day = datesplit[0];
     mon = datesplit[1];
     yr = datesplit[2];
    int dayI = int.parse(datesplit[0]);
    int monI = int.parse(datesplit[1]);
    int yrI = int.parse(datesplit[2]);
    dateCount = yrI* 10000 + monI * 100 + dayI;
  }
  }

  String day,mon,yr;
  @override
  void initState() {
    super.initState();
    _getDate();
    RandomString(10);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Confirm Booking',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 20,
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          children: <Widget>[ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _texts("Name", user.name),
              _div(Colors.grey),
              _texts(
                  "Date Of Match",
                  day +
                      "-" +
                      mon +
                      "-" +
                      yr),
              _div(Colors.grey),
              _texts("Match Timing", _slotTimings()),
              _div(Colors.grey),
              _texts("Venue", "Next Gen Sports Academy"),
              _div(Colors.grey),
              _texts("Cost", _cost().toString()),
              _div(Colors.grey),
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
                child: GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.width / 8,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: Colors.cyan[600],
                              //borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width / 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Pay Now',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 20,
                                        color: Colors.white),
                                  ),
                                  (!pDrop)
                                      ? GestureDetector(
                                          onTap: () {
                                            pDrop = !pDrop;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size:
                                                MediaQuery.of(context).size.width /
                                                    10,
                                            color: Colors.white,
                                          ))
                                      : GestureDetector(
                                          onTap: () {
                                            pDrop = !pDrop;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.arrow_drop_up,
                                            size:
                                                MediaQuery.of(context).size.width /
                                                    10,
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              (pDrop)
                  ? Container(
                      color: Colors.cyan[600],
                      //height: MediaQuery.of(context).size.height/4,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height/70,
                          horizontal: MediaQuery.of(context).size.width/20
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _div(Colors.white),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70),
                              child: GestureDetector(
                                onTap: () {
                                  _transaction = initiateTransaction(UpiIndiaApps.GooglePay,);
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Pay Using GooglePay",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                MediaQuery.of(context).size.width / 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _div(Colors.white),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70),
                              child: GestureDetector(
                                onTap: () {
                                  _transaction = initiateTransaction(UpiIndiaApps.PhonePe,);
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Pay Using PhonePe",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context).size.width / 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _div(Colors.white),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70),
                              child: GestureDetector(
                                onTap: () {
                                  _transaction = initiateTransaction(UpiIndiaApps.PayTM,);
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Pay Using PayTM",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context).size.width / 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _div(Colors.white),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              FutureBuilder(
                future: _transaction,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null)
                    return Text(' ');
                  else {
                    switch (snapshot.data.toString()) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        return Text(
                          'App not installed.',
                        );
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        return Text(
                          'Requested payment is invalid.',
                        );
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        return Text(
                          'It seems like you cancelled the transaction.',
                        );
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        return Text(
                          'No data received',
                        );
                        break;
                      default:
                        UpiIndiaResponse _upiResponse;
                        _upiResponse = UpiIndiaResponse(snapshot.data);
                        txnId = _upiResponse.transactionId;
                        resCode = _upiResponse.responseCode;
                        txnRef = _upiResponse.transactionRefId;
                        status = _upiResponse.status;
                        pDrop = false;
                        // ignore: unnecessary_statements
                        (status == "success")?_updateSlot():_removeSlot();
                       // String approvalRef = _upiResponse.approvalRefNo;
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              (status == "success")?
                              Text("Payment Succesfull!",
                                style: TextStyle(color: Colors.green,
                                fontSize: MediaQuery.of(context).size.width/25,
                              ),):Text("Payment Failed!", style: TextStyle(color: Colors.red,
                                fontSize: MediaQuery.of(context).size.width/25,
                              ),),
                              Text('Transaction Id: $txnId', style: TextStyle(color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width/25,
                              ),),
                              Text('Response Code: $resCode', style: TextStyle(color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width/25,
                              ),),
                              Text('Reference Id: $txnRef', style: TextStyle(color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width/25,
                              ),),
                              Text('Approval No: $status'),
                            ],
                          ),
                        );
                    }
                  }
                },
              ),

            ],
          ),]
        ),
      ),
    );
  }

  Widget _div(Color color) {
    return Container(
      color: color,
      height: MediaQuery.of(context).size.height / 2000,
    );
  }

  Widget _texts(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 90,
        left: MediaQuery.of(context).size.width / 20,
        bottom: MediaQuery.of(context).size.height / 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 25,
            ),
          ),
        ],
      ),
    );
  }

  _removeSlot() async {
    print("called");
    if(slots[0].date ==  null){
      for(int i =0;i<slots.length;i++){
        await FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString())
            .child(slots[0].day.toString()).child(slots[i].session).child((slots[i].index+1).toString()).update({
          "Status" : "NB",
        });}
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BookingsPage(venue, user)));
  }

   _updateSlot() async {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingsPage(venue,user)));
     if(slots[0].date ==  null){
    for(int i =0;i<slots.length;i++){
   await FirebaseDatabase.instance.reference().child("Bookings").child(venue.id.toString())
       .child(slots[0].day.toString()).child(slots[i].session).child((slots[i].index+1).toString()).update({
     "Status" : "B",
     "BookingId" : txnRef,
   });}
    }
    else {
      int count;
      print(dateCount);
      //give venue id
      await FirebaseDatabase.instance.reference().child("Scheduled List").child(venue.id.toString()).child(dateCount.toString()).child("1").once().then((DataSnapshot snapshot){
        count = snapshot.value["Count"];
      }).catchError((e){
        count = 0;
      });
      //give venue id
      for (int i =1;i<=slots.length;i++)
      {
        await FirebaseDatabase.instance.reference().child("Scheduled List").child(venue.id.toString()).child(dateCount.toString()).child((count + i).toString()).set(slots[i-1].toJson());
      }
      await FirebaseDatabase.instance.reference().child("Scheduled List").child(venue.id.toString()).child(dateCount.toString()).child("1").update({
        "Count" : count + slots.length,
      });
    }
    int userSlotCount;
    await FirebaseDatabase.instance.reference().child("UsersList").child(user.uid).once().then((DataSnapshot snapshot){
      userSlotCount = snapshot.value['Count'];
    });
     FirebaseDatabase.instance.reference().child("UsersList").child(user.uid).update({
      "Count" : slots.length + userSlotCount,
    });
    int userCount;
    await FirebaseDatabase.instance.reference().child("Users").child(user.uid)
        .child("Bookings").child(mon).child("1").once().then((DataSnapshot snapshot){
       userCount = snapshot.value['Count'];
    }).catchError((e){
      userCount = 0;
    });
    FirebaseDatabase.instance.reference().child("Users").child(user.uid)
        .child("Bookings").child(mon).child((userCount + 1).toString()).update({
      "Name" : user.name,
      "Slots" : _slotTimings(),
      "BookingId" : txnRef,
      "TransactionId" : txnId,
      "DateCount" : dateCount,
      "Date" : day + "-" + mon + "-" + yr,
      "Cost" : _cost(),
      "VenueName" : venue.name
    });
    FirebaseDatabase.instance.reference().child("Users").child(user.uid)
        .child("Bookings").child(mon).child("1").update({
      "Count" : userCount + 1,
    });
    int venueBookingCount;
    await FirebaseDatabase.instance.reference().child("VBDetails").
    child(venue.id.toString()).child("Bookings").child(mon).child("1").once().then((DataSnapshot snapshot){
      venueBookingCount = snapshot.value['Count'];
    }).catchError((e){
      venueBookingCount = 0;
    });
    FirebaseDatabase.instance.reference().child("VBDetails").child(venue.id.toString()).child("Bookings").child(mon)
        .child((venueBookingCount + 1).toString()).update({
      "Name" : user.name,
      "Slots" : _slotTimings(),
      "BookingId" : txnRef,
      "TransactionId" : txnId,
      "DateCount" : dateCount,
      "Date" : day + "-" + mon + "-" + yr,
      "Cost" : _cost(),
    });
    FirebaseDatabase.instance.reference().child("VBDetails").
    child(venue.id.toString()).child("Bookings").child(mon).child("1").update({
      "Count" : venueBookingCount + 1,
    });
    int venueSlotCount;
    await FirebaseDatabase.instance.reference().child("VBDetails").
    child(venue.id.toString()).child("Total").once().then((DataSnapshot snapshot){
      venueSlotCount = snapshot.value['SlotCount'];
    });
    FirebaseDatabase.instance.reference().child("VBDetails").child(venue.id.toString()).child("Total").update({
      "SlotCount" : venueSlotCount + slots.length,
    });
  }
}

int _month(String mon) {
  switch(mon){
    case "Jan" : return 1;
    case "Feb" : return 2;
    case "Mar" : return 3;
    case "Apr" : return 4;
    case "May" : return 5;
    case "Jun" : return 6;
    case "Jul" : return 7;
    case "Aug" : return 8;
    case "Swp" : return 9;
    case "Oct" : return 10;
    case "Nov" : return 11;
    case "Dec" : return 12;
  }
}
