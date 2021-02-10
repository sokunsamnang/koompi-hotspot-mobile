import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/src/models/model_promotion.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/promotion_detail.dart';

class PromotionCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Text(
        //         'Top Destinations',
        //         style: TextStyle(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.bold,
        //           letterSpacing: 1.5,
        //         ),
        //       ),
        //       GestureDetector(
        //         onTap: () => print('See All'),
        //         child: Text(
        //           'See All',
        //           style: TextStyle(
        //             color: Theme.of(context).primaryColor,
        //             fontSize: 16.0,
        //             fontWeight: FontWeight.w600,
        //             letterSpacing: 1.0,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: promotions.length,
            itemBuilder: (BuildContext context, int index) {
              Promotion promotion = promotions[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PromotionScreen(
                      promotion: promotion,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // width: 150.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      // Positioned(
                      //   bottom: 15.0,
                      //   child: Container(
                      //     height: 120.0,
                      //     width: 200.0,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(12.0),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.all(10.0),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           // Text(
                      //           //   '${promotion.activities.length} activities',
                      //           //   style: TextStyle(
                      //           //     fontSize: 22.0,
                      //           //     fontWeight: FontWeight.w600,
                      //           //     letterSpacing: 1.2,
                      //           //   ),
                      //           // ),
                      //           Text(
                      //             promotion.description,
                      //             overflow: TextOverflow.ellipsis,
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: promotion.imageUrl,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image(
                                  height: 180.0,
                                  width: 180.0,
                                  image: AssetImage(promotion.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    promotion.city,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Medium',
                                      fontSize: 24.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.info,
                                        size: 10.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        promotion.country,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
