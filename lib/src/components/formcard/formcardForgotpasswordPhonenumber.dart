import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget formCardForgotPasswordPhoneNumber(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Phone Number",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
        ],
      ),
    ),
  );
}
