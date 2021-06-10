import 'package:koompi_hotspot/all_export.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _phoneController = TextEditingController();
  String _phone = "";

  void _submitValidate(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      _submit();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future <void> _submit() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().forgotPasswordByPhone(
          StorageServices.removeZero(_phoneController.text),);

        var responseJson = json.decode(response.body);
        
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context, 
            PageTransition(type: PageTransitionType.rightToLeft, 
              child: ForgotPasswordVerification("+855${StorageServices.removeZero(_phoneController.text)}")
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
      Navigator.pop(context);
      print('not connected');
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
  //   var response = await PostRequest().forgotPasswordByPhone(_phoneController.text);
  //   var responseJson = json.decode(response.body);
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: forgetPasswordBody(
            context, 
            _phone, 
            _phoneController, 
            _submitValidate, 
            formKey, 
            _autoValidate),
        ),
      ),
    );
  }
}
