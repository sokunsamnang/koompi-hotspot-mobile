import 'package:geolocator/geolocator.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:location/location.dart' as loc;
import 'package:wifi_connector/wifi_connector.dart';

class WifiConnect extends StatefulWidget {
  @override
  _WifiConnectState createState() => _WifiConnectState();
}

class _WifiConnectState extends State<WifiConnect> {
  final Geolocator geolocator = Geolocator();
  TextEditingController _passwordController = TextEditingController();
  Timer timer;

  @override
  void initState() {
    super.initState();
    _checkGPS();
    timer = Timer.periodic(
        Duration(seconds: 3),
        (Timer t) => setState(() {
              WiFiForIoTPlugin.getSSID();
            }));
  }

  @override
  void dispose() {
    timer?.cancel();
    _passwordController.clear();
    super.dispose();
  }

  // void _wifiOptionBottomSheet(context, String ssid) {
  //   var _lang = AppLocalizeService.of(context);

  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(12), topRight: Radius.circular(12)),
  //       ),
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 153,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(12), topRight: Radius.circular(12)),
  //           ),
  //           child: new Column(
  //             children: <Widget>[
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: MyText(
  //                   top: 20,
  //                   bottom: 20,
  //                   text: ssid,
  //                   color: '#000000',
  //                 ),
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () async {
  //                         await WiFiForIoTPlugin.removeWifiNetwork(ssid);
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Column(
  //                         children: [
  //                           Icon(Icons.delete_outline_outlined,
  //                               size: 35, color: primaryColor),
  //                           MyText(
  //                             top: 6,
  //                             text: _lang.translate('forget_network'),
  //                             fontSize: 12,
  //                             color: '#000000',
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () async {
  //                         await WiFiForIoTPlugin.forceWifiUsage(false);
  //                         await WiFiForIoTPlugin.disconnect();
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Column(
  //                         children: [
  //                           Icon(Icons.wifi_off_outlined,
  //                               size: 35, color: primaryColor),
  //                           MyText(
  //                             top: 6,
  //                             text: _lang.translate('disconnect_network'),
  //                             fontSize: 12,
  //                             color: '#000000',
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  Future<void> connectWifiHotpot(BuildContext context, String ssid) async {
    dialogLoading(context);
    await WiFiForIoTPlugin.forceWifiUsage(true);
    await WiFiForIoTPlugin.connect(ssid,
        joinOnce: false, security: NetworkSecurity.NONE, withInternet: true);
    // await WifiConnector.connectToWifi(
    //   ssid: ssid,
    // );
    Navigator.of(context).pop();
  }

  Future<String> _displayTextInputDialog(
    BuildContext context,
    String ssid,
  ) {
    var _lang = AppLocalizeService.of(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            // backgroundColor: Col,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            contentPadding:
                EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text(
              'Enter Password: $ssid',
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('password_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              obscureText: true,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            HexColor('0CACDA')),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 35)),
                      ),
                      child: Text('CANCEL'),
                      onPressed: () => {
                            Navigator.of(context).pop(),
                            _passwordController.clear(),
                          }),
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor('0CACDA')),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                      ),
                      child: Text('OK'),
                      onPressed: () async {
                        dialogLoading(context);
                        await WiFiForIoTPlugin.forceWifiUsage(true);
                        await WiFiForIoTPlugin.connect(ssid,
                            password: _passwordController.text,
                            joinOnce: false,
                            security: NetworkSecurity.WPA,
                            withInternet: true);
                        // await WifiConnector.connectToWifi(
                        //     ssid: ssid,
                        //     password: _passwordController.text,
                        //     isWEP: true);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        _passwordController.clear();
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }
    print('wifi list: ${htResultNetwork.length}');
    return htResultNetwork;
  }

  void _checkGPS() async {
    var status = await Geolocator.checkPermission();
    bool isGPSOn = await Geolocator.isLocationServiceEnabled();
    if (status == LocationPermission.denied && !isGPSOn) {
      loc.Location locationR = loc.Location();
      locationR.requestService();
    } else if (isGPSOn == false) {
      loc.Location locationR = loc.Location();
      locationR.requestService();
    } else {
      loadWifiList();
    }
  }

  Widget isConnected() {
    var _lang = AppLocalizeService.of(context);

    return FutureBuilder(
        future: WiFiForIoTPlugin.getSSID(),
        builder: (BuildContext context, AsyncSnapshot<String> ssid) {
          return ssid.data != '<unknown ssid>'
              ? Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.signal_wifi_4_bar_sharp,
                          color: Colors.green),
                      title: Text(
                        '${ssid.data}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _lang.translate('connected'),
                            style: TextStyle(color: Colors.green),
                          ),
                          // SizedBox(width: 10),
                          // GestureDetector(
                          //     onTap: () =>
                          //         _wifiOptionBottomSheet(context, ssid.data),
                          //     child: Icon(Icons.settings_outlined,
                          //         color: primaryColor)),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey[300],
                    )
                  ],
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _lang.translate('wifi'),
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins-Bold",
                fontSize: 18,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                setState(() {
                  _checkGPS();
                });
              },
              icon: Icon(Icons.search, color: primaryColor),
              label: Text(_lang.translate('scan'),
                  style: TextStyle(color: primaryColor)),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            isConnected(),
            Expanded(
              child: FutureBuilder<List<WifiNetwork>>(
                  future: loadWifiList(),
                  builder: (context, snapshot) {
                    List<WifiNetwork> wifiNetwork = snapshot.data ?? [];
                    print(wifiNetwork.length);
                    if (wifiNetwork.length > 0)
                      return ListView.builder(
                          itemCount: wifiNetwork.length,
                          itemBuilder: (context, index) {
                            WifiNetwork wifi = wifiNetwork[index];
                            return new ListTile(
                              leading: Icon(Icons.signal_wifi_4_bar_sharp),
                              title: new Text(wifi.ssid),
                              trailing: wifi.capabilities.contains('WPA') ||
                                      wifi.capabilities.contains('WEP') ||
                                      wifi.capabilities.contains('PSK')
                                  ? Icon(Icons.lock)
                                  : null,
                              onTap: () async {
                                wifi.capabilities.contains('WPA2') ||
                                        wifi.capabilities.contains('WPS') ||
                                        wifi.capabilities.contains('WPA') ||
                                        wifi.capabilities.contains('WEP') ||
                                        wifi.capabilities.contains('PSK')
                                    ? _displayTextInputDialog(
                                        context, wifi.ssid)
                                    : connectWifiHotpot(context, wifi.ssid);
                              },
                            );
                          });
                    if (wifiNetwork.length == 0)
                      return gpsTurnOff(context);
                    else
                      return gpsTurnOff(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget gpsTurnOff(BuildContext context) {
    var _lang = AppLocalizeService.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/no_access.svg',
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              placeholderBuilder: (context) => Center(),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
              child: Text(
                _lang.translate('wifi_no_gps_warning'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 35)),
              ),
              child: Text(_lang.translate('enable_gps')),
              onPressed: () {
                loc.Location locationR = loc.Location();
                locationR.requestService();
              }),
        ],
      ),
    );
  }
}
