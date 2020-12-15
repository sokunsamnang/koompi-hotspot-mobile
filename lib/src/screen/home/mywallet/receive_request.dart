import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/models/model_wallet.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_btn_social.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_myButton.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_myQr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveRequest extends StatefulWidget {
  @override
  _ReceiveRequestState createState() => _ReceiveRequestState();
}

class _ReceiveRequestState extends State<ReceiveRequest> {
  PageController _pageController;

  int currentIndex = 0;

  double viewportFraction = 0.8;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text("Copied"),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void onPageChange(int value) async {
    if (_pageController != null) {
      setState(() {
        currentIndex = value;
      });
      if (currentIndex > 2) {
      } else {
        await _pageController.animateToPage(value,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      }
    }
  }

  void copyWallet(String _wallet) {
    Clipboard.setData(
      ClipboardData(
        text: _wallet,
      ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: viewportFraction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Recieve Request',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            // color: Colors.blue,
          ),
          Container(
            child: PageView.builder(
              controller: _pageController,
              itemCount: wallets.length,
              onPageChanged: onPageChange,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 80),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Selendra (SEL)',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  QrImage(
                                    embeddedImage: AssetImage('assets/images/icon_launcher.png'),
                                    data: mData.wallet,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    mData.wallet,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Center(
                                    child: InkWell(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0xFF6078ea).withOpacity(.3),
                                                  offset: Offset(0.0, 8.0),
                                                  blurRadius: 8.0)
                                            ]),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () async {
                                            copyWallet(mData.wallet);
                                            showSnackBar();
                                          },
                                          child: Center(
                                            child: Text("COPY",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins-Bold",
                                                  fontSize: 18,
                                                  letterSpacing: 2.5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: BtnSocial(
                            () {}, AssetImage('assets/images/avatar.png'))),
                    ),
                    // ReuseIndicator(currentIndex),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}