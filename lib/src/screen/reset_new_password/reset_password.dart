import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/screen/reset_new_password/reset_password_body.dart';

class ResetNewPassword extends StatefulWidget {
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _password = "";
  
  Future <void> _submit() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().resetPassword(
          _emailController.text,
          _passwordController.text);
        if (response.statusCode == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()));
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
    }
  }

  showErrorServerDialog(BuildContext context) async {
    var response = await PostRequest().forgotPasswordByEmail(_emailController.text);
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

  showErrorDialog(BuildContext context) async {
    var response = await PostRequest().forgotPasswordByEmail(_emailController.text);

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: resetNewPasswordBody(context, _password, _passwordController, _obscureText, _toggle, _submit, formKey, _autoValidate)
      ),
    );
  }
}
