import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:koompi_hotspot/src/screen/osm/components/constants.dart';

class ZoomButtons extends StatelessWidget {
  
  final MapController _mapController;

  ZoomButtons(this._mapController);

   Future<void> zoomIn() async {
    final z = _mapController.zoom + 1;
    if (z < 20.0) {
      print(z);
      _mapController.move(_mapController.center, z);
    } else {
      return null;
    }
  }

  Future<void> zoomOut() async {
    final z = _mapController.zoom - 1;
    _mapController.move(_mapController.center, z);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 100, right: 30),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => zoomIn(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                          color: Colors.white),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.add,
                        color: kDefaultColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => zoomOut(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                          color: Colors.white),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.remove,
                        color: kDefaultColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}