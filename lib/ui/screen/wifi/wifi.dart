import 'package:geolocator/geolocator.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wifi_connector/wifi_connector.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiConnect extends StatefulWidget {
  @override
  _WifiConnectState createState() => _WifiConnectState();
}
class _WifiConnectState extends State<WifiConnect> {

  var geoLocator = Geolocator();
  bool serviceEnabled;
  LocationPermission permission;


  TextEditingController _passwordController = TextEditingController();
  Timer timer;
  void initState(){
    super.initState();
    _checkGPS();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){
      WiFiForIoTPlugin.getSSID();
    }));
  }

  void dispose(){
    timer?.cancel();
    _passwordController.clear();
    super.dispose();
  }
  


  // _onAlertWithCustomContentPressed(BuildContext context, String getSSID) {
  //   void clearTextPopDialog(){
  //     Navigator.pop(context);
  //     _passwordController.clear();
  //   }
  //   // Initially password is obscure
  //   bool _obscureText = true;

  //   void _togglePasswordVisibility() {
  //     setState(() {
  //       _obscureText = !_obscureText;
  //     });
  //   }

  //   Alert(
  //     onWillPopActive: true,
  //     closeFunction: clearTextPopDialog,
  //     context: context,
  //     title: '$getSSID',
  //     content: Column(
  //       children: <Widget>[
  //         TextFormField(
  //           controller: _passwordController,
  //           obscureText: _obscureText,
  //           decoration: InputDecoration(
  //             icon: Icon(Icons.lock),
  //             labelText: 'Password',
  //             suffixIcon: GestureDetector(
  //               onTap: _togglePasswordVisibility,
  //               child: _obscureText
  //                   ? Icon(Icons.visibility_off)
  //                   : Icon(Icons.visibility),
  //             ),
  //           ),
            
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         onPressed: () async {
  //           print(_passwordController.text);
  //           // WiFiForIoTPlugin.connect(
  //           //   ssid,
  //           //   password: _passwordController.text,
  //           //   joinOnce: false,
  //           //   withInternet: false,
  //           //   security: NetworkSecurity.WPA
  //           // );
  //           WifiConnector.connectToWifi(
  //             ssid: getSSID, 
  //             password: _passwordController.text, 
  //             // isWEP: true
  //           );
  //           Navigator.of(context).pop();
  //           _passwordController.clear();
  //         },
  //         child: Text(
  //           "CONNECT",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //       )
  //     ]).show();
  // }

  Future<void> _displayTextInputDialog(BuildContext context, String ssid) async {
    // Initially password is obscure
    bool _obscureText = true;

    // Toggles the password show status
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }
    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            // backgroundColor: Col,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text('Enter password $ssid', textAlign: TextAlign.center,),
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
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
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
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text('CANCEL'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _passwordController.clear(),
                    }
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text('OK'),
                    onPressed: () => {
                      print(ssid),
                      print(_passwordController.text),
                      // WiFiForIoTPlugin.connect(
                      //   ssid,
                      //   password: _passwordController.text,
                      //   joinOnce: false,
                      //   withInternet: false,
                      //   security: NetworkSecurity.WPA
                      // );
                      WifiConnector.connectToWifi(
                        ssid: ssid, 
                        password: _passwordController.text, 
                        // isWEP: true
                      ),
                      Navigator.of(context).pop(),
                      _passwordController.clear(),
                    }
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  // Future<void> _displayTextInputDialog(BuildContext context, String ssid) async {
  //   // Initially password is obscure
  //   bool _obscureText = true;

  //   // Toggles the password show status
  //   void _toggle() {
  //     setState(() {
  //       _obscureText = !_obscureText;
  //     });
  //   }
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child:AlertDialog(
  //           title: new Text('Enter password $ssid'),
  //           content: TextFormField(
  //             obscureText: _obscureText,
  //             controller: _passwordController,
  //             onSaved: (val) => _passwordController.text = val,
  //             keyboardType: TextInputType.visiblePassword,
  //             decoration: InputDecoration(
  //               fillColor: Colors.grey[100],
  //               filled: true,
  //               hintText: 'Password',
  //               hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.black),
  //                 borderRadius: BorderRadius.all(Radius.circular(12.0))
  //               ),
  //               suffixIcon: GestureDetector(
  //                 onTap: () {
  //                   _toggle();
  //                 },
  //                 child: Icon(
  //                   _obscureText ? Icons.visibility_off : Icons.visibility,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           actions: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 new FlatButton(
  //                   child: new Text('CANCEL'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     _passwordController.clear(); 
  //                   },
  //                 ),
  //                 new FlatButton(
  //                   onPressed: () async {
  //                     print(ssid);
  //                     print(_passwordController.text);
  //                     // WiFiForIoTPlugin.connect(
  //                     //   ssid,
  //                     //   password: _passwordController.text,
  //                     //   joinOnce: false,
  //                     //   withInternet: false,
  //                     //   security: NetworkSecurity.WPA
  //                     // );
  //                     WifiConnector.connectToWifi(
  //                       ssid: ssid, 
  //                       password: _passwordController.text, 
  //                       // isWEP: true
  //                     );
  //                     Navigator.of(context).pop();
  //                     _passwordController.clear();
  //                   },
  //                   child: new Text('CONNECT'))
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = List<WifiNetwork>();
    }
    print('wifi list: ${htResultNetwork.length}');
    return htResultNetwork;
  }

  void _checkGPS() async {

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // var status = await geolocator.checkGeolocationPermissionStatus();
    // bool isGPSOn = await geolocator.isLocationServiceEnabled();
    var _lang = AppLocalizeService.of(context);
    if (!serviceEnabled) {
      await Components.dialogGPS(
        context,
        Text(_lang.translate('turn_on_gps'), textAlign: TextAlign.center),
        Text(_lang.translate('location_permission'), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      );
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // await PermissionHandler()
      //     .requestPermissions([PermissionGroup.locationWhenInUse]);
      if(permission == LocationPermission.denied){
        await Components.dialogGPS(
          context,
          Text(_lang.translate('turn_on_gps'), textAlign: TextAlign.center),
          Text(_lang.translate('location_permission'), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        );
      }
    } else {
      loadWifiList();
    }
  }


  Widget isConnected() {
    return FutureBuilder(
      future: WiFiForIoTPlugin.getSSID(),
      builder: (BuildContext context, AsyncSnapshot<String> ssid) {
        return ssid.data != '<unknown ssid>' 
          ? 
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.signal_wifi_4_bar_sharp, color: Colors.green),
                title: Text('${ssid.data}',),
                trailing: Text('Connected', style: TextStyle(color: Colors.green),),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.grey[300],
              )
            ],
          ) 
          : 
          Container();
      }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wi-Fi", 
              style: TextStyle(
                color: Colors.black, 
                fontFamily: "Poppins-Bold",
                fontSize: 18,
              ),
            ),
            FlatButton.icon(
              onPressed: () async{
                setState(() {
                  _checkGPS();
                });
              },
              icon: Icon(Icons.search),
              label: Text('Scan'),
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
                  return ListView.builder(
                    itemCount: wifiNetwork.length,
                    itemBuilder: (context, index) {
                      WifiNetwork wifi = wifiNetwork[index];
                      return new ListTile(
                        leading: Icon(Icons.signal_wifi_4_bar_sharp),
                        title: new Text(wifi.ssid),
                        trailing: wifi.capabilities.contains('WPA') 
                                  ||
                                  wifi.capabilities.contains('WEP') 
                                  ||
                                  wifi.capabilities.contains('PSK')
                                  ? Icon(Icons.lock)
                                  : null,
                        onTap: () async {
                          print(wifi.ssid);
                          print(_passwordController.text);
                          wifi.capabilities.contains('WPA') 
                          ||
                          wifi.capabilities.contains('WEP') 
                          ||
                          wifi.capabilities.contains('PSK') 
                          ?                    
                          _displayTextInputDialog(context, wifi.ssid)
                          // _onAlertWithCustomContentPressed(context, wifi.ssid)
                          :
                          // WiFiForIoTPlugin.connect(
                          //   wifi.ssid,
                          //   joinOnce: false,
                          //   withInternet: false,
                          //   security: NetworkSecurity.NONE
                          // );
                          await WifiConnector.connectToWifi(ssid: wifi.ssid);
                        },
                      );
                  });
              }),
            )
          ],
        ),
      ),
    );
  }
}