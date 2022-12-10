import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/screen/home/home_screen.dart';
import 'package:student_app/screen/login.dart';
import 'package:student_app/utilities/constants.dart';
// import 'package:sweetalert/sweetalert.dart';
import 'dart:convert' as convert;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var studentid;
  var citizenid;
  var phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Student ID',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                maxLength: 5,
                                // maxLengthEnforced: true,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.school_rounded,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Student ID',
                                  hintStyle: kHintTextStyle,
                                ),
                                validator: (studentidValue) {
                                  if (studentidValue.isEmpty) {
                                    return 'Please enter Student ID';
                                  }
                                  studentid = studentidValue;
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Citizen ID',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Citizen ID',
                                  hintStyle: kHintTextStyleerror,
                                ),
                                validator: (citizenidValue) {
                                  if (citizenidValue.isEmpty) {
                                    return 'Please enter Citizen ID';
                                  }
                                  citizenid = citizenidValue;
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Phone Number',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                maxLength: 10,
                                // maxLengthEnforced: true,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.phone_iphone,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Phone Number',
                                  hintStyle: kHintTextStyleerror,
                                ),
                                validator: (phoneValue) {
                                  if (phoneValue.isEmpty) {
                                    return 'Please enter Phone Number';
                                  }
                                  phone = phoneValue;
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding:  EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              ),
                              ),
                              // elevation: 5.0,
                              onPressed: () {
                              if (_formKey.currentState.validate()) {
                              _register();
                              }
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Color(0xFF527DAA),
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Back to ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _register() async{
    var data = { 'studentid' : studentid,
      'citizenid' : citizenid,
      'phone' : phone
    };
    var res = await Network().createUser(data, 'createUserMobile');
    var body = convert.json.decode(res.body);
    if(res.statusCode == 200){
      if(body['message'] == null){
        await Network().setToken(body['access_token']);
        await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => HomeScreen()));
      }else{

        // SweetAlert.show(context,
        //     title: "เกิดข้อผิดพลาด",
        //     subtitle: body['message'],
        //     style: SweetAlertStyle.error);
      }
    }else{
      // SweetAlert.show(context,
      //     title: "เกิดข้อผิดพลาด",
      //     subtitle: 'การเชื่อมต่อขัดข้อง',
      //     style: SweetAlertStyle.error);
    }
  }
}
