import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latlong/latlong.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/RegisterPage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  UserDetails user = UserDetails();
  GoogleSignIn googleAuth = GoogleSignIn();
  List<Marker> markers =[];



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
                              borderRadius: BorderRadius.vertical(top: Radius.circular(MediaQuery.of(context).size.width/10))
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
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width/20,
                                    right: MediaQuery.of(context).size.width/20),
                                child: Text(snapshot.value['Name'],style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width/16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: ""),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width/20,
                                    right: MediaQuery.of(context).size.width/20),
                                child: Text(snapshot.value['Address'],style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: "OpenSans",
                                    fontSize: MediaQuery.of(context).size.width/27)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width/20,
                                    right: MediaQuery.of(context).size.width/20),
                                child: Text(snapshot.value['Desc'],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width/25,
                                  fontFamily: "OpenSans",)),


                              ),

                              Row(
                                children: <Widget>[
                                  Expanded(
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
  }



  final _formkey1 = GlobalKey<FormState>();
  String _email;
  String _password;
  Widget _buildLoginEmail(){
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height/20,
          bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Email ID',
            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),
        validator: (String value){
          if(value.isEmpty){
            return 'Email is required';
          }
          else return null;
        },
        onSaved: (String value){
          _email=value;
        },
      ),
    );
  }
  Widget _buildLoginPass(){
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height/40,
          bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Password',
            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),
        obscureText: true,
        validator: (String value){
          if(value.isEmpty){
            return 'Password is required';
          }
          else return null;
        },
        onSaved: (String value){
          _password=value;
        },
      ),
    );
  }

  Future<void> _loginGoogle() async {
    await googleAuth.signOut();
    GoogleSignInAccount _account = await googleAuth.signIn();
    try{FirebaseAuth auth = FirebaseAuth.instance;
    if (_account != null) {
      AuthResult res = await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await _account.authentication).idToken,
        accessToken: (await _account.authentication).accessToken,
      )
      );

      Fluttertoast.showToast(
        msg: 'Please wait! This may take few seconds.',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: MediaQuery.of(context).size.width/30,
      );

      if(res.user == null){
        Fluttertoast.showToast(
          msg: 'Google Login failed.',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: MediaQuery.of(context).size.width/30,
        );
      }
      else {
        final FirebaseUser userResult = await FirebaseAuth.instance.currentUser();
        user.uid = userResult.uid;
        SharedPreferences pref_user = await SharedPreferences.getInstance();
        pref_user.setString('userUid', user.uid);
        try{
          await FirebaseDatabase.instance.reference().child('Users')
              .child(user.uid).once().then((DataSnapshot snapshot) {
                user.getDetails(snapshot.value['Name'], snapshot.value["Email"], snapshot.value["DOB"]);
            Fluttertoast.showToast(
              msg: "Logged in successfully!",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.black.withOpacity(0.7),
              textColor: Colors.white,
              fontSize: MediaQuery.of(context).size.width/30,
            );
          });}catch(e){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
        }
        await _getMarkers();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)));
      }
    }}
    catch(e){
      print(e);
      Fluttertoast.showToast(
        msg: 'Something went wrong! Check your network.',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: MediaQuery.of(context).size.width/30,
      );
      FirebaseAuth user = FirebaseAuth.instance;
      await user.signOut();
      await googleAuth.signOut();
    }
  }

  Future<void> _login() async {
    final formState = _formkey1.currentState;
    if(formState.validate())
    {
      try {
        formState.save();
        AuthResult authresult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).catchError((e){
          Fluttertoast.showToast(
            msg: 'Something went wrong! Check your credentials or your network.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
        });

        if(authresult != null){
          Fluttertoast.showToast(
            msg: "Please wait! This may take few seconds.",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
          final FirebaseUser userResult = await FirebaseAuth.instance.currentUser();
          user.uid=userResult.uid;
          SharedPreferences pref_user = await SharedPreferences.getInstance();
          pref_user.setString('userUid', user.uid);
          await FirebaseDatabase.instance.reference().child('Users').child(user.uid)
              .once().then((DataSnapshot snapshot){
            user.getDetails(snapshot.value["Name"], snapshot.value["Email"], snapshot.value["DOB"]);
          });
          Fluttertoast.showToast(
            msg: "Logged in successfully!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
        }}catch(e){
        print(e);
      }
      await _getMarkers();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)) );

    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width/25,
            top: MediaQuery.of(context).size.height/15,
            right: MediaQuery.of(context).size.width/25),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/50),
              child: Container(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.height/5,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage
                          ('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQLZ6yTmg3ucwhZdXwhFLac_vEykBest-mvFWOawTJglUPHIcIb'))
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(
                top:  MediaQuery.of(context).size.height/100,
            left: MediaQuery.of(context).size.width/40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Welcome',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: MediaQuery.of(context).size.width/10,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Please login to your account',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: MediaQuery.of(context).size.width/27,
                        fontWeight: FontWeight.w600,
                      color: Colors.grey
                    ),
                  ),
                  Center(
                    child: Form(
                        key: _formkey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildLoginEmail(),
                            _buildLoginPass()
                          ],
                        ),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){} ,
                        child: Text('Forgot Password?',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/30,
                          fontFamily: 'OpenSans',
                          color: Color(getColorHexFromStr('#FF0202')),
                        ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/30,
            bottom: MediaQuery.of(context).size.height/70,),
          child: GestureDetector(
            onTap: _login,
            child: Center(
              child: Container(padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/10,
                  right: MediaQuery.of(context).size.width/10,
                  top: MediaQuery.of(context).size.height/60,
                  bottom: MediaQuery.of(context).size.height/60),
                decoration: BoxDecoration(
                    color: Color(getColorHexFromStr('#4354E8')),
                    borderRadius: BorderRadius.circular(18.0)
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text('Or',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: MediaQuery.of(context).size.width/30,
                  color: Colors.grey[400]
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width/22,
              bottom: MediaQuery.of(context).size.width/22),
          child: GestureDetector(
            onTap: _loginGoogle,
            child: Center(
              child: Container(padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/40,
                  right: MediaQuery.of(context).size.width/40,
                  top: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/25),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.access_time,
                        size: MediaQuery.of(context).size.width/20,
                        color: Colors.black), SizedBox(width: 10.0),
                    Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width/23,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

          ),
        ),
        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Already a member?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width/25,
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Register()
                  ));
                },
                child: Text(' Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width/25,
                    color: Color(getColorHexFromStr('#FF0202')),
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        )
      ],
      )
    );
  }
}
