/* Dialog of response from server */
import 'package:flutter/material.dart';


/* Loading Progress */
Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(Colors.blueAccent)
    ),
  );
}

/* Progress */
Widget progress({String content}) {
  return Material(
    color: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent)
            ),
            content == null 
            ? Container() 
            : Padding(
              child: textScale(
                text: content,
                hexaColor: "#FFFFFF"
              ),
              padding: EdgeInsets.only(bottom: 10.0, top: 10.0)
            ),
          ],
        )
      ],
    ),
  );
}

void dialogLoading(BuildContext context, {String content}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return progress(content: content);
    });
}

Widget textScale({
  String text,
  double fontSize = 18.0,
  String hexaColor = "#1BD2FA",
  TextDecoration underline,
  BoxFit fit = BoxFit.contain,
  FontWeight fontWeight}
) {
  return FittedBox(
    fit: fit,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.blueAccent,
        decoration: underline,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    ),
  );
}