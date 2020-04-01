import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:next_gen_sports_app/HomePage.dart';
import 'package:next_gen_sports_app/LoginPage.dart';
import 'package:next_gen_sports_app/UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //User object
  UserDetails user = UserDetails();
  GoogleSignIn googleAuth = GoogleSignIn();
  List<Marker> markers =[];
  String _phoneNo;
  String verificationId;




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



  String _password;
  String _email;
  String _cpassword;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
   TextEditingController date = TextEditingController();


  Widget _buildName(){
   return Padding(
     padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/60),
     child: TextFormField(
         decoration: InputDecoration(
         labelText: 'Full Name',
         labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
             focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[350]),
      )
         ),
       validator: (String value){
           if(value.isEmpty){
             return 'Name is required';
           }
           else return null;
       },
       onSaved: (String value){
           setState(() {
             user.name=value;
           });
       },
     ),
   );
  }
  Widget _buildDOB() {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
        controller: date,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(onTap:() async {
            showDatePicker(context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime(DateTime
                  .now()
                  .year + 10),
            ).then((val) {
              setState(() {
                String convertedDate = new DateFormat("dd/MM/yyy").format(val);
                date = new TextEditingController(text: convertedDate);
                user.dob = convertedDate;
              });
            });
          },
            child: Icon(Icons.calendar_today, color: Colors.grey[250], size: MediaQuery.of(context).size.width/20),
            ),
            labelText: 'Date of Birth',
            hintText: 'dd/mm/yyyy',
            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/40, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),

        validator: (String value){
          if(value.isEmpty){
            return 'DOB is required';
          }
          else return null;

        },
        onSaved: (String value){
          setState(() {
            user.dob=value;
          });
        },
      ),
    );
  }

  Widget _buildEmail(){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Email ID',
              labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
              )
          ),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        setState(() {
          user.email=value;
          _email = value;
        });
      }
      ),
    );
  }
  Widget _buildLoginPhone() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 20,
          bottom: MediaQuery.of(context).size.height / 60),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.width / 30,
                fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Phone No. is required';
          } else
            return null;
        },
        onSaved: (String value) {
          _phoneNo = value;
        },
      ),
    );
  }
  Widget _buildPass(){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(Icons.visibility_off),
            ),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350])
              )
          ),
        obscureText: true,
        controller: _pass,
        onSaved: (val){
            setState(() {
              _cpassword = val;
            });
        },
        validator: (String _pass){
          if(_pass.isEmpty){
            return 'Name is required';
          }
            else if(_pass.length<7){
              return 'Please enter a strong password';
            }
          else return null;

        },
      ),
    );
  }
  Widget _buildConfPass(){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),

              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350])
              )
          ),
        controller: _confirmPass,
        validator: (String value){
          if(value.isEmpty){
            return 'Confirm your password';
          }
          if(value != _pass.text){
            return 'Passwords do not match!';
          }
          else return null;

        },
        onSaved: (String value){
          setState(() {
            _cpassword=value;
          });
        },
      ),
    );
  }
  Future <void> _googleSignIn() async {
    await googleAuth.signOut();
    GoogleSignInAccount _account = await googleAuth.signIn();
    try{FirebaseAuth auth = FirebaseAuth.instance;
    if (_account != null) {
      AuthResult res = await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await _account.authentication).idToken,
        accessToken: (await _account.authentication).accessToken,
      )
      );
      if(res.user == null){
        Fluttertoast.showToast(
          msg: 'Google Sign in failed.',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: MediaQuery.of(context).size.width/30,
        );
      }
      else {
        Fluttertoast.showToast(
          msg: "Please wait! This may take few seconds.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: MediaQuery.of(context).size.width/30,
        );
        final FirebaseUser userResult = await FirebaseAuth.instance.currentUser();
        user.uid = userResult.uid;
        user.email = userResult.email;
        String name;
        bool ifExist = false;
        await FirebaseDatabase.instance.reference().child("Users").child(user.uid).once().then((DataSnapshot snap){
          name = snap.value["Name"];
        }).catchError((e) async {
          SharedPreferences pref_uid = await SharedPreferences.getInstance();
          pref_uid.setString('userUid', user.uid);

          Fluttertoast.showToast(
            msg: "Signed in successfully!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
          user.name = _account.displayName;
         // await FirebaseDatabase.instance.reference().child("Users").child(user.uid).set(user.toJsonGoogle());
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(user)));
          ifExist = true;
        });
            if(!ifExist) {
              Fluttertoast.showToast(
                msg: 'Email-ID is already in use, try again with another id.',
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.black.withOpacity(0.7),
                textColor: Colors.white,
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .width / 30,
              );
            }
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
Future<void> _register() async{
  Fluttertoast.showToast(
    msg: "Please wait! This may take few seconds.",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: MediaQuery.of(context).size.width / 30,
  );
  if (_formkey.currentState.validate()) {
    _formkey.currentState.save();
    try {
      bool ifExist = false;
      AuthResult userResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email, password: _cpassword).catchError((e){if(e is PlatformException)
      {
        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE'){
          Fluttertoast.showToast(
            msg: 'Email-ID is already in use, try again with another id.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
          ifExist = true;
        }
      }
      });
      if(!ifExist){
        if(userResult != null){
          FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
          user.uid = firebaseUser.uid;
          _verifyPhone();
        }
        else {
          Fluttertoast.showToast(
            msg: 'Something went wrong! Check your credentials or your network.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: MediaQuery.of(context).size.width/30,
          );
        }}
    } catch (e) {
      print(e);
    }
  }
}

