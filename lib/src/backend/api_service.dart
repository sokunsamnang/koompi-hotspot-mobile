import 'package:connectivity/connectivity.dart';
import 'package:koompi_hotspot/src/components/noInternet.dart';

class ApiService{

  static final url = 'https://api-hotspot.koompi.org/api';



}

class ApiHeader {

   static const headers = <String, String>{
    "accept": "application/json",
    "Content-Type": "application/json"
  };
  
}

class AppService{

  static void noInternetConnection() async {
    try {
      Connectivity _connectivity = new Connectivity();
      final myResult = await _connectivity.checkConnectivity();
      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          print('no internet');
          NoInterntConnection();
        } else {
          return null;
        }
      });
      if (myResult == ConnectivityResult.none) {
        NoInterntConnection();
      }
    } catch (e) {}
  }

}