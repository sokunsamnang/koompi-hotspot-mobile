import 'package:koompi_hotspot/all_export.dart';

class NotificationProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<NotificationModel> notificationList = [];

  Future<void> fetchNotification() async {
    _backend = Backend();
    _getRequest = GetRequest();
    notificationList = [];

    // Fetch Notification
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
