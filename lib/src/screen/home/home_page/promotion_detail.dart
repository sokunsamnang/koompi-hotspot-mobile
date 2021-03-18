import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/models/model_promotion.dart';

class PromotionScreen extends StatefulWidget {
  final Promotion promotion;
  final int index;

  PromotionScreen({this.promotion, this.index});

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('promotion'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(
            initialPage: promotions.indexOf(promotions[widget.index])
          ),
          scrollDirection: Axis.horizontal,
          itemCount: promotions.length,
          itemBuilder: (BuildContext context, int index) {
          Promotion promotion = promotions[index];
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: promotion.imageUrl,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage(promotion.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          promotion.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.info,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              promotion.category,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: promotion.description,
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }
}
