import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardEmail.dart';
import 'package:koompi_hotspot/src/screen/create_account/complete_info/complete_info.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';

  @override
  Widget createEmailBody(
    BuildContext context, 
    TextEditingController emailController, 
    TextEditingController passwordController, 
    bool _obscureText,
    Function _toggle,
    String _email,
    String _password,
    dynamic _submit,
    GlobalKey formKey,
    bool _autoValidate,
    Function onSignUpByEmail
    ) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1410, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset("assets/images/image_02.png"),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/koompi_logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("KOOMPI HOTSPOT",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 150.0),
                        child: Image.asset("assets/images/digital_nomad.png",
                          width: 200.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 140.0),
                        child: formCardEmail(context, emailController, passwordController, _obscureText, _toggle, _email, _password, formKey, _autoValidate),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(30),
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
                              onTap: () {
                                _submit();
                                // Navigator.pushReplacement(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) => CompleteInfo(_email)),
                                // );
                              },  
                              child: Center(
                                child: Text("SIGN UP",
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
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'ALREADY HAVE AN ACCOUNT?',
                          style: TextStyle(
                            fontFamily: "Poppins-Medium",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                ModalRoute.withName('/loginScreen')  
                              );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Color(0xfff79c4f),
                                fontFamily: "Poppins-Bold"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }