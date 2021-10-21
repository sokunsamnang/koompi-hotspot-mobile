import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/reuse_widget/reuse_widget.dart';




class PinCodeVerificationScreen extends StatefulWidget {
  final String phone, password;

  PinCodeVerificationScreen(this.phone, this.password);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;
  
  bool isLoading = false;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Future<void> _submitOtp(String vCode) async {
    var _lang = AppLocalizeService.of(context);

    dialogLoading(context);
    try {
      String apiUrl = '${ApiService.url}/auth/confirm-phone';
      setState(() {
        isLoading = true;
      });
      var response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          "phone": widget.phone,
          "vCode": vCode,
        }));

      var responseJson = json.decode(response.body);

        if (response.statusCode == 200 && response.body != "Incorrect Code!") {
          print(response.body);
          await Navigator.pushReplacement(
            context, 
            PageTransition(type: PageTransitionType.rightToLeft, 
              child: CompleteInfo(widget.phone),
            ),
          );
        } else {
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.of(context).pop();
          print(response.body);
      }
    } 
    on SocketException catch(_){
      print('No network socket exception');
      await Components.dialog(
        context,
        textAlignCenter(text: _lang.translate('no_internet_message')),
        warningTitleDialog()
      );
      Navigator.of(context).pop();
    }
    on TimeoutException catch(_) {
      print('Time out exception');
      await Components.dialog(
        context,
        textAlignCenter(text: _lang.translate('request_timeout')),
        warningTitleDialog()
      );
      Navigator.of(context).pop();
    }
    on FormatException catch(_){
      print('FormatException');
      await Components.dialog(
        context,
        textAlignCenter(text: _lang.translate('server_error')),
        warningTitleDialog()
      );
      Navigator.of(context).pop();
    }
  }

  // showErrorDialog(BuildContext context) async {
  //   var _lang = AppLocalizeService.of(context);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.warning, color: Colors.yellow),
  //             Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold')),
  //           ],
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(_lang.translate('wrong_code')),
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
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/animations/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _lang.translate('phone_number_verification'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: _lang.translate('enter_the_code_sent_to'),
                      children: [
                        TextSpan(
                            text: widget.phone,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 6) {
                          return _lang.translate('verify_validate');
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter> [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) {
                        _submitOtp(currentText);
                        print("Completed");              
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? _lang.translate('please_fill_up_all_the_cells_properly_validate') : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //       text: "Didn't receive the code? ",
              //       style: TextStyle(color: Colors.black54, fontSize: 15),
              //       children: [
              //         TextSpan(
              //             text: " RESEND",
              //             recognizer: onTapRecognizer,
              //             style: TextStyle(
              //                 color: Color(0xFF91D3B3),
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16))
              //       ]),
              // ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      formKey.currentState.validate();
                      // conditions for validating
                      if (currentText.length != 6) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        await _submitOtp(currentText);
                        // setState(() {
                        //   hasError = false;
                        //   scaffoldKey.currentState.showSnackBar(SnackBar(
                        //     content: Text("Aye!!"),
                        //     duration: Duration(seconds: 2),
                        //   ));
                        // });
                      }
                    },
                    child: Center(
                      child: Text(
                        _lang.translate('verify_bt'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text("Clear"),
              //       onPressed: () {
              //         textEditingController.clear();
              //       },
              //     ),
              //     // FlatButton(
              //     //   child: Text("Set Text"),
              //     //   onPressed: () {
              //     //     textEditingController.text = "123456";
              //     //   },
              //     // ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}