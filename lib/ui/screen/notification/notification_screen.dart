import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_list.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _lang.translate('notifications'),
          style: TextStyle(color: Colors.black, fontFamily: 'Medium'),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
        },
        child: Container(
          child: notificationList(context),
        ),
      ),
    );
  }
}
