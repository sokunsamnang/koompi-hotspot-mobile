import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardLogin.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/create_account/create_email/create_email.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/services/network_status.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'dart:io';

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

  NetworkStatus _networkStatus = NetworkStatus();
  
  @override
  void initState() {
    internet();
    super.initState();
  }

  void internet() async {
    _networkStatus.connectivityResult = await Connectivity().checkConnectivity();
    _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        _networkStatus.connectivityResult = event;
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void _submitLogin(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      login();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  //check connection and login
  Future <void> login() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().userLogIn(
          usernameController.text,
          passwordController.text);
        if (response.statusCode == 200) {
          var responseJson = json.decode(response.body);
          token = responseJson['token'];
            await GetRequest().getUserProfile(token)
              .then((values) {
                setState(() {
                  _isLoading = true;
                });
            Navigator.pop(context);
          });
          if(token != null){
            await StorageServices().saveString('token', token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Navbar()));
          }
          else {
            Navigator.pop(context);
            try {
              messageAlert = responseJson['error']['message'];
            } catch (e) {
              messageAlert = responseJson['message'];
            }
          }
        } 
        else if (response.statusCode == 401){
          Navigator.pop(context);
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          Navigator.pop(context);
          return showErrorServerDialog(context);
        }
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
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
                  Text('Error Services or Lost internet connection'),
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

  showErrorDialog(BuildContext context) async {
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
                Text(response.body),
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
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Error server or Server in maintenance'),
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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _networkStatus.connectivityResult != ConnectivityResult.none ? Stack(
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
                          // width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              
                              _submitLogin();
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
        ) : _networkStatus.noNetwork(context),
      ),
    );
  }
}
