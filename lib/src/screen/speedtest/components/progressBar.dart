import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/speedtest/constants/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar {
  LinearPercentIndicator showBar(double displayPer) {
    return new LinearPercentIndicator(
      width: 300,
      lineHeight: 24.0,
      percent: displayPer / 100.0,
      center: Text(
        displayPer.toStringAsFixed(1) + "%",
        style: new TextStyle(
          fontSize: 14.0,
          color: txtCol,
        ),
      ),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: progressBg,
      progressColor: progressFill,
    );
  }
}
