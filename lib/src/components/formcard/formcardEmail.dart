import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/index.dart';

@override
Widget formCardEmail(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    bool _obscureText,
    Function _toggle,
    String _email,
    String _password,
    GlobalKey<FormState> formKey,
    bool _autoValidate) {

    return new Container(
      width: double.infinity,
  //      height: ScreenUtil.getInstance().setHeight(500),
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
      child: Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Sign Up",
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
                validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                onSaved: (val) => _email = val,
                autovalidate: _autoValidate,
                controller: emailController,
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
                validator: (val) => val.length < 6 ? 'Password too short' : null,
                onSaved: (val) => _password = val,
                autovalidate: _autoValidate,
                controller: passwordController,
                obscureText: _obscureText,
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
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    ),
  );
}
