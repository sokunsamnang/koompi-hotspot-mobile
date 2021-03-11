import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/all_export.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: DefaultTabController(
  //       initialIndex: 0,
  //       length: 2,
  //       child: forgetPasswordBody(context),
  //     ),
  //   );
  // }

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
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordVerification("+855${StorageServices.removeZero(_phoneController.text)}")));
        } 
        else if (response.statusCode == 401){
          Navigator.pop(context);
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          Navigator.pop(context);
          return showErrorServerDialog(context);
        }
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }

  showErrorServerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var _lang = AppLocalizeService.of(context);
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              Text(_lang.translate('error'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_lang.translate('error_server')),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(_lang.translate('ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  showErrorDialog(BuildContext context) async {
    var response = await PostRequest().forgotPasswordByEmail(_phoneController.text);
    var responseJson = json.decode(response.body);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var _lang = AppLocalizeService.of(context);
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.yellow),
              Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(responseJson['message']),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(_lang.translate('ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

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
