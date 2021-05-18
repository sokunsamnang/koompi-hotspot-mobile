import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget notificationList(BuildContext context) {

  var _lang = AppLocalizeService.of(context);
  List _buildList(List<NotificationModel> notification, BuildContext context) {
    List<Widget> listItems = List();
    for (int i = 0; i < notification.length; i++) {
      listItems.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context, 
                  PageTransition(type: PageTransitionType.rightToLeftWithFade, 
                    child: NotificationDetail(notification: notification, index: i,)));
              },
              child: Container(
                height: 60.0,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(
                    '${notification[i].title}',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Color(0xff0caddb), fontWeight: FontWeight.w900)
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            Divider(
              height: 4.0,
            ),
          ],
        ),
      );
    }
    return listItems;
  }

  var notification = Provider.of<NotificationProvider>(context);
  return Scaffold(
    // Have No History
    body: notification.notificationList == null
        ? SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/no_notification.svg',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      placeholderBuilder: (context) => Center(),
                    ),
                  ),
                ),
              ],
            ),
          )

        // Display Loading
        : notification.notificationList.length == 0
            ? SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/no_notification.svg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        placeholderBuilder: (context) => Center(),
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Display notification list
            : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        _buildList(notification.notificationList, context,),
                      ),
                    ),
                  ],
                ),
              ),
  );
}
