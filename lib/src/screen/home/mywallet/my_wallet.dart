import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/constance/constance.dart';
import 'package:koompi_hotspot/src/constance/global.dart';
import 'package:koompi_hotspot/src/constance/global.dart' as globals;
import 'package:koompi_hotspot/src/constance/themes.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_trx_history.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/history_transaction.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/receive_request.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/send_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyWallet extends StatefulWidget {
  final Function resetState;

  MyWallet({this.resetState});
  
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var appBarheight = 0.0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isInProgress = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Navbar()),
        ModalRoute.withName('/'),
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
            // appBar: AppBar(
            //   title: Text('My Wallet', style: TextStyle(color: Colors.black)),
            //   backgroundColor: Colors.white,  
            //   iconTheme: IconThemeData(
            //     color: Colors.black, //change your color here
            //   ),
            //   automaticallyImplyLeading: true,
            //   leading: IconButton(
            //     icon: Icon(Icons.arrow_back), 
            //     onPressed: (){
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => Navbar()),
            //         ModalRoute.withName('/'),
            //       );
            //     }
            //   ),
            // ),
            key: _scaffoldKey,
            // backgroundColor: Colors.white,
            // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            body: ModalProgressHUD(
              inAsyncCall: _isInProgress,
              opacity: 0,
              progressIndicator: CupertinoActivityIndicator(
                radius: 12,
              ),
              child: !_isInProgress
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: appBarheight,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Wallet',
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
                          height: 10,
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
                                'SEL',
                                style: TextStyle(
                                  color: Colors.black,
                                  // color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                ),
                              ),
                              Text(
                                '${mBalance.balance}',
                                style: TextStyle(
                                  color: Colors.black,
                                  // color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/images/icon_launcher.png',
                                  height: 40,
                                  width: 40,
                                ),
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
                                      MaterialPageRoute(builder: (context) => SendRequest()),
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
                                'Recent transactions',
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
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}