import 'package:geolocator/geolocator.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/utils/connectivity_status.dart';
import 'package:provider/provider.dart';
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
  void initState(){
    super.initState();
    _checkGPS();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => setState((){
      WiFiForIoTPlugin.getSSID();
    }));
  }


  @override
  void dispose(){
    super.dispose();
    timer?.cancel();
    _passwordController.clear();
  }
  
  Future<void> connectWifiHotpot(BuildContext context, String ssid) async {
    // WiFiForIoTPlugin.forceWifiUsage(false);
    dialogLoading(context);
    await WifiConnector.connectToWifi(
      ssid: ssid, 
    );
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
          child:AlertDialog(
            // backgroundColor: Col,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text('Enter Password: $ssid', textAlign: TextAlign.center,),
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
                    onPressed: () async {
                      // WiFiForIoTPlugin.forceWifiUsage(false);
                      dialogLoading(context);
                      await WifiConnector.connectToWifi(
                        ssid: ssid, 
                        password: _passwordController.text, 
                        isWEP: true
                      );
                      Navigator.of(context).pop();
                      _passwordController.clear();
                      Navigator.of(context).pop();
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

    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: connectionStatus == ConnectivityStatus.WiFi ? Row(
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
            TextButton.icon(
              onPressed: () async{
                setState(() {
                  _checkGPS();
                });
              },
              icon: Icon(Icons.search, color: primaryColor),
              label: Text('Scan',style: TextStyle(color: primaryColor)),
            ),
          ],
        )
        :
        Text(
          "Wi-Fi", 
          style: TextStyle(
            color: Colors.black, 
            fontFamily: "Poppins-Bold",
            fontSize: 18,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: connectionStatus == ConnectivityStatus.WiFi ? Container(
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
                          wifi.capabilities.contains('WPA2')
                            || 
                            wifi.capabilities.contains('WPS')
                            || 
                            wifi.capabilities.contains('WPA') 
                            ||
                            wifi.capabilities.contains('WEP') 
                            ||
                            wifi.capabilities.contains('PSK') 
                            ?                    
                            _displayTextInputDialog(context, wifi.ssid)
                            :
                            connectWifiHotpot(context, wifi.ssid);
                        },
                      );
                  });
              }),
            )
          ],
        ),
      )
      :
      wifiTurnOff(context),
    );
  }

  Widget wifiTurnOff(BuildContext context){
    return Container(
      child: Container(
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
            SizedBox(height: 25),
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
                  EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                ),
              ),
              child: Text('Turn on Wi-Fi'),
              onPressed: () => {
                WiFiForIoTPlugin.setEnabled(true)
              }
            ),
          ],
        ),
      )
    );
  }
}