import 'dart:io';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/create_account/create_email/create_email_body.dart';
import 'package:koompi_hotspot/src/screen/create_account/verfication/verfication_account.dart';

class CreateEmail extends StatefulWidget {

  _CreateEmailState createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {



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

  _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      onSignUpByEmail();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future <void> onSignUpByEmail() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().signUpWithEmail(
          emailController.text,
          passwordController.text);
        if (response.statusCode == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PinCodeVerificationScreen(emailController.text, passwordController.text)));
          // print(response.statusCode);
          // var responseJson = json.decode(response.body);    
          // if(response.body == 'Please check your E-mail!'){
          //   print(response.statusCode);
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => VerificationAccount()));
          // }
          // else {
          //   try {
          //     messageAlert = responseJson['error']['message'];
          //   } catch (e) {
          //     messageAlert = responseJson['message'];
          //   }
          // }
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
    }
  }

  showErrorServerDialog(BuildContext context) async {
    var response = await PostRequest().signUpWithEmail(
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

  showErrorDialog(BuildContext context) async {
    var response = await PostRequest().signUpWithEmail(
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

  // showErrorServerDialog(BuildContext context) async {
  //   var response = await PostRequest().register(
  //         emailController.text,
  //         passwordController.text);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('${response.body}'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: createEmailBody(context, emailController, passwordController, _obscureText, _toggle, _email, _password, _submit, formKey, _autoValidate, onSignUpByEmail),
      ),
    );
  }
}