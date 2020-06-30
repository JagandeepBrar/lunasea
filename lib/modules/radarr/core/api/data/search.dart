import 'package:flutter/material.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSearchData {
    String title;
    String titleSlug;
    String overview;
    String status;
    int year;
    int tmdbId;
    List<dynamic> images;

    RadarrSearchData({
        @required this.title,
        @required this.titleSlug,
        @required this.overview,
        @required this.year,
        @required this.tmdbId,
        @required this.images,
        @required this.status,
    });

    String get bannerURI {
        for(var image in images) {
            if(image['coverType'] == 'banner') {
                return image['url'];
            }
        }
        return '';
    }

    String get fanartURI {
        for(var image in images) {
            if(image['coverType'] == 'fanart') {
                return image['url'];
            }
        }
        return '';
    }

    String get posterURI {
        for(var image in images) {
            if(image['coverType'] == 'poster') {
                return image['url'];
            }
        }
        return '';
    }

    String get formattedStatus {
        RadarrAvailability _result = RadarrConstants.MINIMUM_AVAILBILITIES.firstWhere((availability) => availability.id == status, orElse: () => null);
        return _result.name ?? 'Unknown Status';
    }
}