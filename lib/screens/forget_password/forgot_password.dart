import 'package:koompi_hotspot/all_export.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _phoneController = TextEditingController();
  String _phone = "";

  @override 
  void initState(){
    super.initState();
    AppServices.noInternetConnection(globalKey);
  }

  @override
  void dispose(){
    super.dispose();
  }
  
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

    var _lang = AppLocalizeService.of(context);

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
          Navigator.of(context).pop();
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
        context,
        textAlignCenter(text: _lang.translate('no_internet_message')),
        warningTitleDialog()
      );
      Navigator.of(context).pop();
    }
  }

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
