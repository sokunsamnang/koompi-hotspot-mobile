import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

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
