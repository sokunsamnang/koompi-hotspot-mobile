import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/screen/login/forgot_password.dart';

@override
Widget formLogin( BuildContext context, 
                  TextEditingController usernameController,
                  TextEditingController passwordController,
                  bool _obscureText, 
                  Function _toggle, 
                  String _email, 
                  String _password,
                  GlobalKey<FormState> formKey, 
                  bool _autoValidate) {

  
  return new Container(
    width: double.infinity,
    //  height: ScreenUtil.getInstance().setHeight(500),
    padding: EdgeInsets.only(bottom: 1),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ]),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Sign In",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Email",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              controller: usernameController,
              autovalidate: _autoValidate,
              validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
              onSaved: (val) => _email = val,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Password",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              controller: passwordController,
              validator: (val) => val.length < 8 ? 'Password too short' : null,
              onSaved: (val) => _password = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword())).then((value) {
                              usernameController.clear();
                              passwordController.clear();
                            }
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ),
  );
}
