import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/login/forgot_password_body.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: DefaultTabController(
  //       initialIndex: 0,
  //       length: 2,
  //       child: forgetPasswordBody(context),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: forgetPasswordBody(context),
      ),
    );
  }
}
