import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class BalanceProvider with ChangeNotifier {
  Backend _backend;

  List<BalanceModel> balanceList = [];

  Future<void> fetchPortfolio() async {
    StorageServices _prefService = StorageServices();

    _backend = Backend();
    balanceList = [];

    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            Uri.parse('${ApiService.url}/selendra/portfolio'),
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          _backend.listData = responseBody;
          for (var l in _backend.listData) {
            balanceList.add(BalanceModel(l));
          }
        } else {
          var responseBody = json.decode(response.body);
          print(responseBody);
          return responseBody;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
