import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget formCardPhoneNumber(
    BuildContext context,
    phonenumberController,
    usernameController,
    passwordController,
    bool _obscureText,
    Function _toggle) {
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
          Text("Phone Number",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            decoration: InputDecoration(
                hintText: "0123456789",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            controller: phonenumberController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Username",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
                hintText: "username",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("PassWord",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
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
  );
}
