import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_list.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // brightness: Brightness.light,
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontFamily: 'Medium'),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: notificationList(context),
      ),
    );
  }
}