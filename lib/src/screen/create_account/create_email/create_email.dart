import 'package:flutter/material.dart';
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

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      print('Validated');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerificationAccount()));
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: createEmailBody(context, emailController, passwordController, _obscureText, _toggle, _email, _password, _submit, formKey, _autoValidate),
      ),
    );
  }
}