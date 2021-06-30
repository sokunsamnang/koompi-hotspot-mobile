import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/core/services/jtw_decoder.dart';
import 'package:provider/provider.dart';

class StorageServices{

  // static String _decode;
  // static SharedPreferences _preferences;
  // bool status;
  
  static String removeZero(String number){
    if (number.startsWith("0")){
      number = number.replaceRange(0, 1, '');
    }
    return number;
  }

  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }

  checkUser(BuildContext context) async {
    SharedPreferences isToken = await SharedPreferences.getInstance();
    String token = isToken.getString('token');

    if(JwtDecoder.isExpired(token) == true || token == null){
      print('token expired');
      clearToken('token'); 
      Navigator.pushAndRemoveUntil(
        context, 
        PageTransition(type: PageTransitionType.bottomToTop, 
          child: LoginPhone(),
        ),
        ModalRoute.withName('/loginPhone'),
      );

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPhone()),
      //   ModalRoute.withName('/loginPhone'),
      // );
    }
    else if (JwtDecoder.isExpired(token) == false ) {
      print('token not expire');
      await GetRequest().getUserProfile(token).then((value) async{
        try{
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          await Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
          // await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio(context); 
          // await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory(); 
        }
        catch (e){
          print(e.toString());
        }
      });
      
      Navigator.pushAndRemoveUntil(
        context, 
        PageTransition(type: PageTransitionType.rightToLeft, 
          child: Navbar(),
        ),
        ModalRoute.withName('/navbar'),
      );

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => Navbar()),
      //   ModalRoute.withName('/navbar'),
      // );
    }
    else{
      Navigator.pushAndRemoveUntil(
        context, 
        PageTransition(type: PageTransitionType.bottomToTop, 
          child: LoginPhone(),
        ),
        ModalRoute.withName('/loginPhone'),
      );
      
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPhone()),
      //   ModalRoute.withName('/loginPhone'),
      // );
    }
  }

  
  void updateUserData(BuildContext context) {
    read('token').then(
      (value) async {
        String _token = value;
        if (_token != null) {
          await GetRequest().getUserProfile(_token);
          
          Navigator.pushAndRemoveUntil(
            context, 
            PageTransition(type: PageTransitionType.bottomToTop, 
              child: Navbar(),
            ),
            ModalRoute.withName('/navbar'),
          );

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => Navbar()),
          //   ModalRoute.withName('/navbar'),
          // );
        }
      },
    );
  }
  

  Future<String> read(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String value = pref.getString(key);
    return value;
  }

  Future<void> saveString(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<void> clearToken(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
  
}


