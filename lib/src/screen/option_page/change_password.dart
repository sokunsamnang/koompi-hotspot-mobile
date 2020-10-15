import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/components/validator_mixin.dart';
import 'package:koompi_hotspot/src/models/model_change_password.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/services/services.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with SingleTickerProviderStateMixin {

  String messageAlert;
  bool enable = false;
  ModelChangePassword _modelChangePassword = ModelChangePassword();
  
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    removeAllFocus();
    _modelChangePassword.controlOldPassword.clear();
    _modelChangePassword.controlNewPassword.clear();
    _modelChangePassword.controlConfirmPassword.clear();
    super.dispose();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String changed) {
    _modelChangePassword.formStateChangePassword.currentState.validate();
  }

  void onSubmit(String submut){
    if (_modelChangePassword.nodeOldPassword.hasFocus) {
      FocusScope.of(context).requestFocus(_modelChangePassword.nodeNewPassword);
    } else if (_modelChangePassword.nodeNewPassword.hasFocus){
      FocusScope.of(context).requestFocus(_modelChangePassword.nodeConfirmPassword);
    } else {
      if (_modelChangePassword.enable == true) changePassword();
    }
  }

  String validateOldPass(String value){
    if(_modelChangePassword.nodeOldPassword.hasFocus){
      _modelChangePassword.responseOldPass = instanceValidate.validatePassword(value);
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseOldPass;
  } 

  String validateNewPass(String value){
    if (_modelChangePassword.nodeNewPassword.hasFocus){
      _modelChangePassword.responseNewPass = instanceValidate.validatePassword(value);
      if (_modelChangePassword.responseNewPass == null) {
        _modelChangePassword.responseConfirm = newPasswordIsmatch();
      } 
      else if (_modelChangePassword.responseConfirm == "Confirm password does not match"){ // Remove Not Match Error When New Pass Error
        _modelChangePassword.responseConfirm = null;
      }
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseNewPass;
  } 

  String validateConfirmPass(String value){
    if(_modelChangePassword.nodeConfirmPassword.hasFocus){
      _modelChangePassword.responseConfirm = instanceValidate.validatePassword(value);
      if (_modelChangePassword.responseConfirm == null) _modelChangePassword.responseConfirm = confirmPasswordIsMatch();
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseConfirm;
  } 

  void validateAllFieldNotEmpty(){ /* Enable And Disable Button */
    if (
      _modelChangePassword.controlOldPassword.text.length >= 5 &&
      _modelChangePassword.controlNewPassword.text.length >= 5 &&
      _modelChangePassword.controlConfirmPassword.text.length >= 5 
    ) validateAllFieldNoError();
    else if (_modelChangePassword.enable == true) enableButton(false);
  }

  void validateAllFieldNoError(){
    if (
      _modelChangePassword.responseOldPass == null &&
      _modelChangePassword.responseNewPass == null &&
      _modelChangePassword.responseConfirm == null 
    ) enableButton(true); 
    else if (_modelChangePassword.enable == true) enableButton(false);
  }

  String newPasswordIsmatch(){
    if (_modelChangePassword.controlConfirmPassword.text.length >= 5){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "Confirm password does not match";
      }
    }
    return _modelChangePassword.responseConfirm;
  }

  String confirmPasswordIsMatch(){
    if (_modelChangePassword.controlNewPassword.text.length >= 5){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "Confirm password does not match";
      }
    }
    return _modelChangePassword.responseConfirm;
  }

  void enableButton(bool enable){
    setState(() => _modelChangePassword.enable = enable);
  }

  void removeAllFocus() {
    _modelChangePassword.nodeOldPassword.unfocus( );
    _modelChangePassword.nodeNewPassword.unfocus();
    _modelChangePassword.nodeConfirmPassword.unfocus();
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


  Future <void> changePassword() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().changePassword(
          mData.email,
          _modelChangePassword.controlOldPassword.text,
          _modelChangePassword.controlConfirmPassword.text);
        if (response.statusCode == 200) {
          showChangePasswordDialog(context);
          // Future.delayed(Duration(seconds: 2), () {
          //   Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => LoginPage()),
          //     ModalRoute.withName('/'),
          //   ));
          // });
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

showChangePasswordDialog(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            title: Text(
              'Completed',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You have changed password Successfully, Please login again.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  dialogLoading(context);
                  StorageServices().clearPref();
                  Future.delayed(Duration(seconds: 2), () {
                    Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      ModalRoute.withName('/'),
                    ));
                  });
                },
              ),
            ],
          ),
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
                Text('Your old password was entered incorrectly, Please enter it again'),
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
      key: _modelChangePassword.globalKey,
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
                splashColor: _modelChangePassword.enable == false ? Colors.transparent : null,
                highlightColor: _modelChangePassword.enable == false ? Colors.transparent: null,
                icon: Icon(
                  Icons.check,
                  color: _modelChangePassword.enable == true ? Colors.blueAccent : Colors.grey
                ),
                onPressed: () async {
                  _modelChangePassword.enable == false ? null : changePassword();
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: _modelChangePassword.formStateChangePassword,
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
                        onFieldSubmitted: onSubmit,
                        controller: _modelChangePassword.controlOldPassword,
                        focusNode: _modelChangePassword.nodeOldPassword,
                        validator: validateOldPass, 
                        onChanged: onChanged, 
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
                        onFieldSubmitted: onSubmit,
                        controller: _modelChangePassword.controlNewPassword,
                        focusNode: _modelChangePassword.nodeNewPassword,
                        validator: validateNewPass, 
                        onChanged: onChanged,
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
                        onFieldSubmitted: onSubmit,
                        controller: _modelChangePassword.controlConfirmPassword,
                        focusNode: _modelChangePassword.nodeConfirmPassword,
                        validator: validateConfirmPass, 
                        onChanged: onChanged,
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
