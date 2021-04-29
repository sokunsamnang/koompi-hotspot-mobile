import 'package:geolocator/geolocator.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:wifi_connector/wifi_connector.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiConnect extends StatefulWidget {
  @override
  _WifiConnectState createState() => _WifiConnectState();
}
class _WifiConnectState extends State<WifiConnect> {

  bool _isEnabled = false;
  bool _isConnected = false;
  List<WifiNetwork> _htResultNetwork;
  final geolocator = Geolocator()..forceAndroidLocationManager = true;

  void initState(){
    super.initState();
    setState(() {
      _checkGPS();
    });
  }

  void dispose(){
    super.dispose();
    _passwordController.clear();
  }
  TextEditingController _passwordController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context, String ssid) async {
    // Initially password is obscure
    bool _obscureText = true;

    // Toggles the password show status
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text('Enter password $ssid'),
            content: TextFormField(
              obscureText: _obscureText,
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                    onPressed: () async {
                      print(ssid);
                      print(_passwordController.text);
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
                      );
                      Navigator.of(context).pop();
                      _passwordController.clear();
                    },
                    child: new Text('CONNECT'))
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
      htResultNetwork = List<WifiNetwork>();
    }
    print('wifi list: ${htResultNetwork.length}');
    return htResultNetwork;
  }

  _checkGPS() async {

    var status = await geolocator.checkGeolocationPermissionStatus();
    bool isGPSOn = await geolocator.isLocationServiceEnabled();
    var _lang = AppLocalizeService.of(context);
    if (status == GeolocationStatus.granted && isGPSOn) {
      loadWifiList();
    } else if (isGPSOn == false) {
      _showDialog(_lang.translate('turn_on_gps'));

    } else if (status != GeolocationStatus.granted) {
      loadWifiList();
    } else {
      _showDialog(_lang.translate('turn_on_gps'));

    }
  }

 /// Show a Alert Dialog
  void _showDialog(String body) {
    var _lang = AppLocalizeService.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_lang.translate('location_permission')),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                child: Text(_lang.translate('cancel')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(_lang.translate('setting')),
                onPressed: () {
                  AppSettings.openLocationSettings();

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
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
                leading: Icon(Icons.signal_wifi_4_bar_sharp),
                title: Text('${ssid.data}',),
                trailing: Text('Connected'),
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
                // _htResultNetwork = await loadWifiList();
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
                if(snapshot.connectionState != ConnectionState.done) {
                  // return: show loading widget
                }
                if(snapshot.hasError) {
                  // return: show error widget
                }
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