import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class GetPlanProvider with ChangeNotifier {
  StorageServices _prefService = StorageServices();
  String alertText;

  var _mPlan = new ModelPlan();
  ModelPlan get mData => _mPlan;

  Future<String> fetchHotspotPlan() async {
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            Uri.parse('${ApiService.url}/hotspot/get-plan'),
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });
        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          mPlan = ModelPlan.fromMap(responseBody);
        } else {
          mPlan = ModelPlan();
          alertText = response.body;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return alertText ?? '';
  }
}
