import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class ResetNewPassword extends StatefulWidget {
  final String phone;

  ResetNewPassword(this.phone);
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      _resetPassword();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
  
  Future <void> _resetPassword() async {
    dialogLoading(context);
    var _lang = AppLocalizeService.of(context);
    try {
      String apiUrl = '${ApiService.url}/reset-password-phone';
      setState(() {
        isLoading = true;
      });
      var response = await http.put(Uri.parse(apiUrl),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          "phone": widget.phone,
          "new_password": _confirmPasswordController.text,
        }));

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        await StorageServices().clearToken('token');
        await StorageServices().clearToken('phone');
        await StorageServices().clearToken('password');
        await Components.dialogResetPw(
          context,
          Text(_lang.translate('tf_reset_password'), textAlign: TextAlign.center),
          Text(_lang.translate('complete'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
        );
        Navigator.pop(context);
      } else {
        await Components.dialog(
          context,
          textAlignCenter(text: responseJson['message']),
          warningTitleDialog()
        );
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  void initState(){
    super.initState();
    AppServices.noInternetConnection(globalKey);
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: resetNewPasswordBody(
            context, 
            _passwordController, 
            _confirmPasswordController, 
            _obscureText, 
            _toggle, 
            _obscureText2, 
            _toggle2, 
            _submit, 
            formKey, 
            _autoValidate)
        ),
      )
    );
  }
}
