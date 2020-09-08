import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardLogin.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/screen/create_account/create_email/create_email.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _email;
  String _password;

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  
  String token;
  String messageAlert;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    setState(() {
      AppService.noInternetConnection();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  //check connection and login
  Future <void> login() async {
    _submit();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().userLogIn(
          usernameController.text,
          passwordController.text);
        if (response.statusCode == 200) {
          SharedPreferences isToken = await SharedPreferences.getInstance();
          var responseJson = json.decode(response.body);
          token = responseJson['token'];
          await loadData(context);
          
          if(token != null){
            await isToken.setString('token', token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Navbar()));
          }
          else {
            try {
              messageAlert = responseJson['error']['message'];
            } catch (e) {
              messageAlert = responseJson['message'];
            }
          }
        } 
        else if (response.statusCode == 401){
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          return showErrorServerDialog(context);
        }
        // else {
        //   print('Login not Successful');
        //   return _submit();
        // }
      }
    } on SocketException catch (_) {
      print('not connected');
      errorDialog(context);
    }
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  errorDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Error Services'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  loadData(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(Colors.blue)),
                  ],
                )
              ],
            ),
          );
        });
    await GetRequest().getUserName(token)
        .then((values) {
          setState(() {
            _isLoading = true;
          });
      Navigator.pop(context);
    });
  }

  showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Login failed, Please enter the correct email or password'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  showErrorServerDialog(BuildContext context) async {
    var response = await PostRequest().userLogIn(
          usernameController.text,
          passwordController.text);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${response.body}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset("assets/images/image_02.png"),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/koompi_logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("KOOMPI HOTSPOT",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 150.0),
                        child: Image.asset("assets/images/digital_nomad.png",
                          width: 200.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 140.0),
                        child: formLogin(context, usernameController, passwordController,
                        _obscureText, _toggle, _email, _password, formKey, _autoValidate),
                      ),
                      
                    ],
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
                  Center(
                    child: InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: ScreenUtil.getInstance().setHeight(100),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            
                            login();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Navbar()));
                          },
                          child: Center(
                            child: Text("SIGN IN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(40),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     horizontalLine(),
                  //     Text("Sign In With",
                  //         style: TextStyle(
                  //             fontSize: 16.0, fontFamily: "Poppins-Medium")),
                  //     horizontalLine()
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(30),
                  // ),
                  // Center(
                  //   child: Row(
                  //     children: <Widget>[
                  //       onPressFB(context),
                  //       onPressGoogle(context),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "DON'T HAVE AN ACCOUNT? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateEmail())).then((value) {
                                    usernameController.clear();
                                    passwordController.clear();
                                  });
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
