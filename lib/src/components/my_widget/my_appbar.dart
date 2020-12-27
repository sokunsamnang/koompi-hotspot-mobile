import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/my_widget/my_text.dart';

class MyAppBar extends StatelessWidget{

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry margin;
  final String title;
  final Function onPressed;

  MyAppBar({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.margin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    @required this.title,
    this.onPressed
  });
  
  Widget build(BuildContext context) {
    return Container(
      // height: 65.0, 
      width: MediaQuery.of(context).size.width, 
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            /* Menu Icon */
            alignment: Alignment.center,
            // padding: edgePadding,
            // padding: EdgeInsets.only(left: 30),
            iconSize: 40.0,
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: onPressed,
          ),
          MyText(
            color: "#FFFFFF",
            text: title,
            left: 15,
            fontSize: 22,
          )
        ],
      )
    );
  }
}