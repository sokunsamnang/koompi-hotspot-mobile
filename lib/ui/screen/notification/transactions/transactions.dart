import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/screen/mywallet/transaction_detail.dart';
import 'package:provider/provider.dart';

Widget transaction(BuildContext context) {
  // DateTime now = DateTime.now();
  // String prevDay;
  // String today = DateFormat("EEEE, d MMMM, y").format(now.toLocal());
  // String yesterday = DateFormat("EEEE, d MMMM, y")
  //     .format(now.toLocal().add(Duration(days: -1)));

  var _lang = AppLocalizeService.of(context);
  List _buildList(
      List<TrxHistoryModel> history, BuildContext context, String userWallet) {
    List<Widget> listItems = [];
    // List<Widget> listItems = List.filled(history.length, Container());

    print('My History: ${history.length}');
    for (int i = 0; i < history.length; i++) {
      // DateTime date = DateTime.parse(history[i].datetime);
      // String dateString = DateFormat("EEEE, d MMMM, y").format(date.toLocal());

      // if (today == dateString) {
      //   dateString = "Today";
      // } else if (yesterday == dateString) {
      //   dateString = "Yesterday";
      // }

      // bool showHeader = prevDay != dateString;
      // prevDay = dateString;

      listItems.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: TransactionDetail(
                          history: history,
                          index: i,
                        )));
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          history[i].memo == 'Subscribed Fi-Fi Plan 30 Days' ||
                                  history[i].memo ==
                                      'Subscribed Fi-Fi Plan 365 Days' ||
                                  history[i].memo ==
                                      'Automatically Renewed Fi-Fi Plan 30 Days' ||
                                  history[i].memo ==
                                      'Automatically Renewed Fi-Fi Plan 365 Days' ||
                                  history[i].memo ==
                                      'Renewed Fi-Fi Plan 30 Days' ||
                                  history[i].memo ==
                                      'Renewed Fi-Fi Plan 365 Days' ||
                                  history[i].memo ==
                                      'Changed Subscribe Fi-Fi Plan To 30 Days' ||
                                  history[i].memo ==
                                      'Changed Subscribe Fi-Fi Plan To 365 Days'
                              ? Image.asset(
                                  'assets/images/Koompi-WiFi-Icon.png',
                                  scale: 39)
                              : history[i].symbol == 'SEL'
                                  ? Image.asset(
                                      'assets/images/sel-coin-icon.png',
                                      width: 27)
                                  : Image.asset(
                                      'assets/images/rise-coin-icon.png',
                                      width: 27),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              history[i].memo ==
                                          'Subscribed Fi-Fi Plan 30 Days' ||
                                      history[i].memo ==
                                          'Subscribed Fi-Fi Plan 365 Days' ||
                                      history[i].memo ==
                                          'Automatically Renewed Fi-Fi Plan 30 Days' ||
                                      history[i].memo ==
                                          'Automatically Renewed Fi-Fi Plan 365 Days' ||
                                      history[i].memo ==
                                          'Renewed Fi-Fi Plan 30 Days' ||
                                      history[i].memo ==
                                          'Renewed Fi-Fi Plan 365 Days' ||
                                      history[i].memo ==
                                          'Changed Subscribe Fi-Fi Plan To 30 Days' ||
                                      history[i].memo ==
                                          'Changed Subscribe Fi-Fi Plan To 365 Days'
                                  ? Text(
                                      'KOOMPI Fi-Fi',
                                      style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    )
                                  : Text(
                                      userWallet == history[i].destination
                                          ? _lang.translate('recieved')
                                          : _lang.translate('sent'),
                                      style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    ),
                              Text(
                                AppUtils.timeStampToDateTime(
                                    history[i].datetime),
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      userWallet == history[i].destination
                          ? Text(
                              '+ ${history[i].amount} ${history[i].symbol}',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            )
                          : Text(
                              '- ${history[i].amount} ${history[i].symbol}',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
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
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/undraw_wallet.svg',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      placeholderBuilder: (context) => Center(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "No Activity",
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          )

        // Display Loading
        : history.trxHistoryList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            // Display History List
            : SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<TrxHistoryProvider>(context,
                            listen: false)
                        .fetchTrxHistory();
                  },
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          _buildList(
                              history.trxHistoryList, context, mData.wallet),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
  );
}
