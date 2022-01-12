import 'package:flutter/material.dart';
import 'package:koompi_hotspot/screens/speedtest/constants/palette.dart';

Text showLabel(String label, double speed, String unit) {
  String displaySpeed = speed.toStringAsFixed(2);
  return Text(
    '$label: $displaySpeed $unit',
    style: TextStyle(
      color: txtCol,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}
