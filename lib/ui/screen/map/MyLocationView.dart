import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:latlong2/latlong.dart';

class MyLocationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocationViewState();
  }
}

class MyLocationViewState extends State<MyLocationView> with TickerProviderStateMixin{

  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(11.65482898034104, 104.9113345380725),
          zoom: 13.0,
          interactiveFlags: InteractiveFlag.all,
          onTap: (_) => _popupLayerController.hidePopup(),
        ),
        children: <Widget>[
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: <String>['a', 'b', 'c'],
            ),
          ),
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              markers: <Marker>[
                MonumentMarker(
                  monument: Monument(
                    name: 'Innovation Center NIPTICT',
                    imagePath: 'https://cdn.lifestyleasia.com/wp-content/uploads/2019/10/21224220/Winer-Parisienne.jpg',
                    lat: 11.65482898034104,
                    long: 104.9113345380725,
                  ),
                ),
                // Marker(
                //   anchorPos: AnchorPos.align(AnchorAlign.top),
                //   point: LatLng(11.65482898034104, 104.9113345380725),
                //   height: Monument.size,
                //   width: Monument.size,
                //   builder: (BuildContext ctx) => Icon(Icons.shop),
                // ),
              ],
              popupController: _popupLayerController,
              popupBuilder: (_, Marker marker) {
                if (marker is MonumentMarker) {
                  return MonumentMarkerPopup(monument: marker.monument);
                }
                return Card(child: const Text('Not a monument'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Monument {
  static const double size = 25;

  Monument({
    this.name,
    this.imagePath,
    this.lat,
    this.long,
  });

  final String name;
  final String imagePath;
  final double lat;
  final double long;
}

class MonumentMarker extends Marker {
  MonumentMarker({this.monument})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: Monument.size,
          width: Monument.size,
          point: LatLng(monument.lat, monument.long),
          builder: (BuildContext ctx) => Image.asset('assets/images/KOOMPI-Hotspot-Point.png'),
        );

  final Monument monument;
}

class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({Key key, this.monument})
      : super(key: key);
  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(monument.imagePath, width: 200),
            Text(monument.name, textAlign: TextAlign.center,),
            // Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}