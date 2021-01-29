import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class ModelPlan {
  ModelPlan({
    this.username,
    this.balance,
    this.device,
    this.plan,
    this.timeLeft
  });

  String username;
  String balance;
  String device;
  String plan;
  String timeLeft;

  factory ModelPlan.fromJson(String str) => ModelPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelPlan.fromMap(Map<String, dynamic> json) => ModelPlan(
        username: json["username"],
        balance: json["balance"],
        device: json["device"],
        plan: json["plan"],
        timeLeft: json["time_left"]
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "balance": balance,
        "device": device,
        "plan": plan,
      };
}

ModelPlan mPlan = ModelPlan();

class GetPlanProvider with ChangeNotifier {
  StorageServices _prefService = StorageServices();
  String alertText;

  var _mPlan = new ModelPlan();
  ModelPlan get mData => _mPlan;

  Future<String> fetchHotspotPlan() async {
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            '${ApiService.url}/hotspot/get-plan',
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });
        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          // if (mPlan.username != null) mPlan.username;
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

