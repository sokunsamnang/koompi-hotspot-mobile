import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/core/models/vote_result.dart';
import 'package:provider/provider.dart';
import 'package:linkable/linkable.dart';

class PromotionScreen extends StatefulWidget {
  final NotificationModel promotion;
  final int index;

  PromotionScreen({this.promotion, this.index});

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  bool isUpVoted = false;
  bool isDownVoted = false;

  Backend _backend = Backend();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onSubmitUpVoteAdsPost() async {
    var _lang = AppLocalizeService.of(context);

    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response =
            await PostRequest().upVoteAdsPost(widget.promotion.id.toString());
        var responseJson = json.decode(_backend.response.body);
        if (_backend.response.statusCode == 200) {
          await Provider.of<VoteResultProvider>(context, listen: false)
              .fetchVoteResult(widget.promotion.id);
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
          Navigator.of(context).pop();
        } else {
          await Components.dialog(
              context,
              textAlignCenter(text: responseJson['message']),
              warningTitleDialog());
          Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
          context,
          textAlignCenter(text: _lang.translate('no_internet_message')),
          warningTitleDialog());
      Navigator.of(context).pop();
    }
  }

  Future<void> _onSubmitDownVoteAdsPost() async {
    var _lang = AppLocalizeService.of(context);

    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response =
            await PostRequest().downVoteAdsPost(widget.promotion.id.toString());
        var responseJson = json.decode(_backend.response.body);
        if (_backend.response.statusCode == 200) {
          await Provider.of<VoteResultProvider>(context, listen: false)
              .fetchVoteResult(widget.promotion.id);
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
          Navigator.of(context).pop();
        } else {
          await Components.dialog(
              context,
              textAlignCenter(text: responseJson['message']),
              warningTitleDialog());
          Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
          context,
          textAlignCenter(text: _lang.translate('no_internet_message')),
          warningTitleDialog());
      Navigator.of(context).pop();
    }
  }

  Future<void> _onSubmitUnVoteAdsPut() async {
    var _lang = AppLocalizeService.of(context);
    dialogLoading(context);
    // dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response =
            await PostRequest().unVoteAdsPut(widget.promotion.id.toString());
        var responseJson = json.decode(_backend.response.body);
        if (_backend.response.statusCode == 200) {
          await Provider.of<VoteResultProvider>(context, listen: false)
              .fetchVoteResult(widget.promotion.id);
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
          Navigator.of(context).pop();
        } else {
          await Components.dialog(
              context,
              textAlignCenter(text: responseJson['message']),
              warningTitleDialog());
          Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
          context,
          textAlignCenter(text: _lang.translate('no_internet_message')),
          warningTitleDialog());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    var _notification = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('promotion'),
            style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Hero(
                      tag:
                          "${ApiService.notiImage}/${_notification.notificationList[widget.index].image}",
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                          image: NetworkImage(
                              "${ApiService.notiImage}/${_notification.notificationList[widget.index].image}"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            voteResult.votedType != "Voted Up" ||
                                    voteResult.votedType == null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                          'assets/images/up-vote-grey.png'),
                                      onPressed: () async {
                                        await Provider.of<NotificationProvider>(
                                                context,
                                                listen: false)
                                            .fetchNotification();
                                        setState(() {
                                          voteResult.votedType = "Voted Up";
                                          _onSubmitUpVoteAdsPost();
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                          'assets/images/up-vote-blue.png'),
                                      onPressed: () async {
                                        await Provider.of<NotificationProvider>(
                                                context,
                                                listen: false)
                                            .fetchNotification();
                                        setState(() {
                                          voteResult.votedType = null;
                                          _onSubmitUnVoteAdsPut();
                                        });
                                      },
                                    ),
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                _notification
                                    .notificationList[widget.index].vote
                                    .toString(),
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              width: 5,
                            ),
                            voteResult.votedType != "Voted Down" ||
                                    voteResult.votedType == null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                          'assets/images/down-vote-grey.png'),
                                      onPressed: () async {
                                        await Provider.of<NotificationProvider>(
                                                context,
                                                listen: false)
                                            .fetchNotification();
                                        setState(() {
                                          voteResult.votedType = "Voted Down";
                                          _onSubmitDownVoteAdsPost();
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Image.asset(
                                          'assets/images/down-vote-blue.png'),
                                      onPressed: () async {
                                        await Provider.of<NotificationProvider>(
                                                context,
                                                listen: false)
                                            .fetchNotification();
                                        setState(() {
                                          voteResult.votedType = null;
                                          _onSubmitUnVoteAdsPut();
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              ),
                              icon: Icon(Icons.share_outlined),
                              label: Text('Share'),
                              onPressed: () {
                                Share.share('https://koompi.com',
                                    subject: 'HOT Promotion!');
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
                        AppUtils.timeStampToDate(widget.promotion.date),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.promotion.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.info,
                            size: 12.5,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            widget.promotion.category,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Linkable(
                      text: widget.promotion.description,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
