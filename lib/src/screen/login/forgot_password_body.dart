import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardForgotPassword.dart';
import 'package:koompi_hotspot/src/components/formcard/formcardForgotpasswordPhonenumber.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';

// Widget forgetPasswordBody(BuildContext context) {
//   ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
//   ScreenUtil.instance =
//       ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

//   return Container(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Image.asset("assets/images/password.jpg"),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(top: 550.0),
//                     child: Image.asset("assets/images/image_02.png")),
//                 Padding(
//                   padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 285),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         child: TabBar(
//                           indicatorColor: Colors.red,
//                           tabs: <Widget>[
//                             Container(
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                               width: double.infinity,
//                               child: Icon(
//                                 Icons.email,
//                                 size: 23.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Container(
//                               width: double.infinity,
//                               padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                               alignment: Alignment.center,
//                               child: Icon(
//                                 Icons.phone,
//                                 size: 23.0,
//                                 color: Colors.black,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                               color: Colors.deepOrangeAccent[400],
//                               fontFamily: 'Medium',
//                               fontSize: 23),
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           'we just need your registered email or Phone Number to send you password reset',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: 'Medium',
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 110.0,
//                         child: Form(
//                             child: TabBarView(children: <Widget>[
//                           formCardForgotPasswordEmail(context),
//                           formCardForgotPasswordPhoneNumber(context),
//                         ])),
//                       ),
//                       SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           InkWell(
//                             child: Container(
//                               width: ScreenUtil.getInstance().setWidth(350),
//                               height: ScreenUtil.getInstance().setHeight(100),
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(colors: [
//                                     Color(0xFF17ead9),
//                                     Color(0xFF6078ea)
//                                   ]),
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color:
//                                             Color(0xFF6078ea).withOpacity(.3),
//                                         offset: Offset(0.0, 8.0),
//                                         blurRadius: 8.0)
//                                   ]),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   onTap: () {},
//                                   child: Center(
//                                     child: Text("Reset Password",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: "Poppins-Bold",
//                                             fontSize: 18,
//                                             letterSpacing: 1.0)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 20),
//                         alignment: Alignment.bottomCenter,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Back to Login !',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoginPage()));
//                               },
//                               splashColor: Colors.transparent,
//                               highlightColor: Colors.transparent,
//                               child: Text(
//                                 'Login',
//                                 style: TextStyle(
//                                     color: Color(0xfff79c4f),
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  @override
  Widget forgetPasswordBody(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Image.asset("assets/images/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image.asset("assets/images/password.jpg"),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Center(
                        child: Text('Forgot Password?',
                          style: TextStyle(color: Colors.deepOrangeAccent[400], fontFamily: 'Medium', fontSize: 23),
                        ),
                      ),
                      Center(
                        child: Text('we just need your registered email to send you password reset',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Medium',
                                  fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(50),
                  ),
                  formCardForgotPasswordEmail(context),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(350),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text("Reset Password",
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
                          'Back to Login !',
                          style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                              Navigator.pop(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,

                          child: Text('Login',
                            style: TextStyle(
                              color: Color(0xfff79c4f),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
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