import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';


class CreateEmail extends StatefulWidget {

  _CreateEmailState createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {



  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _email;
  String _password;
  String _confirmPassword;

  final TextEditingController emailController = new TextEditingController();
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
      onSignUpByEmail();
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

  Future <void> onSignUpByEmail() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().signUpWithEmail(
          emailController.text,
          passwordController.text);
        if (response.statusCode == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PinCodeVerificationScreen(emailController.text, passwordController.text)));
          // print(response.statusCode);
          // var responseJson = json.decode(response.body);    
          // if(response.body == 'Please check your E-mail!'){
          //   print(response.statusCode);
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => VerificationAccount()));
          // }
          // else {
          //   try {
          //     messageAlert = responseJson['error']['message'];
          //   } catch (e) {
          //     messageAlert = responseJson['message'];
          //   }
          // }
        } 
        else if (response.statusCode == 401){
          Navigator.pop(context);
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode <600){
          Navigator.pop(context);
          return showErrorServerDialog(context);
        }
        // else {
        //   print('Login not Successful');
        //   return _submit();
        // }
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
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Error server or Server in maintenance'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Invalid Email'),
                // Text(responseJson['message']),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  // showErrorServerDialog(BuildContext context) async {
  //   var response = await PostRequest().register(
  //         emailController.text,
  //         passwordController.text);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('${response.body}'),
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

  // errorDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text('Error Services'),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
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
          child: createEmailBody(
            context, 
            emailController, 
            passwordController, 
            confirmPasswordController,
            _obscureText, 
            _toggle, 
            _obscureText2, 
            _toggle2, 
            _email, 
            _password,
            _confirmPassword, 
            formKey, 
            _autoValidate, 
            onSignUpByEmail,
            _submit, 
            ),
        ),
      ),
    );
  }
}