import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/core/models/vote_result.dart';
import 'package:koompi_hotspot/ui/screen/notification/announcements/announcements_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget announcementsList(BuildContext context) {
  var notification = Provider.of<NotificationProvider>(context);
  return Scaffold(
    // Have No History
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
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () async {
                            dialogLoading(context);
                            await Provider.of<VoteResultProvider>(context,
                                    listen: false)
                                .fetchVoteResult(
                                    notification.notificationList[index].id);
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: AnnouncementsDetail(
                                      notification:
                                          notification.notificationList,
                                      index: index,
                                    )));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              child: Image(
                                  image: NetworkImage(
                                      "${ApiService.notiImage}/${notification.notificationList[index].image}")),
                            ),
                          ),
                          title: Text(
                            notification.notificationList[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: HexColor('0CACDA'),
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                notification
                                    .notificationList[index].description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    notification
                                        .notificationList[index].category,
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                  Container(
                                      height: 12.5,
                                      child:
                                          VerticalDivider(color: Colors.black)),
                                  Text(
                                    AppUtils.timeStampToDate(notification
                                        .notificationList[index].date),
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
  );
}
