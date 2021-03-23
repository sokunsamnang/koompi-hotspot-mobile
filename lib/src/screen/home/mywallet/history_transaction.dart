import 'package:easy_localization/easy_localization.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

Widget trxHistory(BuildContext context) {

  String prevDay;
  String today = DateFormat("EEEE, d MMMM, y").format(DateTime.now());
  String yesterday = DateFormat("EEEE, d MMMM, y").format(DateTime.now().add(Duration(days: -1)));

  var _lang = AppLocalizeService.of(context);
  List _buildList(List<TrxHistoryModel> history, BuildContext context, String userWallet) {
    List<Widget> listItems = List();
    print('My History: ${history.length}');
    for (int i = 0; i < history.length; i++) {
      DateTime date = DateTime.parse(history[i].createdAt);
      String dateString = DateFormat("EEEE, d MMMM, y").format(date);

      if (today == dateString) {
        dateString = "Today";
      } else if (yesterday == dateString) {
        dateString = "Yesteday";
      }

      bool showHeader = prevDay != dateString;
      prevDay = dateString;

      listItems.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showHeader
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  dateString,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Color(0xff0caddb), fontWeight: FontWeight.w700)
                    ),
                  ),
                )
              : Offstage(),
            GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _lang.translate('transaction_history'),
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 15.0),
                      content: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('id'),
                                trailing: history[i].id,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                              title: _lang.translate('created_on'),
                              trailing: AppUtils.timeStampToDateTime(history[i].createdAt),
                            ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('sender'),
                                trailing: history[i].sender,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('destination'),
                                trailing: history[i].destination,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('amount'),
                                trailing: history[i].amount.toString() + " SEL",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('fee'),
                                trailing: history[i].fee.toString() + " SEL",
                              ),
                            ),
                            history[i].memo != '' ? Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 24.0),
                              child: ItemList(
                                title: _lang.translate('memo'),
                                trailing: history[i].memo,
                              ),
                            ) : Container(),
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey[300],
                            ),
                            InkWell(
                              child: Container(
                                // padding: EdgeInsets.only(top: 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0)),
                                ),
                                child:  mData.wallet == history[i].destination 
                                  ? FlatButton.icon(
                                    icon: Icon(Icons.replay_sharp, color: Colors.blue[700], size: 18),
                                    label: Text('RETURN', 
                                      style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.blue[700], fontSize: 17)
                                        ),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SendRequest(history[i].sender, history[i].amount.toString())),
                                      ),
                                    }
                                  )
                                  :
                                  FlatButton.icon(
                                    icon: Icon(Icons.repeat_sharp, color: Colors.blue[700], size: 18),
                                    label: Text('REPEAT',
                                      style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.blue[700], fontSize: 17)
                                        ),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SendRequest(history[i].destination, history[i].amount.toString())),
                                      ),
                                    }
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // actions: <Widget>[
                      //   mData.wallet == history[i].destination 
                      //   ? FlatButton.icon(
                      //     icon: Icon(Icons.replay_sharp, color: Colors.blue[700], size: 18),
                      //     label: Text('RETURN', 
                      //       style: GoogleFonts.nunito(
                      //         textStyle: TextStyle(color: Colors.blue[700], fontSize: 17)
                      //         ),
                      //     ),
                      //     onPressed: () => {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => SendRequest(history[i].sender, history[i].amount.toString())),
                      //       ),
                      //     }
                      //   )
                      //   :
                      //   FlatButton.icon(
                      //     icon: Icon(Icons.repeat_sharp, color: Colors.blue[700], size: 18),
                      //     label: Text('REPEAT',
                      //       style: GoogleFonts.nunito(
                      //         textStyle: TextStyle(color: Colors.blue[700], fontSize: 17)
                      //         ),
                      //     ),
                      //     onPressed: () => {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => SendRequest(history[i].destination, history[i].amount.toString())),
                      //       ),
                      //     }
                      //   ),
                      // ],
                    );
                  }
                );
              },
              child: Container(
                //margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                height: 60.0,
                color: Colors.white,
                child: ListTile(
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userWallet == history[i].destination
                          ? Text(
                              '+ ${history[i].amount.toString()} SEL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.green,
                                fontSize: 18.0,
                              ),
                            )
                          : Text(
                              '- ${history[i].amount.toString()} SEL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                                fontSize: 18.0,
                              ),
                            ),
                    ],
                  ),
                  leading: history[i].memo == 'Buy Hotspot Plan' || history[i].memo == 'Automatically top-up for renew plan.' || history[i].memo == 'Renew plan.'
                    ? Image.asset('assets/images/Koompi-WiFi-Icon.png', width: 25) 
                    : Image.asset('assets/images/sld.png', width: 25
                  ),
                  title: Text(
                    userWallet == history[i].destination ? _lang.translate('recieved') : _lang.translate('sent'),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),
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

  var history = Provider.of<TrxHistoryProvider>(context);
  return Scaffold(
    // Have No History
    body: history.trxHistoryList == null
        ? SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/undraw_wallet.svg',
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
        : history.trxHistoryList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            // Display History List
            : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        _buildList(history.trxHistoryList, context, mData.wallet),
                      ),
                    ),
                  ],
                ),
              ),
  );
}
