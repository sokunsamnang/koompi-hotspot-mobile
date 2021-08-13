import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/option_page/flag_language.dart';
import 'package:provider/provider.dart';

class LoginPhone extends StatefulWidget {
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String token;
  String messageAlert;
  bool isLoading = false;
  
  @override
  void initState() {
    AppServices.noInternetConnection(globalKey);
    try {
      print('run version check');
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          
        var responseJson = json.decode(response.body);

        if (response.statusCode == 200) {
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
            // await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio(context);
            // await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory(); 
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
            await Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(type: PageTransitionType.rightToLeft, 
                child: Navbar(),
              ),
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
          
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.pop(context);
        }
        else if (response.statusCode >= 500 && response.statusCode < 600){

          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.pop(context);
        }
      }
    } 
    on SocketException catch(_){
      print('No network socket exception');
      await Components.dialog(
        context,
        textAlignCenter(text: 'Something went wrong with your internet connection. Please try again later!!!'),
        warningTitleDialog()
      );
    }
    on TimeoutException catch(_) {
      print('Time out exception');
      await Components.dialog(
        context,
        textAlignCenter(text: 'Request Timeout. Please try again later!!!'),
        warningTitleDialog()
      );
    }
    on FormatException catch(_){
      print('FormatException');
      await Components.dialog(
        context,
        textAlignCenter(text: 'Something went wrong or Server in maintenance. Please try again later!!!'),
        warningTitleDialog()
      );
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
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
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
                      child: TextButton(
                        child: Icon(Icons.language, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context, 
                            PageTransition(type: PageTransitionType.rightToLeft, 
                              child: LanguageView()
                            )
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
        ),
      ),
    );
  }
}
