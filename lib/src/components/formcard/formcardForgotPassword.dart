import 'package:koompi_hotspot/all_export.dart';

@override
Widget formCardForgotPasswordPhone(
  BuildContext context, 
  TextEditingController _phoneController, 
  String _phone,
  Function _submit,
  GlobalKey<FormState> formKey, 
  bool _autoValidate) {

  PhoneNumber number = PhoneNumber(isoCode: 'KH');
  return new Container(
    width: double.infinity,
//      height: ScreenUtil.getInstance().setHeight(500),
    // padding: EdgeInsets.only(bottom: 1),
    // decoration: BoxDecoration(color: Colors.white, boxShadow: [
    //   BoxShadow(
    //       color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0),
    //   BoxShadow(
    //       color: Colors.black12, offset: Offset(0.0, -10.0), blurRadius: 10.0),
    // ]),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: _phoneController,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
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
          ],
        ),
      )
    ),
  );
}
