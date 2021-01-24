import 'package:koompi_hotspot/all_export.dart';

  @override
  Widget createEmailBody(
    BuildContext context, 
    TextEditingController emailController, 
    TextEditingController passwordController, 
    TextEditingController confirmPasswordController,
    bool _obscureText,
    Function _toggle,
    bool _obscureText2,
    Function _toggle2,
    String _email,
    String _password,
    String _confirmPassword,
    GlobalKey formKey,
    bool _autoValidate,
    Function onSignUpByEmail,
    Function _submit,
    ) {

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
              Image.asset("assets/images/image_02.png"),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Image.asset(
                    "assets/images/logo.png",
                    // width: ScreenUtil.getInstance().setWidth(500),
                    // height: ScreenUtil.getInstance().setHeight(300),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(100)),
                  formCardEmail(
                    context, 
                    emailController, 
                    passwordController, 
                    confirmPasswordController,
                    _obscureText, 
                    _toggle, 
                    _obscureText2, 
                    _toggle2, 
                    _email, 
                    _password, 
                    _confirmPassword,
                    formKey, 
                    _autoValidate,
                    _submit
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }