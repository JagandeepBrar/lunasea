import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrTrackData {
  String title;
  bool explicit;
  bool hasFile;
  String trackNumber;
  int trackID;
  int duration;

  LidarrTrackData({
    required this.trackID,
    required this.title,
    required this.trackNumber,
    required this.duration,
    required this.explicit,
    required this.hasFile,
  });

  TextSpan file(bool monitored) {
    if (hasFile) {
      return const TextSpan(
        text: 'Downloaded',
        style: TextStyle(
          color: LunaColours.accent,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );
    } else {
      return const TextSpan(
        text: 'Not Downloaded',
        style: TextStyle(
          color: LunaColours.red,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );
    }
  }
}
