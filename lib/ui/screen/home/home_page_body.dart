import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:provider/provider.dart';

Widget bodyPage(BuildContext context) {
  var _lang = AppLocalizeService.of(context);

  return Container(
    // height: MediaQuery.of(context).size.height,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===========Hotspot Plan Widget===========
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            _lang.translate('my_plan').toUpperCase(),
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        mPlan.username == null ? noPlanView(context) : _planViewButton(context),

        // ===========Account Balance Widget===========
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            _lang.translate('account').toUpperCase(),
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        mData.wallet == null
            ? startGetWallet(context)
            : _myWalletButton(context),

        // ===========Promotion Widget===========
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            _lang.translate('whats_hots').toUpperCase(),
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        PromotionCarousel(),
      ],
    ),
  );
}

Widget startGetWallet(context) {
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              // color: Colors.grey[900],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor('0F4471'), HexColor('083358')])),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: WalletChoice(),
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    _lang.translate('get_wallet'),
                                    style: TextStyle(
                                        fontFamily: "Medium",
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -170,
                top: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.lightBlueAccent[50],
                ),
              ),
              Positioned(
                left: -160,
                top: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.lightBlue[300],
                ),
              ),
              Positioned(
                right: -170,
                bottom: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.deepOrangeAccent,
                ),
              ),
              Positioned(
                right: -160,
                bottom: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.orangeAccent,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget noPlanView(BuildContext context) {
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .25,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: HexColor('083C5A'),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _lang.translate('buy_hotspot_plan'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: HotspotPlan(),
                              ));
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              _lang.translate('buy_plan'),
                              style: TextStyle(
                                  fontFamily: "Medium", color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _planViewButton(context) {
  var _lang = AppLocalizeService.of(context);
  return mPlan.status == true
      ? Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: HexColor('083C5A'),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: PlanView(),
                          ));
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          'assets/images/Koompi-WiFi-Icon.png',
                                          width: 30),
                                      SizedBox(width: 10),
                                      Text(
                                        _lang.translate('hotspot'),
                                        style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                                color: HexColor('0CACDA'),
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800)),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.more_vert,
                                          color: Colors.white),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: PlanView(),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${_lang.translate('device')}:',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Text(
                                            '${mPlan.device} ${_lang.translate('devices')}',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${_lang.translate('speed')}:',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Text(
                                            '5 ${_lang.translate('mb')}',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${_lang.translate('plan')}:',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Text(
                                            '${mPlan.plan} ${_lang.translate('day')}',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${_lang.translate('valid_until')}:',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Text(
                                            '${mPlan.timeLeft.split(' ').reversed.join(' ')}',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            )),
          ),
        )
      : _planExpire(context);
}

Widget _planExpire(context) {
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: HexColor('083C5A'),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              // highlightColor: Colors.transparent,
              // splashColor: Colors.transparent,
              onTap: () async {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: PlanView(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 333),
                      child: IconButton(
                          icon: Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: PlanView(),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _lang.translate('plan_expire'),
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    ),
  );
}

Widget _myWalletButton(context) {
  var balance = Provider.of<BalanceProvider>(context);
  var _lang = AppLocalizeService.of(context);
  return balance.balanceList.isNotEmpty
      ? Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[900],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: WalletScreen(),
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * .35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            // color: Colors.grey[900],
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  HexColor('0F4471'),
                                  HexColor('083358')
                                ])),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _lang.translate('asset'),
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          // Expanded(child: Container()),
                                          Text(
                                            _lang.translate('total'),
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/rise-coin-icon.png',
                                                    width: 20),
                                                SizedBox(width: 10),
                                                Text(
                                                  '${balance.balanceList[0].symbol}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          balance.balanceList[0].token ==
                                                      "Token Suspended" ||
                                                  balance.balanceList[0]
                                                          .token ==
                                                      null
                                              ? Text(
                                                  '${balance.balanceList[0].token}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                )
                                              : Text(
                                                  '${balance.balanceList[0].token}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/sel-coin-icon.png',
                                                    width: 22),
                                                SizedBox(width: 10),
                                                Text(
                                                  '${balance.balanceList[1].symbol}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          balance.balanceList[1].token ==
                                                      "Token Suspended" ||
                                                  balance.balanceList[1]
                                                          .token ==
                                                      null
                                              ? Text(
                                                  '${balance.balanceList[1].token}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                )
                                              : Text(
                                                  '${balance.balanceList[1].token}',
                                                  style: GoogleFonts.nunito(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 345,
                              top: 12,
                              child: IconButton(
                                  icon: Icon(Icons.more_vert,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: WalletScreen(),
                                      ),
                                    );
                                  }),
                            ),
                            Positioned(
                              right: 280,
                              left: -185,
                              top: -214,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor: Colors.lightBlueAccent[50],
                              ),
                            ),
                            Positioned(
                              left: -180,
                              top: -210,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor: Colors.lightBlue[300],
                              ),
                            ),
                            Positioned(
                              left: 280,
                              right: -180,
                              bottom: -215,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor: Colors.deepOrangeAccent,
                              ),
                            ),
                            Positioned(
                              right: -180,
                              bottom: -210,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor: Colors.orangeAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ),
        )
      : _myWalletError(context);
}

Widget _myWalletError(context) {
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: HexColor('083C5A'),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _lang.translate('selendra_down'),
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      )),
    ),
  );
}
