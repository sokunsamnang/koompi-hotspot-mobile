import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:linkable/linkable.dart';

class NotificationDetail extends StatefulWidget {
  final List<NotificationModel> notification;
  final int index;
  NotificationDetail({this.notification, this.index});
  
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {

  bool isUpVoted = false;
  bool isDownVoted = false;

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
        title: Text(_lang.translate('notifications'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
                Center(
                  child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      "${ApiService.notiImage}/${widget.notification[widget.index].image}"
                    )
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            isUpVoted == false ?
                            Container(
                              alignment: Alignment.center,
                              child:IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset('assets/images/up-vote-grey.png'),
                                onPressed: () {
                                  setState(() {
                                    isUpVoted = true;
                                    isDownVoted = false;
                                  });
                                },
                              ),
                            )
                            :
                            Container(
                              alignment: Alignment.center,
                              child:IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset('assets/images/up-vote-blue.png'),
                                onPressed: () {
                                  setState(() {
                                    isUpVoted = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text('Vote', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 5,),
                            isDownVoted == false ?
                            Container(
                              alignment: Alignment.center,
                              child:IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset('assets/images/down-vote-grey.png'),
                                onPressed: () {
                                  setState(() {
                                    isDownVoted = true;
                                    isUpVoted = false;
                                  });
                                },
                              ),
                            )
                            :
                            Container(
                              alignment: Alignment.center,
                              child:IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset('assets/images/down-vote-blue.png'),
                                onPressed: () {
                                  setState(() {
                                    isDownVoted = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              icon: Icon(Icons.share_outlined), 
                              label: Text('Share'),
                              onPressed: () {
                                Share.share('https://koompi.com', subject: 'HOT Promotion!');
                              },
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppUtils.timeStampToDate(widget.notification[widget.index].date),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.notification[widget.index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
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
                  child: Linkable(
                    text: widget.notification[widget.index].description,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Poppins-Regular')
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
