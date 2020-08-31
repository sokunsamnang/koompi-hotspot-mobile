/* Dialog of response from server */
import 'package:flutter/material.dart';

Future dialog(
  BuildContext context, 
  var text, 
  var title,
  {FlatButton action, Color bgColor}
) async {
  var result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Align(
          alignment: Alignment.center,
          child: title,
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: text,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(text),
          ), 
          action
        ],
      );
    }
  );
  return result;
}

Widget textMessage({String text: "Message", fontSize: 20.0}){
  return FittedBox(
    child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
  );
}

Widget textAlignCenter({String text: ""}){
  return Text(text, textAlign: TextAlign.center);
}