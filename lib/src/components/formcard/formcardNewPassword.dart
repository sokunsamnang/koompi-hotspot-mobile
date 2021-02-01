import 'package:koompi_hotspot/all_export.dart';

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

    var _lang = AppLocalizeService.of(context);
  return new Container(
    width: double.infinity,
//      height: ScreenUtil.getInstance().setHeight(500),
    padding: EdgeInsets.only(bottom: 1),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_lang.translate('new_password_tf'),
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                validator: (val) {
                  if(val.isEmpty) return _lang.translate('password_is_required_validate');
                  if(val.length < 8) return _lang.translate('password_too_short_validate');
                  if(val != _confirmPasswordController.text) return _lang.translate('password_does_not_match_validate');
                  return null;
                },
                onSaved: (val) => _passwordController.text = val,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
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
                  hintText: _lang.translate('new_password_tf'),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(_lang.translate('new_confirm_password_tf'),
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              TextFormField(
                validator: (val) {
                  if(val.isEmpty) return _lang.translate('password_is_required_validate');
                  if(val.length < 8) return _lang.translate('password_too_short_validate');
                  if(val != _passwordController.text) return _lang.translate('password_does_not_match_validate');
                  return null;
                },
                onSaved: (val) => _passwordController.text = val,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _confirmPasswordController,
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
                  hintText: _lang.translate('new_password_tf'),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
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
