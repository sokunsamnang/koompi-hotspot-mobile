import 'package:koompi_hotspot/all_export.dart';

@override
Widget resetNewPasswordBody(
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
      var _lang = AppLocalizeService.of(context);
      ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
      ScreenUtil.instance =
      ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
  return new Scaffold(
    backgroundColor: Colors.white,
    resizeToAvoidBottomInset: true,
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
                      child: Image.asset("assets/images/security.png"),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Center(
                      child: Text(
                        _lang.translate('new_password_tx'),
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Medium',
                            fontSize: 19),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(50),
                ),
                formCardNewPassword(
                    context,
                    _passwordController,
                    _confirmPasswordController,
                    _obscureText,
                    _toggle,
                    _obscureText2,
                    _toggle2,
                    _submit,
                    formKey,
                    _autoValidate),
                SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
                Center(
                  child: InkWell(
                    child: Container(
                      // width: ScreenUtil.getInstance().setWidth(500),
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
                          onTap: () {
                            _submit();
                          },
                          child: Center(
                            child: Text(_lang.translate('change_password_bt'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
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
