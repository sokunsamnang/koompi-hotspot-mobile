import 'package:koompi_hotspot/all_export.dart';


  @override
  Widget forgetPasswordBody(
    BuildContext context, 
    String _phone, 
    TextEditingController _phoneController, 
    Function _submitValidate,
    GlobalKey<FormState> formKey, 
    bool _autoValidate) {
    
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
                        child: Text('we just need your registered phone number to send you password reset',
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
                  formCardForgotPasswordPhone(context, _phoneController, _phone, _submitValidate, formKey, _autoValidate),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
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
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onTap: () async {
                            
                            _submitValidate();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Navbar()));
                          },
                          child: Center(
                            child: Text("RESET PASSWORD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "BACK TO LOGIN?",
                          style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => LoginPhone()));
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,

                          child: Text("LOGIN",
                            style: TextStyle(
                              color: Color(0xfff79c4f),
                              fontFamily: "Poppins-Bold")),
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