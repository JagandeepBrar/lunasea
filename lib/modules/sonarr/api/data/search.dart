import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSearchData {
    String title;
    String overview;
    int seasonCount;
    int tvdbId;
    int tvMazeId;
    int year;
    String imdbId;
    String status;
    List<dynamic> images;
    List<dynamic> seasons;

    SonarrSearchData({
        @required this.title,
        @required this.overview,
        @required this.seasonCount,
        @required this.status,
        @required this.images,
        @required this.seasons,
        @required this.tvdbId,
        @required this.tvMazeId,
        @required this.imdbId,
        @required this.year,
    });

    String get titleSlug {
        return title.lsSlugs_ConvertToSlug();
    }

    String get seasonCountString {
        return seasonCount == 1 ? '$seasonCount Season' : '$seasonCount Seasons';
    }

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
}