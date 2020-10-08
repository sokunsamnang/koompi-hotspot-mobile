import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget formCardNewPassword(
  BuildContext context, 
  TextEditingController _passwordController, 
  String _password,
  bool _obscureText,
  Function _toggle,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("New Password",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                validator: (val) => val.length < 8 ? 'Password too short' : null,
                onSaved: (val) => _password = val,
                autovalidate: _autoValidate,
                controller: _passwordController,
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
              height: ScreenUtil().setHeight(30),
            ),
          ],
        ),
      )
    ),
  );
}
