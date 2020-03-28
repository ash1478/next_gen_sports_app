import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:next_gen_sports_app/Booking.dart';
import 'package:next_gen_sports_app/Booking_History.dart';
import 'package:next_gen_sports_app/BookingsPage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:next_gen_sports_app/VenueDetails.dart';

class HomePage extends StatefulWidget {
  UserDetails user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  List<Marker> marker;
  UserDetails user;
_HomePageState(this.user);
  VenueDetails venue = VenueDetails();
  List<Marker> markers = List<Marker>();

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

  _getMonthCount() async
  {
    for( int i =0;i<3;i++){
      await FirebaseDatabase.instance.reference().child("Users").child(user.uid)
          .child("Bookings").child("1").child(monthString[i]).child("1").once().then((DataSnapshot snapshot){
        monthCount.add(snapshot.value["Count"]);
      }).catchError((e){
        monthCount.add(0);
      });
      print(monthCount[i]);
    }
  }
  _getMarkers() async{
    int tot =0;
    await FirebaseDatabase.instance.reference().child("Venues").child("1").once().then((DataSnapshot snap){
      tot = snap.value['Total'];
    });
    for(int i =1;i<=tot;i++){
      await FirebaseDatabase.instance.reference().child("Venues").child(i.toString()).once().then((DataSnapshot snapshot){
        markers.add(Marker(
            point: LatLng(snapshot.value['Lat'], snapshot.value['Long']),
            width: MediaQuery.of(context).size.width/7,
            height: MediaQuery.of(context).size.width/7,
            builder: (context){
              return Container(
                child: IconButton(icon: Icon(Icons.room,color: Colors.red,),
                    iconSize: MediaQuery.of(context).size.width/7,
                    onPressed: (){
                      showModalBottomSheet(context: context, builder: (builder){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(height: MediaQuery.of(context).size.height/4,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.vertical(
                                  // bottom: Radius.circular(MediaQuery.of(context).size.width/20)),
                                    image: DecorationImage(image: NetworkImage(snapshot.value['ImgUrl'],),
                                        fit: BoxFit.cover)
                                ),
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:  EdgeInsets.only(//top: MediaQuery.of(context).size.height/50,
                                        left: MediaQuery.of(context).size.width/20,
                                        right: MediaQuery.of(context).size.width/20),
                                    child: Text(snapshot.value['Name'],style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.width/16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: ""),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/80,
                                        left: MediaQuery.of(context).size.width/20,
                                        right: MediaQuery.of(context).size.width/20),
                                    child: Text(snapshot.value['Address'],style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: "OpenSans",
                                        fontSize: MediaQuery.of(context).size.width/27)),
                                  ),
                                ],),

                              /* Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width/20,
                                right: MediaQuery.of(context).size.width/20),
                                child: Text(snapshot.value['Desc'],style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width/25,
                                    fontFamily: "OpenSans",)),


                              ),*/

                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(width: MediaQuery.of(context).size.width/3,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.directions_run,color: Colors.green,size: MediaQuery.of(context).size.width/10,),
                                        Padding(
                                          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/80),
                                          child: Text(snapshot.value['Players']),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(width: MediaQuery.of(context).size.width/3,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.access_time,color: Colors.green,size: MediaQuery.of(context).size.width/10,),
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/80),
                                          child: Text(snapshot.value['Time']),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(width: MediaQuery.of(context).size.width/3,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.check_box_outline_blank,color: Colors.green,size: MediaQuery.of(context).size.width/10,),
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/80),
                                          child: Text(snapshot.value['Post']),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        print(user.name);
                                        VenueDetails venue = VenueDetails();
                                        venue.getDetails(snapshot.value['Name'], snapshot.value['VenueId'], snapshot.value['Desc']);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingsPage(venue,user)));
                                      },
                                      child: Container(color: Colors.lightBlue,
                                        height: MediaQuery.of(context).size.height/16,
                                        child: Center(
                                          child: Text("Book Now",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.width/20,
                                            ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                    }),
              );
            }
        ));
      });
    }
    setState(() {
    });
    if(markers.isEmpty)print("sda");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMarkers();
    _getMonthInt();
    _getMonths();
    _getMonthCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        index: 1,
        buttonBackgroundColor: Colors.redAccent,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.history, size: 30, color: Colors.white,),
          Icon(Icons.home, size: 30,color: Colors.white),
          Icon(Icons.person, size: 30,color: Colors.white),
        ],
        color: Colors.cyan[600],
        onTap: (index){
          if(index == 0){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BookingHistory(user,monthCount)));
          }
        },
      ),
      body: _map(),
    );
  }
Container _map(){
    return Container(
      child: FlutterMap(
        options: new MapOptions(
          center: new LatLng(13,80.1274227),
          zoom: 10,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibmV4dGdlbnNwb3J0cyIsImEiOiJjazdrN2l2aDEwZDg1M25vN2U0c2JzZjZ6In0.2P93TejO7S9wQmEffLx36g',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(
              markers:markers
          ),
        ],
      ),
    );
}
}
