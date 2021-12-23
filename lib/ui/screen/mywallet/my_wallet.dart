import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class MyWallet extends StatefulWidget {
  final Function resetState;
  final String walletKey;

  MyWallet({this.resetState, this.walletKey});

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var appBarheight = 0.0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // fetchWallet();
    AppServices.noInternetConnection(_scaffoldKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchWallet() async {
    await Provider.of<BalanceProvider>(context, listen: false).fetchPortfolio();
    await Provider.of<TrxHistoryProvider>(context, listen: false)
        .fetchTrxHistory();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;

    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: Navbar(0),
        ),
        ModalRoute.withName('/navbar'),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_lang.translate('my_wallet'),
              style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: Navbar(0),
                  ),
                  ModalRoute.withName('/navbar'),
                );
              }),
        ),
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<BalanceProvider>(context, listen: false)
                .fetchPortfolio();
            await Provider.of<TrxHistoryProvider>(context, listen: false)
                .fetchTrxHistory();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: getTotalBalance(context),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 85.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black87,
                              primary: HexColor('94FAD5'),
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onPressed: () {
                              _sendWalletBottomSheet(context, widget.walletKey);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/images/send.png',
                                      scale: 2),
                                  Text(
                                    _lang.translate('send_money'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black87,
                              primary: HexColor('7CDBFA'),
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ReceiveRequest()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/images/receive.png',
                                      scale: 2),
                                  Text(
                                    _lang.translate('receive_money'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        child: Text(
                          _lang.translate('transaction_history'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            // color: AllCoustomTheme.getsecoundTextThemeColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: trxHistory(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTotalBalance(BuildContext context) {
    var balance = Provider.of<BalanceProvider>(context);
    var _lang = AppLocalizeService.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 22, bottom: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          // color: Colors.grey[900],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [HexColor('0F4471'), HexColor('083358')])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _lang.translate('total_balance'),
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Image.asset('assets/images/rise-coin-icon.png', width: 20),
              SizedBox(width: 10),
              balance.balanceList[0].token == "Token Suspended" ||
                      balance.balanceList[0].token == null
                  ? Text(
                      '${balance.balanceList[0].token}',
                      style: GoogleFonts.nunito(
                          fontSize: 18.0,
                          textStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700)),
                    )
                  : Text(
                      '${balance.balanceList[0].token}',
                      style: GoogleFonts.nunito(
                          fontSize: 18.0,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
              Text(
                ' ${balance.balanceList[0].symbol}',
                style: GoogleFonts.nunito(
                    fontSize: 18.0,
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Image.asset('assets/images/sel-coin-icon.png', width: 22),
              SizedBox(width: 10),
              balance.balanceList[1].token == "Token Suspended" ||
                      balance.balanceList[1].token == null
                  ? Text(
                      '${balance.balanceList[1].token}',
                      style: GoogleFonts.nunito(
                          fontSize: 18.0,
                          textStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700)),
                    )
                  : Text(
                      '${balance.balanceList[1].token}',
                      style: GoogleFonts.nunito(
                          fontSize: 18.0,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
              Text(
                ' ${balance.balanceList[1].symbol}',
                style: GoogleFonts.nunito(
                    fontSize: 18.0,
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void _sendWalletBottomSheet(context, String walletKey) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        var _lang = AppLocalizeService.of(context);
        return Container(
          height: 153,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: MyText(
                  top: 20,
                  bottom: 20,
                  text: _lang.translate('transaction_options'),
                  color: '#000000',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: QrScanner(portList: [])));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.qr_code_scanner_outlined,
                              size: 35, color: primaryColor),
                          MyText(
                            top: 6,
                            text: _lang.translate('scan_qr'),
                            fontSize: 12,
                            color: '#000000',
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: SendRequest(walletKey, "", "")));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.description_outlined,
                              size: 35, color: primaryColor),
                          MyText(
                              top: 6,
                              text: _lang.translate('fill_address'),
                              fontSize: 12,
                              color: '#000000')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
