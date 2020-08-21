import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koompi_hotspot/src/models/model_map_pin_pill_info.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  GoogleMapController _controller;
  Position position;

  Widget _child = Center();
  
  BitmapDescriptor _sourceIcon;

  double _pinPillPosition = -100;

  PinData _currentPinData = PinData(
      pinPath: '',
      address: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  PinData _sourcePinInfo1;
  PinData _sourcePinInfo2;

  void _setSourceIcon() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/destination_map_marker.png');
  }


  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('sisowath'),
          position: LatLng(11.563913, 104.924599),
          infoWindow: InfoWindow(title: 'Preah Sisowath High School'),
          icon: _sourceIcon,
          onTap: () {
            setState(() {
              _currentPinData = _sourcePinInfo1;
              _pinPillPosition = 40;
            });
          }),

      Marker(
          markerId: MarkerId('koompi'),
          position: LatLng(11.567623, 104.926502),
          infoWindow: InfoWindow(title: 'KOOMPI Boran & Research Lab'),
          icon: _sourceIcon,
          onTap: () {
            setState(() {
              _currentPinData = _sourcePinInfo2;
              _pinPillPosition = 40;
            });
          })
    ].toSet();
  }

  @override
  void initState() {
    _getCurrentLocation();
    _setSourceIcon();
    super.initState();
  }

  Widget _mapWidget() {
    return GoogleMap(
      compassEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      tiltGesturesEnabled: false,
      mapType: MapType.terrain,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 12.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _setStyle(controller);
        _setMapPins();
      },
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -100;
        });
      },
    );
  }

  void _setMapPins() {
    _sourcePinInfo1 = PinData(
      pinPath: 'assets/images/destination_map_marker.png',
      locationName: "Preah Sisowath High School",
      address: "Rue Pasteur No. 51, Phnom Penh",
      labelColor: Colors.blue,
    );

    _sourcePinInfo2 = PinData(
      pinPath: 'assets/images/destination_map_marker.png',
      locationName: "KOOMPI Boran & Research Lab",
      address: "Preah Ang Yukanthor Street (19), Phnom Penh",
      labelColor: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: <Widget>[
        _child,
        AnimatedPositioned(
          bottom: _pinPillPosition,
          right: 35,
          left: 35,
          duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLocationInfo(),
                  _buildMarkerType()
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildLocationInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentPinData.locationName,
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 2.5),
            Text(
              _currentPinData.address,
              style: TextStyle(fontSize: 12)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkerType() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Image.asset(
        _currentPinData.pinPath,
        width: 50,
        height: 50,
      ),
    );
  }
}

