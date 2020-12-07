import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

class MyLocationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocationViewState();
  }
}

class MyLocationViewState extends State<MyLocationView>
    with TickerProviderStateMixin {
  ///=========================================[Declare]=============================================
  /// Controller for FloatActionButtons
  AnimationController _controller;

  /// Icons List For FloatActionButtons
  List<IconData> icons = [
    Icons.gps_fixed,
    // Icons.favorite,
    // Icons.content_copy,
  ];

  final geolocator = Geolocator()..forceAndroidLocationManager = true;

  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 0);

  double lat;
  double long;
  double _outZoom = 3.0;
  double _inZoom = 15.0;
  MapController mapController = new MapController();
  final favoritePlaceController = TextEditingController();
  String placeName;
  bool _isLive = false;
  /// Is camera Position Lock is enabled default false
  bool isMoving = false;

  /// Show a Alert Dialog
  void _showDialog(String body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Permission"),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Settings"),
                onPressed: () {
                  AppSettings.openLocationSettings();

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  ///=========================================[initState]=============================================

  initState() {
    if (long == null || lat == null) {
      ///checks GPS then call localize
      _checkGPS();
    } else {
      /// GPS is Okay just localize
      localize();
    }

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _moveCamera() {
    isMoving = true;
    if (lat != null && long != null) {
      mapController.onReady.then((result) {
        mapController.move(LatLng(lat, long), _inZoom);
        icons[0] = Icons.gps_fixed;
      });
    }
  }

  _checkGPS() async {
    /// when back to this tab should get previous position from libraries
    if (lat != null && long != null) {
      setState(() {
        lat = lat;
        long = long;
        // placeName = positionName();
      });
    }
    var status = await geolocator.checkGeolocationPermissionStatus();
    bool isGPSOn = await geolocator.isLocationServiceEnabled();
    if (status == GeolocationStatus.granted && isGPSOn) {
      /// Localize Position
      localize();

      _moveCamera();
    } else if (isGPSOn == false) {
      _showDialog("Turn On Your GPS");
      localize();
      _moveCamera();
    } else if (status != GeolocationStatus.granted) {
      // await PermissionHandler()
      //     .requestPermissions([PermissionGroup.locationWhenInUse]);
      localize();
      _moveCamera();
    } else {
      _showDialog("Turn On Your GPS");
      // await PermissionHandler()
      //     .requestPermissions([PermissionGroup.locationWhenInUse]);
      localize();
      _moveCamera();
    }
  }

  void localize() {
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      /// To not call setState when this state is not active
      if (!mounted) {
        return;
      }
      if (mounted) {
        setState(() {
          this.lat = position.latitude;
          this.long = position.longitude;
          long = long;
          lat = lat;
          if (isMoving == true) {
            mapController.move(LatLng(lat, long), _inZoom);
            icons[0] = Icons.gps_fixed;
          }
        });
      }
    });
  }


  ///to show a snackBar after copy
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();


  ///=========================================[BUILD]=============================================

  @override
  Widget build(BuildContext context) {
    Widget _loadBuild() {
      ///[Position Found Render Marker]
      if (lat != null && long != null) {
        return Expanded(
          child: new FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              center: new LatLng(lat, long),
              zoom: _inZoom,
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
              ),
              new MarkerLayerOptions(
                markers: [
                  ///========[Live Location]==========
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: new LatLng(lat, long),
                    builder: (ctx) => new Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.adjust,
                                color: Colors.blue,
                              ),
                              onPressed: null),
                        ],
                      ),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: Colors.blue[100].withOpacity(0.7),
                      ),
                    ),
                  ),
                  
                  ///=================[Marker Location]=====================
                  Marker(
                    width: 50,
                    height: 50,
                    // anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(11.567623, 104.926502),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    width: 50,
                    height: 50,
                    // anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(11.563913, 104.924599),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        setState(() {
          icons[0] = Icons.gps_not_fixed;
        });

        ///[Position Not Found/Not Found yet]
        return Expanded(
          child: new FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              zoom: _outZoom,
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
              ),
            ],
          ),
        );
      }
    }

    ///Float Action Button Background Color
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    /// Show Snack Bar Messages
    _showSnackBar(String message) {
      final snackBar =
          SnackBar(content: Text('$message'), duration: Duration(seconds: 1));
      mykey.currentState.showSnackBar(snackBar);
    }

    /// returned build
    return Scaffold(
      key: mykey,
      body: Column(
        children: <Widget>[
          _loadBuild(),
        ],
      ),

      ///floatingActionButtons
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: backgroundColor,
        mini: false,
        child: Icon(icons[0], color: foregroundColor,),
        onPressed: () {
          ///onPress LockCamera button
          if (isMoving == false) {
            /// if position not null [LatLng]
            if (lat != null && long != null) {
              setState(() {
                ///change icon to lockedCamera
                icons[0] = Icons.gps_fixed;
                isMoving = true;
              });
              mapController.move(LatLng(lat, long), _inZoom);
              _showSnackBar("Camera Lock Enabled!");
            } else {
              _showSnackBar("Couldn't get your Position!");
            }
          } else {
            setState(() {
              icons[0] = Icons.gps_not_fixed;
              isMoving = false;
            });

            _showSnackBar("Camera Lock Disabled!");
          }
        },
      ),
    );
  }
}
