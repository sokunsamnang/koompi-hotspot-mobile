import 'package:easy_localization/easy_localization.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/screen/mywallet/transaction_detail.dart';
import 'package:provider/provider.dart';

Widget trxHistory(BuildContext context) {

  String prevDay;
  String today = DateFormat("EEEE, d MMMM, y").format(DateTime.now());
  String yesterday = DateFormat("EEEE, d MMMM, y").format(DateTime.now().add(Duration(days: -1)));

  var _lang = AppLocalizeService.of(context);
  List _buildList(List<TrxHistoryModel> history, BuildContext context, String userWallet) {
    // List<Widget> listItems = List();
    List<Widget> listItems = List.filled(history.length, Container());

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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Text(
                  dateString,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
                    ),
                  ),
                )
              : Offstage(),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context, 
                  PageTransition(type: PageTransitionType.bottomToTop,
                    child: TransactionDetail(history: history, index: i,)
                  )
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: HexColor('00336A'),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          history[i].memo == 'Buy Hotspot Plan' || history[i].memo == 'Automatically top-up for renew plan.' || history[i].memo == 'Renew plan.'
                            ? 
                            Image.asset('assets/images/Koompi-WiFi-Icon.png')
                            : 
                            Image.asset('assets/images/sld_fit.png'
                            ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              history[i].memo == 'Buy Hotspot Plan' || history[i].memo == 'Automatically top-up for renew plan.' || history[i].memo == 'Renew plan.' 
                              ? 
                              Text('KOOMPI Fi-Fi',
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)
                                ),
                              ) 
                              :
                              Text(
                                userWallet == history[i].destination ? _lang.translate('recieved') : _lang.translate('sent'),
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)
                                ),
                              ),
                              Text(
                                AppUtils.timeStampToDateTime(history[i].createdAt),
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      userWallet == history[i].destination
                        ? 
                        Text(
                          '+ ${history[i].amount.toString()} SEL',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w700)
                          ),
                        )
                        : 
                        Text(
                          '- ${history[i].amount.toString()} SEL',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700)
                          ),
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
                  shrinkWrap: true,
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
