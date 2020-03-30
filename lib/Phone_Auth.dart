import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String _picked = "Pay and Play";
  String convDate;
  final _formkey = GlobalKey<FormState>();
  TextEditingController date = TextEditingController();
  String _name;
  String _DOB;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Other Details',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width/20,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding:EdgeInsets.only(
              top: MediaQuery.of(context).size.width/20,
              left: MediaQuery.of(context).size.width/20,
              right: MediaQuery.of(context).size.width/20
          ),
          child: ListView(
            children: <Widget>[
              _buildDOB(),
              _buildPhoneNum(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(onPressed: (){},
                      color: Colors.grey[200],
                      child: Text(
                        'Authenticate',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        ),
                      )),
                ],
              ),
              _buildOTP(),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/20),
                child: Text(
                  'Type of  User',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width/30
                  ),
                ),
              ),
              RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,

                onSelected: (String selected) => setState((){
                  _picked = selected;
                }),
                labels: <String>[
                  "Pay and Play",
                  "Member",
                ],
                labelStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width/30),
                picked: _picked,
                itemBuilder: (Radio rb, Text txt, int i){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      rb,
                      txt,
                      SizedBox(width: MediaQuery.of(context).size.width/7)
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/7),
                child: Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )                ,
                    onPressed: (){},
                    color: Colors.cyan[600],
                    child: Text('Finish',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/20
                      ),),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
  Widget _buildDOB() {
    var date;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
      child: TextFormField(

        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: (){
                showDatePicker(
                    context: context,
                    initialDate:
                    DateTime.now().add(Duration(days: 7)),
                    firstDate:
                    DateTime.now().add(Duration(days: 6)),
                    lastDate: DateTime(DateTime.now().year + 10))
                    .then((value) {
                  convDate = new DateFormat("dd/MM/yyyy").format(value);

                });
                setState(() {});
              },
              child: Icon(Icons.calendar_today, color: Colors.grey[250], size: MediaQuery.of(context).size.width/20),

            ),

            labelText: 'Date of Birth',
            hintText: 'Click on the calendar icon',
            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/40, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),
        controller: date,
        keyboardType: TextInputType.phone,

        validator: (String value){
          if(value.isEmpty){
            return 'DOB is required';
          }
          else return null;

        },
        onSaved: (String value){
          _name=value;
        },

      ),
    );
  }
  Widget _buildPhoneNum() {
    var date;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
      child: TextFormField(
        controller: date,
        decoration: InputDecoration(
            hintText: 'Phone Authentication',
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/40, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),
        keyboardType: TextInputType.phone,

        validator: (String value){
          if(value.isEmpty){
            return 'Phone Number is required';
          }
          else if(value.length!=10){
            return 'Enter a valid Phone Number';
          }
          else return null;

        },
        onSaved: (String value){
          _name=value;
        },
      ),
    );
  }
  Widget _buildOTP() {
    var date;
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height/40,
          bottom: MediaQuery.of(context).size.height/60),
      child: TextFormField(
        controller: date,
        decoration: InputDecoration(



            labelText: 'Enter OTP',

            labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/40, fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[350]),
            )
        ),
        keyboardType: TextInputType.phone,

        validator: (String value){
          if(value.isEmpty){
            return 'OTP is required for authentication';
          }
          else if(value.length<6){
            return 'Enter a valid OTP';
          }
          else return null;

        },
        onSaved: (String value){
          _name=value;
        },
      ),
    );
  }
}

