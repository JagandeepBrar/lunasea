import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/core.dart';

class SonarrUpcomingEntry {
    String seriesTitle;
    String episodeTitle;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    int id;
    String airTime;
    String filePath;
    bool hasFile;

    SonarrUpcomingEntry(
        this.seriesTitle,
        this.episodeTitle,
        this.seasonNumber,
        this.episodeNumber,
        this.seriesID,
        this.id,
        this.airTime,
        this.hasFile,
        this.filePath,
    );

    DateTime get airTimeObject {
        return DateTime.tryParse(airTime)?.toLocal();
    }

    String get airTimeString {
        if(airTimeObject != null) {
            return DateFormat('KK:mm\na').format(airTimeObject);
        }
        return 'N/A';
    }

    String posterURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/poster.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/poster-500.jpg?apikey=${values[2]}';
    }

    String fanartURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/fanart.jpg?apikey=${values[2]}'; 
        }
        return '${values[1]}/api/mediacover/$seriesID/fanart-360.jpg?apikey=${values[2]}'; 
    }

    String bannerURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/banner.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/banner-70.jpg?apikey=${values[2]}';
    }

    String get seasonEpisode {
        return 'Season $seasonNumber Episode $episodeNumber';
    }

    TextSpan get downloaded {
        if(hasFile) {
            return TextSpan(
                text: 'Downloaded ($filePath)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            );
        }
        return TextSpan(
            text: 'Not Downloaded',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
            ),
        );
    }
}