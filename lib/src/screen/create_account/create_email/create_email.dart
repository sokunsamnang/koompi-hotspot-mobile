import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/screen/create_account/create_email/create_email_body.dart';
import 'package:koompi_hotspot/src/screen/create_account/verfication/verfication_account.dart';

class CreateEmail extends StatefulWidget {
  _CreateEmailState createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {

  String messageAlert;

  final formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  String _email;
  String _password;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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

  Future <void> register() async {
    _submit();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().register(
          emailController.text,
          passwordController.text);
        if (response.statusCode == 200) {
          var responseJson = json.decode(response.body);

          if(response.body == null){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VerificationAccount()));
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
      }
    } on SocketException catch (_) {
      print('not connected');
      errorDialog(context);
    }
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
                Text('Register failed, Please enter the correct email or password'),
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
    var response = await PostRequest().register(
          emailController.text,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: createEmailBody(context, emailController, passwordController, _obscureText, _toggle, _email, _password, _submit, formKey, _autoValidate, register),
      ),
    );
  }
}