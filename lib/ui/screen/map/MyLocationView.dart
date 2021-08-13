import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;

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

  final Geolocator geolocator = Geolocator();


  double lat;
  double long;
  double _outZoom = 3.0;
  double _inZoom = 15.0;
  double _maxZoom = 18.0;
  double _minZoom = 5.0;
  MapController mapController = new MapController();
  /// Is camera Position Lock is enabled default false
  bool isMoving = false;

  final PopupController _popupController = PopupController();
  
  // Marker Map
  List<LatLng> _latLngList = [
    // S'ang school
    LatLng(11.357523855156012, 105.00719501166897),

    // Boran 
    LatLng(11.567623, 104.926502),

    // NIPTICT
    LatLng(11.65482898034104, 104.9113345380725),
  ];
  List<Marker> _markers = [];



  ///=========================================[initState]=============================================
  
  @override
  void initState() {
    super.initState();
    AppServices.noInternetConnection(mykey);
    _markers = _latLngList
    .map((point) => Marker(
          point: point,
          width: 50,
          height: 50,
          builder: (context) => Image.asset(
            'assets/images/KOOMPI-Hotspot-Point.png',
          ),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ))
    .toList();

    if (long == null || lat == null) {
      ///checks GPS then call localize
      _checkGPS();
      localize();
      _moveCamera();
    }

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _checkGPS() async {
    var status = await Geolocator.checkPermission();
    bool isGPSOn = await Geolocator.isLocationServiceEnabled();
    if (status == LocationPermission.denied && !isGPSOn) {
      loc.Location locationR = loc.Location();
      locationR.requestService();
    } 
  }

  void localize() {
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high).listen((Position position) {
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
    var _lang = AppLocalizeService.of(context);
    Widget _loadBuild() {
      ///[Position Found Render Marker]
      if (lat != null && long != null) {
        return Expanded(
          child: new FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              center: new LatLng(lat, long),
              zoom: _inZoom,
              maxZoom: _maxZoom,
              minZoom: _minZoom,
              plugins: [
                new MarkerClusterPlugin(),
              ],
              onTap: (_) => _popupController.hidePopup(),
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
                ],
              ),
              new MarkerClusterLayerOptions(
                maxClusterRadius: 190,
                disableClusteringAtZoom: 16,
                size: Size(50, 50),
                fitBoundsOptions: FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: _markers,
                polygonOptions: PolygonOptions(
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderStrokeWidth: 0.0),
                popupOptions: PopupOptions(
                    popupSnap: PopupSnap.markerTop,
                    popupController: _popupController,
                    popupBuilder: (_, marker) => Container()
                ),
                builder: (context, markers) {
                  return Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                    child: Text('${markers.length}'),
                  );
                },
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
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              center: new LatLng(11.5564, 104.9282),
              zoom: _outZoom,
              minZoom: _minZoom,
              maxZoom: _maxZoom
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
      final snackBar =  SnackBar(content: Text('$message'), duration: Duration(seconds: 1));
     
      // ignore: deprecated_member_use
      mykey.currentState..showSnackBar(snackBar);
    }

    /// returned build
    return Scaffold(
      key: mykey,
      appBar: AppBar(
        title: Text('Fi-Fi Map', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        backgroundColor: Colors.white,  
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: false,
      ),
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
              _showSnackBar(_lang.translate('lock_camera'));
            } else {
              _showSnackBar(_lang.translate('no_position'));
            }
          } else {
            setState(() {
              icons[0] = Icons.gps_not_fixed;
              isMoving = false;
            });

            _showSnackBar(_lang.translate('unlock_camera'));
          }
        },
      ),
    );
  }
}