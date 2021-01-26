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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchWallet();
    });
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
          Scaffold(
            appBar: AppBar(
              title: Text('My Wallet', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
                        height: 25,
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 16),
                      //       child: Text(
                      //         'Balance',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           // color: AllCoustomTheme.getsecoundTextThemeColor(),
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/sld_stroke.svg',
                              // height: 30,
                              width: 50,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOTAL BALANCE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                mBalance.token != null ?
                                Text(
                                  '${mBalance.token.toStringAsFixed(2)} SEL',
                                  style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  ),
                                ) : CircularProgressIndicator(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.black,
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
                                fontSize: 20,
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
