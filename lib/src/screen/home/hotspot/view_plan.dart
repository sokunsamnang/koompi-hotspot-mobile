import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/change_plan.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/renew_option.dart';
import 'package:provider/provider.dart';

class PlanView extends StatefulWidget {
  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = new TextEditingController();

  void _submitRenewPlan(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      renewPlan();
    }
    else{
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future <void> renewPlan() async {
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/appbar_logo.png",
          scale: 2,
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeHotspotPlan()),
                  );
                },
                child: Center(
                  child: Text(
                      _lang.translate('change_plan'),
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
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RenewOption())
        );
      },
      child: Container(
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
          SizedBox(height: 20),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width / 0.25,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/Koompi-WiFi-Icon.png', scale: 50,),
                          SizedBox(width: 10),
                          Text(
                            _lang.translate('hotspot_plan'),
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.more_vert), 
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RenewOption())
                            );
                          }
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              '${mPlan.balance} SEL', 
              style: GoogleFonts.nunito(
              textStyle: TextStyle(color: Colors.blue[900], fontSize: 23, fontWeight: FontWeight.w700)
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
                  textStyle: TextStyle(color: Colors.black, fontSize: 16)
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
                  '${mPlan.plan} ${_lang.translate('day')}', 
                  style: GoogleFonts.nunito(
                  textStyle: TextStyle(color: Colors.black, fontSize: 16, )
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
                  textStyle: TextStyle(color: Colors.black, fontSize: 16)
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
                  textStyle: TextStyle(color: Colors.black, fontSize: 16)
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
                  mPlan.automatically == true
                  ?
                  Icon(Icons.autorenew, color: Colors.blue[700])
                  :
                  Icon(Icons.touch_app_sharp, color: Colors.blue[700]),

                  mPlan.automatically == true 
                  ? 
                  Text(
                    '${_lang.translate('auto_renew_every')} ${mPlan.plan} ${_lang.translate('day')}', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)
                    ),
                  ) 
                  : 
                  Text(_lang.translate('manual_renew'),
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          mPlan.automatically == false && mPlan.status == false ? renewButton(context) : Container(),
          ],
        ),
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

  Future<String> _showDialogRenewPlan(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text(_lang.translate('enter_password')),
            content: Form(
              key: formKey,
              child: TextFormField(
                validator: (val) {
                  if(val.isEmpty) return _lang.translate('password_is_required_validate');
                  if(val.length < 8) return _lang.translate('password_too_short_validate');           
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                onSaved: (val) => _passwordController.text = val,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration( 
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: _lang.translate('password_tf'),
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
                    child: new Text(_lang.translate('cancel'),),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        dialogLoading(context);
                        _submitRenewPlan();
                        Navigator.of(context).pop();
                      },
                      child: new Text(_lang.translate('ok'),))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}