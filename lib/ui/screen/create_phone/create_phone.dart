import 'package:koompi_hotspot/all_export.dart';

class CreatePhone extends StatefulWidget {

  _CreatePhoneState createState() => _CreatePhoneState();
}

class _CreatePhoneState extends State<CreatePhone> {



  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _phone;
  String _password;
  String _confirmPassword;


  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Initially password is obscure2
  bool _obscureText2 = true;

  // Toggles2 the password show status
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      onSignUpByPhone();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future <void> onSignUpByPhone() async {
    var _lang = AppLocalizeService.of(context);
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().signUpWithPhone(
          StorageServices.removeZero(phoneController.text),
          passwordController.text);

        var responseJson = json.decode(response.body);

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context, 
            PageTransition(type: PageTransitionType.rightToLeftWithFade, 
              child: PinCodeVerificationScreen("+855${StorageServices.removeZero(phoneController.text)}", passwordController.text)
            )
          );
        }
        else if (response.statusCode == 401){
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.pop(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.pop(context);
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
        context,
        Text(_lang.translate('error_service')),
        Text(_lang.translate('error')),
      );
      Navigator.pop(context);

      print('not connected');
    }
  }

  // errorDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         var _lang = AppLocalizeService.of(context);
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Icon(Icons.error, color: Colors.red),
  //               Text(_lang.translate('error'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
  //             ],
  //           ),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text(_lang.translate('error_service')),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text(_lang.translate('ok')),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // showErrorServerDialog(BuildContext context) async {
  //   var _lang = AppLocalizeService.of(context);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.error, color: Colors.red),
  //             Text(_lang.translate('error') , style: TextStyle(fontFamily: 'Poppins-Bold'),),
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
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  // }

  // showErrorDialog(BuildContext context) async {
  //   var _lang = AppLocalizeService.of(context);
  //   var response = await PostRequest().signUpWithPhone(
  //     StorageServices.removeZero(phoneController.text),
  //     passwordController.text);
  //   var responseJson = json.decode(response.body);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
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
  //               Text(responseJson['message']),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: createPhoneBody(
            context, 
            phoneController, 
            passwordController, 
            confirmPasswordController,
            _obscureText, 
            _toggle, 
            _obscureText2, 
            _toggle2, 
            _phone, 
            _password,
            _confirmPassword, 
            formKey, 
            _autoValidate, 
            onSignUpByPhone,
            _submit, 
            ),
        ),
      ),
    );
  }
}