
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

final List<Map> robot = [
  {
    "name": "Image1",
    "image": 'assets/images/image1.png',
    "routeName": "/image1Dashboard"
  },
  {
    "name": "Image2",
    "image": 'assets/images/image2.png',
    "routeName": "/image2Dashboard"
  },
  {
    "name": "Simulation",
    "image": 'assets/images/sim.png',
    "routeName": "/simDashboard"
  },
];

final List<Widget> imageSliders = robot
    .map((item) => new Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(item["image"], fit: BoxFit.cover, width: 700.0),
                    Positioned(
                      bottom: 0.0,
                      // left: 0.0,
                      // right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(0, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${item["name"]}',
                          // '${nameList[imgList.indexOf(item)]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class MyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // margin: EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400,
              // aspectRatio: 2,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: .5,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
            ),
            items: imageSliders,
          )),
    );
  }
}