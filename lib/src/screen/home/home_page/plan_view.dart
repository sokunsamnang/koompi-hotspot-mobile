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
              // margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[900],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).copyWith().size.height / 2,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                      color: Colors.blueGrey[900],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Username: koompi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Medium'
                              ),
                            ),
                            Text(
                              '5000រ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Medium'
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                  Container(
                    // width: MediaQuery.of(context).copyWith().size.height / 2,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Device: 2 Devices',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Medium'
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Expiration: 30 Days',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Medium'
                            ),
                          ),
                        ],
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