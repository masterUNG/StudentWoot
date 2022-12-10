import 'dart:convert' as convert;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/screen/home/home_screen.dart';
import 'package:student_app/screen/register_screen.dart';
import 'package:student_app/utilities/constants.dart';
// import 'package:sweetalert/sweetalert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var username;
  var password;

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
                          'Sign In',
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
                              'User Name',
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
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your User Name',
                                  hintStyle: kHintTextStyle,
                                ),
                                validator: (userValue) {
                                  if (userValue.isEmpty) {
                                    return 'Please enter User Name';
                                  }
                                  username = userValue;
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
                              'Password',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
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
                                  hintText: 'Enter your Password',
                                  hintStyle: kHintTextStyle,
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                print('Forgot Password Button Pressed'),
                            // padding: EdgeInsets.only(right: 0.0),
                            child: Text(
                              'Forgot Password?',
                              style: kLabelStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.0),
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
                                _login();
                              }
                            },
                            child: Text(
                              'LOGIN',
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
                                    builder: (context) => RegisterScreen()));
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an Account? ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Register',
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

  void _login() async {
    var data = {
      'username': username,
      'password': password,
      'remember_me': true
    };
    var res = await Network().authData(data, 'auth/mobile_login');
    var body = convert.json.decode(res.body);
    // log('a' =body);
    if (res.statusCode == 200) {
      if (body['message'] == null) {
        await Network().setToken(body['access_token']);
        await Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // SweetAlert.show(context,
        //     title: "เกิดข้อผิดพลาด",
        //     subtitle: body['message'],
        //     style: SweetAlertStyle.error);
      }
    } else {
      var err;
      if (res.statusCode == 401) {
        err = 'User/Password ไม่ถูกต้อง';
      } else if (res.statusCode == 500) {
        err = 'การเชื่อมต่อขัดข้อง';
      } else {
        err = 'การเชื่อมต่อขัดข้อง';
      }
      // SweetAlert.show(context,
      //     title: "เกิดข้อผิดพลาด",
      //     subtitle: '$err',
      //     style: SweetAlertStyle.error);
    }
  }
}
