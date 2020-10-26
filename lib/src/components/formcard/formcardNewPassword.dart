import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget formCardNewPassword(
  BuildContext context, 
  TextEditingController _passwordController, 
  TextEditingController _confirmPasswordController,
  bool _obscureText,
  Function _toggle,
  bool _obscureText2,
  Function _toggle2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("New Password",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                validator: (val) {
                  if(val.length < 8) return 'Password too short';
                  if(val != _confirmPasswordController.text) return 'Password not match';
                  return null;
                },
                onSaved: (val) => _passwordController.text = val,
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
              SizedBox(height: 20),
              Text("New Confirm Password",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                validator: (val) {
                  if(val.length < 8) return 'Password too short';
                  if(val != _passwordController.text) return 'Password not match';
                  return null;
                },
                onSaved: (val) => _passwordController.text = val,
                autovalidate: _autoValidate,
                controller: _confirmPasswordController,
                obscureText: _obscureText2,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggle2();
                      },
                      child: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
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
