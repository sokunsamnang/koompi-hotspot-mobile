import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/utils/language.dart';
import 'package:provider/provider.dart';

class LoginPhone extends StatefulWidget {
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String _email;
  String _password;

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String token;
  String messageAlert;
  bool isLoading = false;

  NetworkStatus _networkStatus = NetworkStatus();
  
  @override
  void initState() {
    internet();
    try {
      print('run version check');
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  void internet() async {
    _networkStatus.connectivityResult = await Connectivity().checkConnectivity();
    _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        _networkStatus.connectivityResult = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _networkStatus.connectivitySubscription.cancel();
    phoneController.dispose();
    passwordController.dispose();
  }

  void _submitLogin(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      login();
    }
    else{
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  //check connection and login
  Future <void> login() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().userLogInPhone(
          StorageServices.removeZero(phoneController.text),
          passwordController.text);
        if (response.statusCode == 200) {
          var responseJson = json.decode(response.body);
          token = responseJson['token'];
            await GetRequest().getUserProfile(token)
              .then((values) {
                setState(() {
                  isLoading = true;
                });

          });
          if(token != null){
            await StorageServices().saveString('token', token);
            await StorageServices().saveString('phone', '0${StorageServices.removeZero(phoneController.text)}');
            await StorageServices().saveString('password', passwordController.text);
            await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
              ModalRoute.withName('/navbar'),
            );
          }
          else {
            Navigator.pop(context);
            try {
              messageAlert = responseJson['error']['message'];
            } catch (e) {
              messageAlert = responseJson['message'];
            }
          }
        } 
        else if (response.statusCode == 401){
          Navigator.pop(context);
          return showErrorDialog(context);
        }
        else if (response.statusCode >= 500 && response.statusCode < 600){
          Navigator.pop(context);
          return showErrorServerDialog(context);
        }
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
      errorDialog(context);
    }
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  errorDialog(BuildContext context) async {
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
                  Text(_lang.translate('error_service')),
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
    var response = await PostRequest().userLogInPhone(
          StorageServices.removeZero(phoneController.text),
          passwordController.text);
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
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
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

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _networkStatus.connectivityResult != ConnectivityResult.none ? Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset("assets/images/image_02.png"),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Icon(Icons.language, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LanguageView()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    SizedBox(
                      width: 150,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Koompi-WiFi-Icon.png')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0),
                      child: formLoginPhone(context, phoneController, passwordController,
                          _obscureText, _toggle, _email, _password, formKey, _submitLogin),
                    ),
                  ],
                ),
              ),
            )
          ],
        ) : _networkStatus.noNetwork(context),
      ),
    );
  }
}
