import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget notificationList(BuildContext context) {

  var _lang = AppLocalizeService.of(context);
  // List _buildList(List<NotificationModel> notification, BuildContext context) {
  //   List<Widget> listItems = List();
  //   for (int i = 0; i < notification.length; i++) {
  //     listItems.add(
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           GestureDetector(
  //             onTap: () async {
  //               Navigator.push(
  //                 context, 
  //                 PageTransition(type: PageTransitionType.rightToLeft, 
  //                   child: NotificationDetail(notification: notification, index: i,)));
  //             },
  //             child: Container(
  //               height: 60.0,
  //               color: Colors.white,
  //               child: ListTile(
  //                 leading: Image.asset('assets/images/promotion7.png'),
  //                 title: Text(
  //                   '${notification[i].title}',
  //                   style: GoogleFonts.nunito(
  //                     textStyle: TextStyle(color: Color(0xff0caddb), fontWeight: FontWeight.w900)
  //                   ),
  //                 ),
  //                 trailing: Icon(Icons.arrow_forward_ios_outlined),
  //               ),
  //             ),
  //           ),
  //           Divider(
  //             height: 4.0,
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   return listItems;
  // }

  var notification = Provider.of<NotificationProvider>(context);
  return Scaffold(
    // Have No History
    backgroundColor: Colors.grey[200],
    body: notification.notificationList == null
        ? Container(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/no_notification.svg',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.25,
                    placeholderBuilder: (context) => Center(),
                  ),
                ),
              ),
            ],
          ),
        )

        // Display Loading
        : notification.notificationList.length == 0
            ? Container(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/no_notification.svg',
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        placeholderBuilder: (context) => Center(),
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Display notification list
            : Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: notification.notificationList.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                            context, 
                            PageTransition(type: PageTransitionType.rightToLeft, 
                              child: NotificationDetail(notification: notification.notificationList, index: index,)));
                        },
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            child: Image(
                              image: NetworkImage(
                                "${ApiService.notiImage}/${notification.notificationList[index].image}"
                              )
                            ),
                          ),
                        ),
                        title: Text(
                          notification.notificationList[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.0, color: HexColor('0CACDA'), fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              notification.notificationList[index].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Poppins-Regular'),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  notification.notificationList[index].category,
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                Container(
                                  height: 12.5, 
                                  child: VerticalDivider(color: Colors.black)
                                ),
                                Text(
                                  AppUtils.timeStampToDateTime(notification.notificationList[index].date),
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  );
                }
              ),
            ),
  );
}
