import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/all_export.dart';

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
      if (_modelChangePassword.enable == true) _resetPassword();
    }
  }

  String validateOldPass(String value){
    if(_modelChangePassword.nodeOldPassword.hasFocus){
      _modelChangePassword.responseOldPass = instanceValidate.validatePassword(value, context);
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseOldPass;
  } 

  String validateNewPass(String value){
    if (_modelChangePassword.nodeNewPassword.hasFocus){
      _modelChangePassword.responseNewPass = instanceValidate.validatePassword(value, context);
      if (_modelChangePassword.responseNewPass == null) {
        _modelChangePassword.responseConfirm = newPasswordIsmatch();
      } 
      else if (_modelChangePassword.responseConfirm == "Password does not match"){ // Remove Not Match Error When New Pass Error
        _modelChangePassword.responseConfirm = null;
      }
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseNewPass;
  } 

  String validateConfirmPass(String value){
    if(_modelChangePassword.nodeConfirmPassword.hasFocus){
      _modelChangePassword.responseConfirm = instanceValidate.validatePassword(value, context);
      if (_modelChangePassword.responseConfirm == null) _modelChangePassword.responseConfirm = confirmPasswordIsMatch();
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseConfirm;
  } 

  void validateAllFieldNotEmpty(){ /* Enable And Disable Button */
    if (
      _modelChangePassword.controlOldPassword.text.length >= 8 &&
      _modelChangePassword.controlNewPassword.text.length >= 8 &&
      _modelChangePassword.controlConfirmPassword.text.length >= 8 
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
    var _lang = AppLocalizeService.of(context);
    if (_modelChangePassword.controlConfirmPassword.text.length >= 8){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "${_lang.translate('password_does_not_match_validate')}";
      }
    }
    return _modelChangePassword.responseConfirm;
  }

  String confirmPasswordIsMatch(){
    var _lang = AppLocalizeService.of(context);
    if (_modelChangePassword.controlNewPassword.text.length >= 8){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "${_lang.translate('password_does_not_match_validate')}";
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

  String alertText;
  bool isLoading = false;

  Future <void> _resetPassword() async {
    dialogLoading(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _token = pref.getString('token');
    var responseBody;
    try {
      String apiUrl = 'https://api-hotspot.koompi.org/api/change-password/account-phone';
      setState(() {
        isLoading = true;
      });
      var response = await http.put(apiUrl,
        headers: <String, String>{
          "accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer " + _token,
        },
        body: jsonEncode(<String, String>{
          "old_password": _modelChangePassword.controlOldPassword.text,
          "new_password": _modelChangePassword.controlConfirmPassword.text,
        }));

      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        showChangePasswordDialog(context);
        await StorageServices().clearToken('token');
        await StorageServices().clearToken('phone');
        await StorageServices().clearToken('password');
        
      } else {
        Navigator.pop(context);
        print(response.body);
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.yellow),
                  Text('WARNING', style: TextStyle(fontFamily: 'Poppins-Bold'),),
                ],
              ),
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
    } catch (e) {
      Navigator.pop(context);
      alertText = responseBody['message'];
    }
  }


showChangePasswordDialog(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
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
                  Future.delayed(Duration(seconds: 2), () {
                    Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPhone()),
                      ModalRoute.withName('/loginPhone'),
                    ));
                  });
                },
              ),
            ],
          ),
        );
      });
}

  // errorDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text('Error Services'),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // showErrorDialog(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Your old password was entered incorrectly, Please enter it again'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  // }

  // showErrorServerDialog(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Server May Maintenance'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: _modelChangePassword.globalKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('change_password'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
                  _modelChangePassword.enable == false ? null : _resetPassword();
                },
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
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
                        Text(_lang.translate('current_password')),
                        SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: _obscureText,
                          onFieldSubmitted: onSubmit,
                          controller: _modelChangePassword.controlOldPassword,
                          focusNode: _modelChangePassword.nodeOldPassword,
                          validator: validateOldPass, 
                          onChanged: onChanged, 
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(LineIcons.unlock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _toggle();
                              },
                              child: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                            hintText: _lang.translate('current_password'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(12.0))
                            )
                          ),
                          
                        ),
                        SizedBox(height: 16.0),
                        Text(_lang.translate('new_password_tf')),
                        SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: _obscureText2,
                          onFieldSubmitted: onSubmit,
                          controller: _modelChangePassword.controlNewPassword,
                          focusNode: _modelChangePassword.nodeNewPassword,
                          validator: validateNewPass, 
                          onChanged: onChanged,
                          decoration: InputDecoration(
                            prefixIcon: Icon(LineIcons.unlock_alt),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _toggle2();
                              },
                              child: Icon(
                                _obscureText2 ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                            hintText: _lang.translate('new_password_tf'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(12.0))
                            )
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(_lang.translate('new_confirm_password_tf')),
                        SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: _obscureText3,
                          onFieldSubmitted: onSubmit,
                          controller: _modelChangePassword.controlConfirmPassword,
                          focusNode: _modelChangePassword.nodeConfirmPassword,
                          validator: validateConfirmPass, 
                          onChanged: onChanged,
                          decoration: InputDecoration(
                            prefixIcon: Icon(LineIcons.unlock_alt),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _toggle3();
                              },
                              child: Icon(
                                _obscureText3 ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                            hintText: _lang.translate('new_confirm_password_tf'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(12.0))
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
