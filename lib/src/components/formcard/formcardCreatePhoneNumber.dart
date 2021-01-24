import 'package:koompi_hotspot/all_export.dart';

@override
Widget formCardPhoneNumbers(
    BuildContext context,
    TextEditingController phoneController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    bool _obscureText,
    Function _toggle,
    bool _obscureText2,
    Function _toggle2,
    String _phone,
    String _password,
    String _confirmPassword,
    GlobalKey<FormState> formKey,
    Function _submit) {
    
    PhoneNumber number = PhoneNumber(isoCode: 'KH');
    
    return new Container(
      width: double.infinity,
      // height: ScreenUtil.getInstance().setHeight(500),
      padding: EdgeInsets.only(bottom: 1),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text("Create Account",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              ),
              Center(
              child: Text("Create a new account",
                style: TextStyle(
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
                // selectorConfig: SelectorConfig(
                //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                // ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: phoneController,
                formatInput: false,
                keyboardType: TextInputType.phone,
                inputDecoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
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
                validator: (val) {
                  if(val.isEmpty) return 'Password is required';
                  if(val.length < 8) return 'Password too short';    
                  if(val != confirmPasswordController.text) return 'Password does not match'; 
                  return null;
                },
                onSaved: (val) => _password = val,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                obscureText: _obscureText,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              TextFormField(
                validator: (val) {
                  if(val.isEmpty){
                    return 'Password is required';
                  }
                  if(val != passwordController.text){
                    return 'Password does not match';
                  }
                  return null;
                },
                onSaved: (val) => _confirmPassword = val,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: confirmPasswordController,
                obscureText: _obscureText2,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _toggle2();
                    },
                    child: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(75),
              ),
              Center(
                child: InkWell(
                  child: Container(
                    // width: ScreenUtil.getInstance().setWidth(500),
                    height: ScreenUtil.getInstance().setHeight(100),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea)
                        ]),
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
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
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
                                builder: (context) => LoginPhone()),
                            ModalRoute.withName('/loginPhone')  
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
    ),
  );
}
