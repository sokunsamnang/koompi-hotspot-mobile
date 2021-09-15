import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';

import 'package:provider/provider.dart';

class HotspotPlan extends StatefulWidget {
  @override
  _HotspotPlanState createState() => _HotspotPlanState();
}

class _HotspotPlanState extends State<HotspotPlan> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = new TextEditingController();

  void _submitHotspotPlan30Days(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      buyHotspot30days(context);
    }
    else{
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _submitHotspotPlan365Days(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      buyHotspot365days(context);
    }
    else{
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future <void> buyHotspot30days(BuildContext context) async {
    dialogLoading(context);

    var response = await PostRequest().buyHotspotPlan(
      mData.phone,
      _passwordController.text,
      '30',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          await Provider.of<BalanceProvider>(context, listen: false).fetchPortfolio();
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.rightToLeft, 
              child: ChooseOption(),
            ),
            ModalRoute.withName('/navbar'),
          );
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

    var response = await PostRequest().buyHotspotPlan(
      mData.phone,
      _passwordController.text,
      '365',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          await Provider.of<BalanceProvider>(context, listen: false).fetchPortfolio();
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.rightToLeft, 
              child: ChooseOption(),
            ),
            ModalRoute.withName('/navbar'),
          );
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
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(type: PageTransitionType.rightToLeft, 
                child: Navbar(),
              ),
              ModalRoute.withName('/navbar'),
            );
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
      body: WillPopScope(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, left: 28.0, right: 28.0, bottom: 38.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Center(
                    //   child: Text(
                    //     _lang.translate('choose_plan'),
                    //     style: GoogleFonts.nunito(
                    //     textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 30, fontWeight: FontWeight.w700)
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
          ),
        onWillPop: () => Navigator.pushAndRemoveUntil(
          context,
          PageTransition(type: PageTransitionType.rightToLeft, 
            child: Navbar(),
          ),
          ModalRoute.withName('/navbar'),
        ),
      )
    );
  }

  Widget plan30DaysButton(BuildContext context){
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
                '50 SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 30, fontWeight: FontWeight.w700)
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
                    width: MediaQuery.of(context).size.width,
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
                        _showDialog30Days(context);
                      },
                      child: Center(
                        child: Text(
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
                textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 30, fontWeight: FontWeight.w700)
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
                        _showDialog365Days(context);
                      },
                      child: Center(
                        child: Text(
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
  //               obscureText: true,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             Row(
  //               children: <Widget>[
  //                 new FlatButton(
  //                   child: new Text(_lang.translate('cancel'),),
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
  //                     child: new Text(_lang.translate('ok'),))
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: _passwordController,
                validator: (val) {
                  if(val.isEmpty) return _lang.translate('password_is_required_validate');
                  // if(val.length < 6) return _lang.translate('password_too_short_validate');           
                  if(val.length < 6) return _lang.translate('password_is_required_validate');  
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      _submitHotspotPlan30Days(),
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
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: _passwordController,
                validator: (val) {
                  if(val.isEmpty) return _lang.translate('password_is_required_validate');
                  // if(val.length < 6) return _lang.translate('password_too_short_validate');           
                  if(val.length < 6) return _lang.translate('password_is_required_validate');  
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      _submitHotspotPlan365Days(),
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
  //           title: new Text(_lang.translate('enter_password'),),
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
  //                   child: new Text(_lang.translate('cancel'),),
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

}
