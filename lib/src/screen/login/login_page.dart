import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardLogin.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/components/socialmedia.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_get_plan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/services/network_status.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'dart:io';
import 'package:koompi_hotspot/src/services/updater.dart';
import 'package:provider/provider.dart';

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
    try {
      print('run version check');
      versionCheck(context);
    } catch (e) {
      print(e);
    }
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

          });
          if(token != null){
            await StorageServices().saveString('token', token);
            await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
              ModalRoute.withName('/navbar'),
            );
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
                  Text('Error Services or Lost internet connection, Please try again!'),
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
    var responseJson = json.decode(response.body);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(responseJson['message']),
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
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Image.asset(
                      "assets/images/logo.png",
                      // width: ScreenUtil.getInstance().setWidth(500),
                      // height: ScreenUtil.getInstance().setHeight(300),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(100)),
                    formLogin(context, usernameController, passwordController,
                          _obscureText, _toggle, _email, _password, formKey, _autoValidate, _submitLogin),
                    SizedBox(height: ScreenUtil().setHeight(60)),
                    Text("OR",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(35),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        onPressFB(context),
                        onPressGoogle(context),
                      ],
                    ),
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
