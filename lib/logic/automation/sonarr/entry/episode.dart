import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:intl/intl.dart';

class SonarrEpisodeEntry {
    String episodeTitle;
    String airDate;
    String quality;
    int seasonNumber;
    int episodeNumber;
    int episodeID;
    int size;
    bool isMonitored;
    bool hasFile;
    bool cutoffNotMet;
    SonarrQueueEntry queue;
    bool isSelected = false;

    SonarrEpisodeEntry(
        this.episodeTitle,
        this.seasonNumber,
        this.episodeNumber,
        this.airDate,
        this.episodeID,
        this.isMonitored,
        this.hasFile,
        this.quality,
        this.cutoffNotMet,
        this.size,
        this.queue,
    );

    String get sizeString {
        double val = size.toDouble();
        int counter = 0;
        while(val > 1024) {
        counter++;
        val = val/1024;
        }
        return '${val.toStringAsFixed(2)} ${Constants.BYTE_SIZES[counter]}';
  }

    DateTime get airDateObject {
        if(airDate != null) {
            return DateTime.tryParse(airDate)?.toLocal();
        }
        return null;
    }

    String get airDateString {
        if(airDateObject != null) {
            return DateFormat('MMMM dd, y').format(airDateObject);
        }
        return 'Unknown Air Date';
    }

    bool get hasAired {
        if(airDateObject == null) {
            return false;
        }
        return airDateObject.isBefore(DateTime.now());
    }

    TextSpan get subtitle {
        if(queue != null) {
            return TextSpan(
                text: '${queue?.status ?? 'Unknown'} (${(100-((queue?.sizeLeft ?? 0)/(queue?.size ?? 0))*100).abs().toInt()}%)',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                ),
            );
        }
        if(hasFile) {
            if(cutoffNotMet) {
                return TextSpan(
                    text: '$quality - $sizeString',
                    style: TextStyle(
                        color: isMonitored ? Colors.orange : Colors.orange.withOpacity(0.30),
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            return TextSpan(
                text: '$quality - $sizeString',
                style: TextStyle(
                    color: isMonitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30),
                    fontWeight: FontWeight.bold,
                ),
            );
        }
        if(hasAired) {
            return TextSpan(
                text: 'Missing',
                style: TextStyle(
                    color: isMonitored ? Colors.red : Colors.red.withOpacity(0.30),
                    fontWeight: FontWeight.bold,
                ),
            );
        }
        return TextSpan(
            text: 'Unaired',
            style: TextStyle(
                color: isMonitored ? Colors.blue : Colors.blue.withOpacity(0.30),
                fontWeight: FontWeight.bold,
            ),
        );
    }
}
