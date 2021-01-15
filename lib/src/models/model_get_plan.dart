import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'package:http/http.dart' as http;

class ModelPlan {
  ModelPlan({
    this.username,
    this.balance,
    this.device,
    this.plan
  });

  String username;
  String balance;
  String device;
  String plan;

  factory ModelPlan.fromJson(String str) => ModelPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelPlan.fromMap(Map<String, dynamic> json) => ModelPlan(
        username: json["username"],
        balance: json["balance"],
        device: json["device"],
        plan: json["plan"],
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
    // print("Fetch balance");
    print("My username plan ${mPlan.username}");
    try {
      await _prefService.read('token').then((onValue) async {
        print("Token $onValue");
        http.Response response = await http.get(
            '${ApiService.url}/hotspot/get-plan',
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });
        print("MY data ${response.body}");

        print("MY stastus code ${response.statusCode}");
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