Future<void> _verifyPhone() async{
  bool inUse = false;
  final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential authResult) async {
    FirebaseUser linkUser = await FirebaseAuth.instance.currentUser();
    linkUser.linkWithCredential(authResult);
    if(authResult != null){
      Fluttertoast.showToast(
        msg: "Registration Succesfull!",
        fontSize: MediaQuery.of(context).size.width / 25,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
      );
    }
    SharedPreferences pref_user = await SharedPreferences.getInstance();
    pref_user.setString('userUid', user.uid);
    user.phone = _phoneNo;
    user.email = _email;
    user.slotCount =0;
    await FirebaseDatabase.instance.reference().child('Users').child(user.uid).set(user.toJson());
    await FirebaseDatabase.instance.reference().child('UsersList').child(user.uid).set(user.toJsonList());
    await FirebaseDatabase.instance.reference().child("PhoneNumbers").child(_phoneNo).set({
      "Name" : user.name,
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)) );
  };

  final PhoneVerificationFailed verificationFailed =
      (AuthException exception) {
    Fluttertoast.showToast(
      msg: "${exception.message}",
      fontSize: MediaQuery.of(context).size.width / 25,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
    );
  };

  final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
    verificationId = verId;
    print('asdasdasdasdas');
  };

  final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
    verificationId = verId;
    print("asads");
  };
  final formState = _formkey.currentState;
  if (formState.validate()) {
    formState.save();
    FirebaseUser delUser = await FirebaseAuth.instance.currentUser();
    await FirebaseDatabase.instance.reference().child("PhoneNumbers").child(_phoneNo).once().then((DataSnapshot snapshot){
      print(snapshot.value['Name']);
      Fluttertoast.showToast(
        msg: "Number Already in Use!",
        fontSize: MediaQuery.of(context).size.width / 25,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
      );
      delUser.delete();
      inUse = true;
    }).catchError((e){
      print(e);
    });
    (!inUse)?await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + _phoneNo,
        timeout: Duration(seconds: 10),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout):null;
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
               height: MediaQuery.of(context).size.height/10,
               width: MediaQuery.of(context).size.height/10,
               decoration: BoxDecoration(
                 color: Colors.transparent,
                 image: DecorationImage(
                   fit: BoxFit.cover,
                     image: NetworkImage
                       ('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQLZ6yTmg3ucwhZdXwhFLac_vEykBest-mvFWOawTJglUPHIcIb'))
               ),
             ),
           ),
           Text('Register Now!',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.width/14,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
           ),
           Padding(
             padding:  EdgeInsets.only(
                 top: MediaQuery.of(context).size.height/50,
                 right: MediaQuery.of(context).size.width/25),
             child: Form(
               key: _formkey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     _buildLoginPhone(),
                     _buildName(),
                     _buildDOB(),
                     _buildEmail(),
                     _buildPass(),
                   ],
                 ),
           )
           )
         ],
       ),
       Padding(
         padding: EdgeInsets.only(
             top: MediaQuery.of(context).size.height/30,
             bottom: MediaQuery.of(context).size.height/70,),
         child: GestureDetector(
           onTap: _register,
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
                 'Register',
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
           onTap: _googleSignIn,
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
                     'Register with Google',
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
                     builder: (context) => Login()
                 ));
               },
               child: Text('Login',
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
      ),
    );
  }

}


