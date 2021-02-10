import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/promotion_carousel.dart';


Widget bodyPage(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        mPlan.username == null ? noPlanView(context) : _planViewButton(context),
        SizedBox(height: 20),
        mBalance.token == null ? startGetWallet(context) : _myWalletButton(context),
        SizedBox(height: 20),
        PromotionCarousel(),
        // MyCarousel(),
        // SizedBox(height: 40),
        // Text('Promotions', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18)),
        // SizedBox(height: 20),
        // Expanded(child: MyCarousel(),)
      ],
    ),
  );
}



  Widget _balanceTokens(context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .30,
            color: Colors.blueGrey[900],
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/sld_stroke.png', width: 25),
                            SizedBox(width: 10),
                            Text(
                              'SELENDRA', 
                              style: GoogleFonts.nunito(
                              textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, right:50),
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/sld_stroke.png', width: 20),
                                  SizedBox(width: 10),
                                  Text(
                                    'SEL',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            mBalance != null ?
                            Text(
                              '${mBalance.token.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ) : CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        width: 110,
                        padding:
                          EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.white, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WalletScreen()),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Detail",
                                    style: TextStyle(
                                      fontFamily: "Medium",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
      )
    );
  }


  Widget startGetWallet(context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .30,
            color: Colors.blueGrey[900],
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 140,
                        padding:
                          EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.white, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WalletChoice()),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Get Wallet",
                                    style: TextStyle(
                                      fontFamily: "Medium",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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

// Widget planView(BuildContext context) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height * .27,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12.0),
//       color: Colors.grey[900],
//     ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       SizedBox(height: 20),
//       Center(
//         child: Image.asset(
//           "assets/images/logo.png",
//           // height: 100,
//           // width: 100,
//           color: Colors.white,
//           scale: 4,
//         ),
//       ),
//       Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 50, right: 50),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Device:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Medium'
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     Text(
//                       '2 Devices',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 50, right: 50),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Expiration:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Medium'
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     Text(
//                       '${mPlan.plan} Days',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 50, right: 50),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Speed:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Medium'
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     Text(
//                       '5 MB',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

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
            height: MediaQuery.of(context).size.height * .30, 
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: Colors.blueGrey[900],
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
                  width: 130,
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.white, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserPlan()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(_lang.translate('buy_plan'),
                              style: TextStyle(
                                fontFamily: "Medium",
                                color: Colors.white),
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

Widget _planViewButton(context){
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .30,
            // width: ScreenUtil.getInstance().setWidth(330),
            // height: ScreenUtil.getInstance().setHeight(100),
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
              // highlightColor: Colors.transparent,
              // splashColor: Colors.transparent,
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanView()));
              },
              child: mPlan.status == true ? Column(
                children: [
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Koompi-WiFi-Icon.png', width: 25),
                          SizedBox(width: 10),
                          Text(
                            _lang.translate('hotspot_plan'),
                            style: GoogleFonts.nunito(
                            textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_lang.translate('device')}:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Medium'
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '${mPlan.device} ${_lang.translate('devices')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_lang.translate('expire')}:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Medium'
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '${mPlan.plan} ${_lang.translate('day')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_lang.translate('speed')}:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Medium'
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '5 ${_lang.translate('mb')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_lang.translate('valid_until')}:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Medium'
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '${mPlan.timeLeft.split(' ').reversed.join(' ')}', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ) 
                :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _lang.translate('plan_expire'),
                      style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                      ),
                    ),
                  ],
                ), 
              ),
            ),
          ),
        )
      ),
    ),
  );
}

Widget _myWalletButton(context){
  var _lang = AppLocalizeService.of(context);
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .30,
            // width: ScreenUtil.getInstance().setWidth(330),
            // height: ScreenUtil.getInstance().setHeight(100),
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
              // highlightColor: Colors.transparent,
              // splashColor: Colors.transparent,
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .30,
                  color: Colors.blueGrey[900],
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/sld_stroke.png', width: 20),
                                  SizedBox(width: 10),
                                  Text(
                                    'SELENDRA', 
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _lang.translate('asset'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    _lang.translate('total'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 50, right:50),
                              child: Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/sld_stroke.png', width: 18),
                                        SizedBox(width: 10),
                                        Text(
                                          'SEL', 
                                          style: GoogleFonts.nunito(
                                          textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  mBalance != null ?
                                  Text(
                                    '${mBalance.token.toStringAsFixed(2)}',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                                    ),
                                  )
                                  : CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              width: 110,
                              padding:
                                EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.white, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FlatButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WalletScreen()),
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(_lang.translate('detial'),
                                          style: TextStyle(
                                            fontFamily: "Medium",
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
            ),
          ),
        )
      ),
    ),
  );
}