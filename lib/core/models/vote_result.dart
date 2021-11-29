import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class VoteResult {
  VoteResult({
    this.id,
    this.voted,
    this.votedType,
    this.adsId,
  });

  String id;
  bool voted;
  String votedType;
  String adsId;

  factory VoteResult.fromJson(String str) => VoteResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VoteResult.fromMap(Map<String, dynamic> json) => VoteResult(
    id: json['user_id'],
    voted: json['voted'],
    adsId: json['ads_id'],
    votedType: json['voted_type'],
  );

  Map<String, dynamic> toMap() => {
    "user_id": id,
    "voted": voted,
    "ads_id": adsId,
    "voted_type": votedType,
  };
}


VoteResult voteResult = VoteResult();

class VoteResultProvider with ChangeNotifier {
   StorageServices _prefService = StorageServices();
  String alertText;

  var _voteResult = new VoteResult();

  VoteResult get mData => _voteResult;

  Future<String> fetchVoteResult(int id) async {
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            Uri.parse('${ApiService.url}/ads/get-voted/$id'),
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });
        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          // if (mPlan.username != null) mPlan.username;
          voteResult = VoteResult.fromMap(responseBody);

        } else {
          voteResult = VoteResult();
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
