import 'package:flutter/material.dart';

class LidarrSearchData {
    String title;
    String foreignArtistId;
    String overview;
    String artistType;
    int tadbId;
    List<dynamic> links;
    List<dynamic> images;

    LidarrSearchData({
        @required this.title,
        @required this.foreignArtistId,
        @required this.overview,
        @required this.tadbId,
        @required this.artistType,
        @required this.links,
        @required this.images,
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

    String get discogsLink {
        for(var link in links) {
            if(link['name'] == 'discogs') {
                return link['url'];
            }
        }
        return '';
    }
}
