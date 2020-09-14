import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordConfirmController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String messageAlert;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  /* Current password toggle */
  
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /* Second password toggle */
  
  // Initially password is obscure
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  /* Third password toggle */
  
  // Initially password is obscure
  bool _obscureText3 = true;

  // Toggles the password show status
  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  void _submitValidate(){
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

  Future <void> changePassword() async {
    _submitValidate();
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().changePassword(
          mData.email,
          _oldPasswordController.text,
          _newPasswordController.text);
        if (response.statusCode == 200) {
          Future.delayed(Duration(seconds: 2), () {
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              ModalRoute.withName('/'),
            ));
          });
        } 
        else if (response.statusCode == 401){
          Navigator.pop(context);
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          Navigator.pop(context);
          return showErrorServerDialog(context);
        }
        // else {
        //   print('Login not Successful');
        //   return _submit();
        // }
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
      errorDialog(context);
    }
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
                Text('You may enter incorrect password'),
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
                Text('Server May Maintenance'),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Password', style: TextStyle(color: Colors.black)),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blueAccent,
                ),
                onPressed: () async {
                  print(_oldPasswordController.text);
                  print(_newPasswordController.text);
                  print(_newPasswordConfirmController.text);
                  setState(() {
                    changePassword();
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: formKey,
          autovalidate: _autoValidate,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: _obscureText,
                        validator: (val) => val.length < 6 ? 'Password is required more than 6 characters' : null,
                        onSaved: (val) => _oldPasswordController.text = val,
                        controller: _oldPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle();
                            },
                            child: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          hintText: 'Current Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                          )
                        ),
                        
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: _obscureText2,
                        validator: (val){
                          if(val.isEmpty)
                            return 'New Password Is Empty';
                          if(val != _newPasswordConfirmController.text)
                            return 'Password Not Match';
                          return null;
                          },
                        onSaved: (val) => _newPasswordController.text = val,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle2();
                            },
                            child: Icon(
                              _obscureText2 ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          hintText: 'New Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                          )
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: _obscureText3,
                        controller: _newPasswordConfirmController,
                        validator: (val){
                          if(val.isEmpty)
                            return 'New Password Is Empty';
                          if(val != _newPasswordController.text)
                            return 'Password Not Match';
                          return null;
                          },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle3();
                            },
                            child: Icon(
                              _obscureText3 ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          hintText: 'Confirm New Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
