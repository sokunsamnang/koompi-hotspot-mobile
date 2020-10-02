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

