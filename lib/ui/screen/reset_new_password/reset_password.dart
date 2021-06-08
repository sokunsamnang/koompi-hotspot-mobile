import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class ResetNewPassword extends StatefulWidget {
  final String phone;

  ResetNewPassword(this.phone);
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {

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

  // showChangePasswordDialog(context) async {
  //   var _lang = AppLocalizeService.of(context);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: AlertDialog(
  //           title: Text(
  //             _lang.translate('complete'),
  //             textAlign: TextAlign.center,
  //           ),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text(_lang.translate('tf_reset_password')),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text(_lang.translate('ok')),
  //               onPressed: () async {
  //                 dialogLoading(context);
  //                 Future.delayed(Duration(seconds: 2), () {
  //                   Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => LoginPhone()),
  //                     ModalRoute.withName('/loginPhone'),
  //                   ));
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   );
  // }
  
  Future <void> _resetPassword() async {
    dialogLoading(context);
    var _lang = AppLocalizeService.of(context);
    try {
      String apiUrl = '${ApiService.url}/reset-password-phone';
      setState(() {
        isLoading = true;
      });
      var response = await http.put(apiUrl,
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

  // showErrorServerDialog(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       var _lang = AppLocalizeService.of(context);
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.error, color: Colors.red),
  //             Text(_lang.translate('error'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
  //           ],
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(_lang.translate('error_server')),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text(_lang.translate('ok')),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  // }

  // showErrorDialog(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       var _lang = AppLocalizeService.of(context);
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.warning, color: Colors.yellow),
  //             Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
  //           ],
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Something went wrong, Please try again.'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text(_lang.translate('ok')),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  // }



  Widget build(BuildContext context) {
    return Scaffold(
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
