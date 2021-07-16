import 'package:koompi_hotspot/all_export.dart';

class NotificationModel {
  
  int id;
  String title;
  String category;
  String description;
  String date;
  String image;
  String accId;

  NotificationModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data) {
    id = data['_id'];
    title = data['title'];
    category = data['category'];
    description = data['description'];
    date = data['date'];
    image = data['image'];
    accId = data['accId'];
  }
}

class NotificationProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<NotificationModel> notificationList = [];

  // TrxHistoryProvider() {
  //   fetchTrxHistory();
  // }

  Future<void> fetchNotification() async {
    _backend = Backend();
    _getRequest = GetRequest();
    notificationList = [];

    // Fetch History
    await _getRequest.getNotification().then((value) {
      _backend.listData = json.decode(value.body);
      if (_backend.listData.isEmpty)
        notificationList = null;
      else {
        for (var l in _backend.listData) {
          notificationList.add(NotificationModel(l));
        }
      }
    });

    notifyListeners();
  }
}
