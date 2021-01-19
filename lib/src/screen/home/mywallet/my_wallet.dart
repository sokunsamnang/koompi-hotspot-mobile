import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/constance/constance.dart';
import 'package:koompi_hotspot/src/constance/global.dart';
import 'package:koompi_hotspot/src/constance/global.dart' as globals;
import 'package:koompi_hotspot/src/constance/themes.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_trx_history.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/history_transaction.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/receive_request.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/send_request.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

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

  GetRequest _getRequest = GetRequest();
  @override
  void initState() {
    super.initState();
    // fetchHistory();
    setState(() {
      fetchWallet();
    });
    
  }

  void fetchHistory() async {
    await _getRequest.getTrxHistory();
  }

  void fetchWallet() async{
    await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
    await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Navbar()),
        ModalRoute.withName('/navbar'),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                ],
              ),
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('My Wallet', style: TextStyle(color: Colors.black)),
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
                    MaterialPageRoute(builder: (context) => Navbar()),
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
                await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
                await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: appBarheight,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.black,
                                // color: AllCoustomTheme.getsecoundTextThemeColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'SEL: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 30.0,
                              ),
                            ),
                            mBalance.token != null ?
                            Text(
                              '${mBalance.token.toStringAsFixed(2)}',
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              // fontFamily: 'Poppins-ExtraLight',
                              fontWeight: FontWeight.bold,
                              ),
                            ) : CircularProgressIndicator(),
                            Expanded(
                              child: Container(),
                            ),
                            SvgPicture.asset(
                              'assets/images/sld_stroke.svg',
                              // height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: AnimatedDivider(),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 80.0,
                        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SendRequest(widget.walletKey)),
                                  );
                                },
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset('assets/images/ico_send_money.png'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text('Send\nmoney',
                                          style: TextStyle(fontWeight: FontWeight.w700),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 25),
                            Expanded(
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ReceiveRequest()),
                                  );
                                },
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset('assets/images/ico_receive_money.png'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text('Receive\nmoney',
                                          style: TextStyle(fontWeight: FontWeight.w700),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Transactions',
                              style: TextStyle(
                                color: Colors.black,
                                // color: AllCoustomTheme.getsecoundTextThemeColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(child: trxHistory(context),)
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
}
