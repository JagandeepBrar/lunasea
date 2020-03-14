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
        @required this.trackID,
        @required this.title,
        @required this.trackNumber,
        @required this.duration,
        @required this.explicit,
        @required this.hasFile,
    });

    TextSpan file(bool monitored) {
        if(hasFile) {
            return TextSpan(
                text: 'Downloaded',
                style: TextStyle(
                    color: monitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30),
                    fontWeight: FontWeight.bold,
                ),
            );
        } else {
            return TextSpan(
                text: 'Not Downloaded',
                style: TextStyle(
                    color: monitored ? Colors.red : Colors.red.withOpacity(0.30),
                    fontWeight: FontWeight.bold,
                ),
            );
        }
    }
}