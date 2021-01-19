import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/screen/create_account/create_email/create_email.dart';
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
                  bool _autoValidate,
                  Function _submitLogin) {

  
  return Container(
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
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      child: Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text("Sign In",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(45),
                  fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Email",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              controller: usernameController,
              // autovalidate: _autoValidate,
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
            Text("Password",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              controller: passwordController,
              validator: (val) {
                if(val.isEmpty) return 'Password is required';
                if(val.length < 8) return 'Password too short';                
                return null;
              },
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
                        color: Color(0xFF5d74e3),
                        fontFamily: "Poppins-Bold",
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
            Center(
              child: InkWell(
                child: Container(
                  // width: ScreenUtil.getInstance().setWidth(330),
                  height: ScreenUtil.getInstance().setHeight(100),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      _submitLogin();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Navbar()));
                    },
                    child: Center(
                      child: Text("SIGN IN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              )
            ),
            // SizedBox(
            //   height: ScreenUtil.getInstance().setHeight(40),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     horizontalLine(),
            //     Text("Sign In With",
            //         style: TextStyle(
            //             fontSize: 16.0, fontFamily: "Poppins-Medium")),
            //     horizontalLine()
            //   ],
            // ),
            // SizedBox(
            //   height: ScreenUtil.getInstance().setHeight(30),
            // ),
            // Center(
            //   child: Row(
            //     children: <Widget>[
            //       onPressFB(context),
            //       onPressGoogle(context),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "DON'T HAVE AN ACCOUNT? ",
                  style: TextStyle(fontFamily: "Poppins-Medium"),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateEmail())).then((value) {
                              usernameController.clear();
                              passwordController.clear();
                            });
                  },
                  child: Text("SIGN UP",
                      style: TextStyle(
                          color: Color(0xFF5d74e3),
                          fontFamily: "Poppins-Bold")),
                )
              ],
            )
          ],
        ),
      )
    ),
  );
}
