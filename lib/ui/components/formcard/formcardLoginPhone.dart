import 'package:koompi_hotspot/all_export.dart';

@override
Widget formLoginPhone( BuildContext context, 
                  TextEditingController phoneController,
                  TextEditingController passwordController,
                  bool _obscureText, 
                  Function _toggle, 
                  String _email, 
                  String _password,
                  GlobalKey<FormState> formKey,
                  Function _submitLogin) {

  PhoneNumber number = PhoneNumber(isoCode: 'KH');
  var _lang = AppLocalizeService.of(context);
  return Container(
    width: double.infinity,
    //  height: ScreenUtil.getInstance().setHeight(500),
    padding: EdgeInsets.only(bottom: 1),
    // decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(8.0),
    //     boxShadow: [
    //       BoxShadow(
    //           color: Colors.black12,
    //           offset: Offset(0.0, 15.0),
    //           blurRadius: 15.0),
    //       BoxShadow(
    //           color: Colors.black12,
    //           offset: Offset(0.0, -10.0),
    //           blurRadius: 10.0),
    //     ]),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(_lang.translate('welcome_back'),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(45),
                  fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
            ),
            Center(
              child: Text(_lang.translate('sign_in_to_continue'),
                style: TextStyle(
                  // fontSize: ScreenUtil().setSp(45),
                  // fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
            InternationalPhoneNumberInput(
              countries: ['KH'],
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              errorMessage: _lang.translate('invalid_phone_number_validate'),
              // selectorConfig: SelectorConfig(
              //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              // ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: phoneController,
              formatInput: false,
              keyboardType: TextInputType.number,
              inputDecoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('phone_number_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
              ),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            TextFormField(
              controller: passwordController,
              validator: (val) {
                if(val.isEmpty) return _lang.translate('password_is_required_validate');
                if(val.length < 6) return _lang.translate('password_too_short_validate');           
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (val) => _password = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('password_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                prefixIcon: Icon(Icons.vpn_key_sharp, color: primaryColor),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, color: primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context, 
                      PageTransition(type: PageTransitionType.bottomToTop, 
                        child: ForgotPassword()
                      )
                    ).then((value) {
                      phoneController.clear();
                      passwordController.clear();
                      }
                    );
                  },
                  child: Text(
                    _lang.translate('forgot_password_bt'),
                    style: TextStyle(
                        color: Color(0xFF5d74e3),
                        fontFamily: "Poppins-Bold",
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
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
                      _submitLogin();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Navbar()));
                    },
                    child: Center(
                      child: Text(_lang.translate('sign_in_bt'),
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
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _lang.translate('dont_have_an_account'),
                  style: TextStyle(fontFamily: "Poppins-Medium"),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context, 
                      PageTransition(type: PageTransitionType.bottomToTop, 
                        child: CreatePhone()
                      )
                    ).then((value) {
                      phoneController.clear();
                      passwordController.clear();
                      }
                    );
                  },
                  child: Text(_lang.translate('sign_up_bt'),
                      style: TextStyle(
                          color: Color(0xFF5d74e3),
                          fontFamily: "Poppins-Bold")),
                )
              ],
            )
          ],
        ),
      )
    ),
  );
}
