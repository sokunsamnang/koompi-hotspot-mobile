import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:provider/provider.dart';

class NotificationDetail extends StatefulWidget {
  final List<NotificationModel> notification;
  final int index;
  NotificationDetail({this.notification, this.index});
  
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {

  
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notification', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/promotion7.png'),
                // Stack(
                //   children: <Widget>[
                //     Container(
                //       height: MediaQuery.of(context).size.width,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12.0),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black26,
                //             offset: Offset(0.0, 2.0),
                //             blurRadius: 6.0,
                //           ),
                //         ],
                //       ),
                //       child: Hero(
                //         tag: promotion.imageUrl,
                //         child: ClipRRect(
                //           // borderRadius: BorderRadius.circular(12.0),
                //           child: Image(
                //             image: AssetImage(promotion.imageUrl),
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppUtils.timeStampToDateTime(widget.notification[widget.index].date),
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.notification[widget.index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.info,
                        size: 12.5,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        widget.notification[widget.index].category,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.notification[widget.index].description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
