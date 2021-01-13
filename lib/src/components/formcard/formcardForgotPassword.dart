import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget formCardForgotPasswordEmail(
  BuildContext context, 
  TextEditingController _emailController, 
  String _email,
  Function _submit,
  GlobalKey<FormState> formKey, 
  bool _autoValidate) {

  return new Container(
    width: double.infinity,
//      height: ScreenUtil.getInstance().setHeight(500),
    padding: EdgeInsets.only(bottom: 1),
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
          color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0),
      BoxShadow(
          color: Colors.black12, offset: Offset(0.0, -10.0), blurRadius: 10.0),
    ]),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Email",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                controller: _emailController,
                autovalidate: _autoValidate,
                validator: (val) {
                  if(val.isEmpty) return 'Email is required';
                  if(!val.contains('@')) return 'Email invalid';                
                  return null;
                },
                onSaved: (val) => _email = val,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
          ],
        ),
      )
    ),
  );
}
