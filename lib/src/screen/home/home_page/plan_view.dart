import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/behavior.dart';

class PlanView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
      children: <Widget>[
        CarouselSlider(
          height: 180.0,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: false,
          viewportFraction: 0.85,
          items: [
            Container(
              width: MediaQuery.of(context).copyWith().size.height / 2,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[900],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Username: koompi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Device: 2 Devices',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Expiration: 365 Days',
                    style: TextStyle(
                      color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}