import 'package:flutter/material.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/promotion/promotion_detail.dart';
import 'package:provider/provider.dart';

class PromotionCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var notification = Provider.of<NotificationProvider>(context);

    return Column(
      children: <Widget>[
        Container(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notification.notificationList.length,
            itemBuilder: (BuildContext context, int index) {
              NotificationModel promotion = notification.notificationList[index];
              return notification.notificationList[index].category == 'Promotion' ? GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PromotionScreen(
                      promotion: promotion,
                      index: index,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // width: 150.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: "${ApiService.notiImage}/${notification.notificationList[index].image}",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image(
                                  height: 180.0,
                                  width: 180.0,
                                  image: NetworkImage(
                                    "${ApiService.notiImage}/${notification.notificationList[index].image}"
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ) : Container();
            },
          ),
        ),
      ],
    );
  }
}
