import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/osm/components/constants.dart';

class ExpandableContent extends StatelessWidget {
  final String locate;

  ExpandableContent(this.locate);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kDefaultRadius)),
                  elevation: 2,
                  child: ReuseInkwell.getItem(
                      locate ?? 'Location', Icons.location_on, () {}),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Nearby',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ));
  }
}

class ReuseInkwell{
  static getItem(String title,IconData icon,Function onTap){
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        dense: true,
      ),
    );
  }
}