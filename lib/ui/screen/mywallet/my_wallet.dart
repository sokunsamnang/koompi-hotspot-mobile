import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class MyWallet extends StatefulWidget {
  final Function resetState;
  final String walletKey;

  MyWallet({this.resetState, this.walletKey});
  
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var appBarheight = 0.0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AppServices.noInternetConnection(_scaffoldKey);
    setState(() {
      fetchWallet();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchWallet() async{
    await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio(context);
    await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(
        context,
        PageTransition(type: PageTransitionType.leftToRight, 
          child: Navbar(),
        ),
        ModalRoute.withName('/navbar'),
      ),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text(_lang.translate('my_wallet'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
              backgroundColor: Colors.white,  
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back), 
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(type: PageTransitionType.leftToRight, 
                      child: Navbar(),
                    ),
                    ModalRoute.withName('/navbar'),
                  );
                }
              ),
            ),
            key: _scaffoldKey,
            // backgroundColor: Colors.white,
            // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            body: RefreshIndicator(
              onRefresh: () async{
                await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio(context);
                await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
                        child: getTotalBalance(),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 80.0,
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                color: HexColor('94FAD5'),
                                onPressed: () {
                                  _sendWalletBottomSheet(context, widget.walletKey);
                                },
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset('assets/images/ico_send_money.png'),
                                      Text(_lang.translate('send_money'),
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                color: HexColor('7CDBFA'),
                                onPressed: () {
                                  Navigator.push(
                                    context, 
                                    PageTransition(type: PageTransitionType.rightToLeft,
                                      child: ReceiveRequest()
                                    )
                                  );
                                },
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset('assets/images/ico_receive_money.png'),
                                      Text(_lang.translate('receive_money'),
                                        style: TextStyle(fontWeight: FontWeight.w700),)
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                            ),
                            child: Text(
                              _lang.translate('transactions'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          enabled: true,
                          child: Scrollbar(
                            isAlwaysShown: false,
                            showTrackOnHover: false,
                            radius: Radius.circular(12),
                            child: trxHistory(context)
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTotalBalance(){
    var _lang = AppLocalizeService.of(context);
    return Container(
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
        top: 22,
        bottom: 22
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        // color: Colors.grey[900],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [HexColor('0F4471'), HexColor('083358')]
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/sld.png',
            // height: 30,
            width: 35,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _lang.translate('total_balance'),
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)
                ),
              ),
              SizedBox(width: 10),
              mBalance.token != null ?
              Text(
                '${mBalance.token.toStringAsFixed(4)} SEL',
                style: GoogleFonts.inter(
                fontSize: 25.0,
                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)
                ),
              )
              : CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}

void _sendWalletBottomSheet(context, String walletKey){
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    ),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context){
      return Container(
        height: 153,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: new Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MyText(
                top: 20,
                bottom: 20,
                text: "Transaction options",
                color: '#000000',
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      await Navigator.push(
                        context, 
                        PageTransition(type: PageTransitionType.bottomToTop,
                          child: QrScanner(portList: [])
                        )
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.qr_code_scanner_outlined, size: 35, color: primaryColor),
                        MyText(
                          top: 6,
                          text: 'Scan Wallet',
                          fontSize: 12,
                          color: '#000000',
                        )
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      await Navigator.push(
                        context, 
                        PageTransition(type: PageTransitionType.bottomToTop,
                          child: SendRequest(walletKey, "")
                        )
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.description_outlined, size: 35, color: primaryColor),
                        MyText(
                          top: 6,
                          text: 'Fill Wallet',
                          fontSize: 12,
                          color: '#000000'
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  );
}
