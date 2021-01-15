import 'package:flutter/material.dart';

Widget textAlignCenter({String text: ""}) {
  return Text(text, textAlign: TextAlign.center);
}

Widget warningTitleDialog() {
  return Text(
    'Oops...',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget titleDialog() {
  return Text(
    'Congratulation...!',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}