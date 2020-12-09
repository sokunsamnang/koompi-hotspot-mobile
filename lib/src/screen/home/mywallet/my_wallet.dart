import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/constance/constance.dart';
import 'package:koompi_hotspot/src/constance/global.dart';
import 'package:koompi_hotspot/src/constance/global.dart' as globals;
import 'package:koompi_hotspot/src/constance/themes.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/receive_request.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/send_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyWallet extends StatefulWidget {
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
                    ModalRoute.withName('/'),
                  );
                }
              ),
            ),
            key: _scaffoldKey,
            backgroundColor: Colors.white,
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
                                '\RSEL',
                                style: TextStyle(
                                  color: Colors.black,
                                  // color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                ),
                              ),
                              Text(
                                '2,564',
                                style: TextStyle(
                                  color: Colors.black,
                                  // color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              Text(
                                '.95',
                                style: TextStyle(
                                  color: Colors.black,
                                  // color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstanceData.SIZE_TITLE20,
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
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        color: AllCoustomTheme.boxColor(),
                                      ),
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.music_note,
                                                    color: AllCoustomTheme.boxColor(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Apple Music',
                                                      style: TextStyle(
                                                        color: AllCoustomTheme.getTextThemeColors(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      'SUBSCRIPTION',
                                                      style: TextStyle(
                                                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                        fontSize: ConstanceData.SIZE_TITLE12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    "-\$10",
                                                    style: TextStyle(
                                                      color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 50),
                                              child: AnimatedDivider(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: AllCoustomTheme.boxColor(),
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.book,
                                                    color: AllCoustomTheme.boxColor(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Books',
                                                      style: TextStyle(
                                                        color: AllCoustomTheme.getTextThemeColors(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      'TEAM ACCOUNTS',
                                                      style: TextStyle(
                                                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                        fontSize: ConstanceData.SIZE_TITLE12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    "-\$85",
                                                    style: TextStyle(
                                                      color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 50),
                                              child: AnimatedDivider(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
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
