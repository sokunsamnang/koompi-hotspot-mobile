import 'package:koompi_hotspot/all_export.dart';
import 'package:provider/provider.dart';

class ChangeHotspotPlan extends StatefulWidget {
  @override
  _ChangeHotspotPlanState createState() => _ChangeHotspotPlanState();
}

class _ChangeHotspotPlanState extends State<ChangeHotspotPlan> {
  // final formKey = GlobalKey<FormState>();
  // AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = new TextEditingController();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future <void> buyHotspot30days(BuildContext context) async {
    dialogLoading(context);

    var response = await PostRequest().changePlanHotspot(
      _passwordController.text,
      '30',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Future.delayed(Duration(seconds: 2), () async{
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              PageTransition(type: PageTransitionType.rightToLeft, 
                child: CompletePlan(),
              ),
              ModalRoute.withName('/navbar'),
            ));
          });
        }
        else{
          _passwordController.clear();
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
        textAlignCenter(text: 'Something may went wrong with your internet connection. Please try again!!!'),
        warningTitleDialog()
      );
      Navigator.pop(context);
    }
  }

  Future <void> buyHotspot365days(BuildContext context) async {
     dialogLoading(context);

    var response = await PostRequest().changePlanHotspot(
      _passwordController.text,
      '365',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Future.delayed(Duration(seconds: 2), () async{
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              PageTransition(type: PageTransitionType.rightToLeft, 
                child: CompletePlan(),
              ),
              ModalRoute.withName('/navbar'),
            ));
          });
        }
        else{
          _passwordController.clear();
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
        textAlignCenter(text: 'Something may went wrong with your internet connection. Please try again!!!'),
        warningTitleDialog()
      );
      Navigator.pop(context);
    }
  }


  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  void initState() {
    super.initState();
    AppServices.noInternetConnection(globalKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
        // title: Image.asset(
        //   "assets/images/appbar_logo.png",
        //   scale: 2,
        // ),
        title: Text('Choose a Plan', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0, bottom: 38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Center(
                  //   child: Text(
                  //     _lang.translate('choose_plan'),
                  //     style: GoogleFonts.nunito(
                  //     textStyle: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.w700)
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 25.0),
                  plan30DaysButton(context),
                  SizedBox(height: 50.0),
                  plan365DaysButton(context),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget plan30DaysButton(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                '50 SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.w700)
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('device')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '2 ${_lang.translate('devices')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('speed')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '5 ${_lang.translate('mb')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16,)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('expire')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '30 ${_lang.translate('day')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16,)
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: InkWell(
                  child: Container(
                    // width: ScreenUtil.getInstance().setWidth(330),
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6078ea).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        if(mPlan.plan == '30'){
                          return null;
                        }
                        else{
                          mPlan.status == false 
                          ? 
                          _showDialog30Days(context) 
                          : 
                          await Components.dialog(
                            context,
                            textAlignCenter(text: _lang.translate('in_use_plan')),
                            warningTitleDialog()
                          );
                        }
                      },
                      child: Center(
                        child: mPlan.plan == '30' ? Text(
                            _lang.translate('in_use'), 
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                            ),
                          )
                          :
                          Text(
                            _lang.translate('subscribe'), 
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ],
    ),
    );
  }

  Widget plan365DaysButton(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .27, 
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                '600 SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.w700)
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('device')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '2 ${_lang.translate('devices')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16,)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('speed')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '5 ${_lang.translate('mb')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16,)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('expire')}:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '365 ${_lang.translate('day')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16,)
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: InkWell(
                  child: Container(
                    // width: ScreenUtil.getInstance().setWidth(330),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                      // borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      onTap: () async {
                        if(mPlan.plan == '365'){
                          return null;
                        }
                        else{
                          mPlan.status == false 
                          ? 
                          _showDialog365Days(context) 
                          : 
                          await Components.dialog(
                            context,
                            textAlignCenter(text: _lang.translate('in_use_plan')),
                            warningTitleDialog()
                          );
                        }
                      },
                      child: Center(
                        child: mPlan.plan == '365' ? Text(
                            _lang.translate('in_use'), 
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                            ),
                          )
                          :
                          Text(
                            _lang.translate('subscribe'), 
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ],
    ),
    );
  }

  Future<void> _showDialog30Days(BuildContext context) async {

    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text('Enter password', textAlign: TextAlign.center,),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('password_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
              ),
              obscureText: true,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text('CANCEL'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _passwordController.clear(),
                    }
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text('OK'),
                    onPressed: () => {
                      dialogLoading(context),
                      buyHotspot30days(context),
                      Navigator.of(context).pop(),
                    }
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDialog365Days(BuildContext context) async {

    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text('Enter password', textAlign: TextAlign.center,),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('password_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
              ),
              obscureText: true,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text('CANCEL'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _passwordController.clear(),
                    }
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text('OK'),
                    onPressed: () => {
                      dialogLoading(context),
                      buyHotspot365days(context),
                      Navigator.of(context).pop(),
                    }
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<String> _showDialog30Days(BuildContext context){
  //   var _lang = AppLocalizeService.of(context);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child:AlertDialog(
  //           title: new Text(_lang.translate('enter_password')),
  //           content: Form(
  //             key: formKey,
  //             child: TextFormField(
  //               validator: (val) {
  //                 if(val.isEmpty) return _lang.translate('password_is_required_validate');
  //                 if(val.length < 6) return _lang.translate('password_too_short_validate');            
  //                 return null;
  //               },
  //               autovalidateMode: AutovalidateMode.onUserInteraction,
  //               controller: _passwordController,
  //               onSaved: (val) => _passwordController.text = val,
  //               keyboardType: TextInputType.visiblePassword,
  //               decoration: InputDecoration(
  //                 fillColor: Colors.grey[100],
  //                 filled: true,
  //                 hintText: _lang.translate('password_tf'),
  //                 hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.black),
  //                   borderRadius: BorderRadius.all(Radius.circular(12.0))
  //                 ),
  //               ),
  //               obscureText: _obscureText,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             Row(
  //               children: <Widget>[
  //                 new FlatButton(
  //                   child: new Text(_lang.translate('cancel')),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     _passwordController.clear(); 
  //                   },
  //                 ),
  //                 new FlatButton(
  //                     onPressed: () {
  //                       // Navigator.of(context).pop();
  //                       dialogLoading(context);
  //                       _submitHotspotPlan30Days();
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: new Text(_lang.translate('ok')))
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<String> _showDialog365Days(BuildContext context) {
  //   var _lang = AppLocalizeService.of(context);
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child:AlertDialog(
  //           title: new Text(_lang.translate('enter_password')),
  //           content: Form(
  //             key: formKey,
  //             child: TextFormField(
  //               validator: (val) {
  //                 if(val.isEmpty) return _lang.translate('password_is_required_validate');
  //                 if(val.length < 6) return _lang.translate('password_too_short_validate');                
  //                 return null;
  //               },
  //               autovalidateMode: AutovalidateMode.onUserInteraction,
  //               controller: _passwordController,
  //               onSaved: (val) => _passwordController.text = val,
  //               keyboardType: TextInputType.visiblePassword,
  //               decoration: InputDecoration(
  //                 fillColor: Colors.grey[100],
  //                 filled: true,
  //                 hintText: _lang.translate('password_tf'),
  //                 hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.black),
  //                   borderRadius: BorderRadius.all(Radius.circular(12.0))
  //                 ),
  //               ),
  //               obscureText: true,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             Row(
  //               children: <Widget>[
  //                 new FlatButton(
  //                   child: new Text(_lang.translate('cancel')),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     _passwordController.clear(); 
  //                   },
  //                 ),
  //                 new FlatButton(
  //                     onPressed: () {
  //                       dialogLoading(context);
  //                       _submitHotspotPlan365Days();
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: new Text(_lang.translate('ok')))
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // _showAlreadyBoughtPlanDialog(context) async {
  //   var _lang = AppLocalizeService.of(context);
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
  //               Text(_lang.translate('in_use_plan')),
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
  //     }
  //   );
  // }
}

