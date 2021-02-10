import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/cancel_plan_complete.dart';
import 'package:koompi_hotspot/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

class PlanView extends StatefulWidget {
  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = new TextEditingController();

  void _submitCancelPlan(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      cancelPlan(context);
    }
    else{
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future <void> cancelPlan(BuildContext context) async {
    dialogLoading(context);

    var response = await PostRequest().cancelPlanHotspot(
      _passwordController.text
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CancelPlan()),
            ModalRoute.withName('/navbar'),
          );
        }
        else{
          _passwordController.clear();
          Navigator.of(context).pop();
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.yellow),
                    Text('WARNING', style: TextStyle(fontFamily: 'Poppins-Bold'),),
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
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        }
      
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }

  Future <void> renewPlan(BuildContext context) async {
    dialogLoading(context);

    var response = await PostRequest().renewPlanHotspot(
      _passwordController.text
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CompletePlan()),
            ModalRoute.withName('/navbar'),
          );
        }
        else{
          _passwordController.clear();
          Navigator.of(context).pop();
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.yellow),
                    Text('WARNING', style: TextStyle(fontFamily: 'Poppins-Bold'),),
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
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        }
      
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(_lang.translate('hotspot_plan_appbar'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 38.0, right: 38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  myPlan(context),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(12.0),
          //   topRight: Radius.circular(12.0)
          // ),
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
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: InkWell(
            child: Container(
              // width: ScreenUtil.getInstance().setWidth(330),
              height: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0)
                  ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  _showDialogCancelPlan(context);
                },
                child: Center(
                  child: Text(
                      _lang.translate('unsubscribe'),
                      style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myPlan(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .27, 
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Koompi-WiFi-Icon.png', width: 25),
                    SizedBox(width: 10),
                    Text(
                      _lang.translate('hotspot_plan'),
                      style: GoogleFonts.nunito(
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '${mPlan.balance} SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: Colors.blue[900], fontSize: 30, fontWeight: FontWeight.w700)
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
              padding: EdgeInsets.only(right: 35, left:35),
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
                    '${mPlan.device} ${_lang.translate('devices')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 35, left:35),
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
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 35, left:35),
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
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 35, left:35),
              child: Row(
                children: [
                  Text(
                    '${_lang.translate('valid_until')}:',
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '${mPlan.timeLeft.split(' ').reversed.join(' ')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 1.5,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: EdgeInsets.only(right: 35, left:35),
                child: Row(
                  children: [
                    Icon(Icons.autorenew, color: Colors.blue[700]),
                    Text(
                      '${_lang.translate('auto_renew_every')} ${mPlan.plan} ${_lang.translate('day')}', 
                      style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            mPlan.status == false ? renewButton(context) : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget renewButton(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 35, left:35),
            child: InkWell(
              child: Container(
                // width: ScreenUtil.getInstance().setWidth(330),
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6078ea).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    _showDialogRenewPlan(context);
                  },
                  child: Center(
                    child: Text(
                        _lang.translate('renew'),
                        style: GoogleFonts.nunito(
                        textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
  // Widget plan365DaysButton(BuildContext context){
  //   return Container(
  //     // width: MediaQuery.of(context).size.width,
  //     // height: MediaQuery.of(context).size.height * .27, 
  //     // padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //             color: Colors.black12,
  //             offset: Offset(0.0, 15.0),
  //             blurRadius: 15.0),
  //         BoxShadow(
  //             color: Colors.black12,
  //             offset: Offset(0.0, -10.0),
  //             blurRadius: 10.0),
  //       ],
  //     ),
  //     child: Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(left:15, top: 15),
  //             child: Image.asset(
  //               "assets/images/logo.png",
  //               // height: 100,
  //               // width: 100,
  //               scale: 5,
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           Center(
  //             child: Text(
  //               '600 SEL', 
  //               style: GoogleFonts.nunito(
  //               textStyle: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w700)
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: EdgeInsets.only(right: 25, left:25),
  //             child: Row(
  //               children: [
  //                 Text(
  //                   'Device:', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //                 Expanded(child: Container()),
  //                 Text(
  //                   '2 Devices', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Padding(
  //             padding: EdgeInsets.only(right: 25, left:25),
  //             child: Row(
  //               children: [
  //                 Text(
  //                   'Expire:', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //                 Expanded(child: Container()),
  //                 Text(
  //                   '365 Days', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Padding(
  //             padding: EdgeInsets.only(right: 25, left:25),
  //             child: Row(
  //               children: [
  //                 Text(
  //                   'Speed:', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //                 Expanded(child: Container()),
  //                 Text(
  //                   '5 MB', 
  //                   style: GoogleFonts.nunito(
  //                   textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           Center(
  //             child: InkWell(
  //               child: Container(
  //                 // width: ScreenUtil.getInstance().setWidth(330),
  //                 height: 50,
  //                 decoration: BoxDecoration(

  //                   color: Colors.grey,
  //                   // borderRadius: BorderRadius.circular(12),
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Color(0xFF6078ea).withOpacity(.3),
  //                         offset: Offset(0.0, 8.0),
  //                         blurRadius: 8.0)
  //                   ]),
  //               child: Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   highlightColor: Colors.transparent,
  //                   splashColor: Colors.transparent,
  //                   onTap: () async {

  //                   },
  //                   child: Center(
  //                     child: Text("Subscribe",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontFamily: "Poppins-Bold",
  //                             fontSize: 18,
  //                             letterSpacing: 1.0)),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

   Future<String> _showDialogCancelPlan(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text("Please enter your password"),
            content: Form(
              key: formKey,
              child: TextFormField(
                validator: (val) {
                  if(val.isEmpty) return 'Password is required';
                  if(val.length < 8) return 'Password too short';                
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                onSaved: (val) => _passwordController.text = val,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration( 
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
                obscureText: true,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        dialogLoading(context);
                        _submitCancelPlan();
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

   Future<String> _showDialogRenewPlan(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text("Please enter your password"),
            content: Form(
              key: formKey,
              child: TextFormField(
                validator: (val) {
                  if(val.isEmpty) return 'Password is required';
                  if(val.length < 8) return 'Password too short';                
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                onSaved: (val) => _passwordController.text = val,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration( 
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
                obscureText: true,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        dialogLoading(context);
                        renewPlan(context);
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}