import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueData {
    final Map<String, dynamic> api = Database.currentProfileObject.getLidarr();
    String title;
    String sortTitle;
    String overview;
    String path;
    String artistType;
    int artistID;
    int qualityProfile;
    int metadataProfile;
    String quality;
    String metadata;
    bool monitored;
    bool albumFolders;
    Map statistics;
    List genres;
    List links;
    String foreignArtistID;
    int sizeOnDisk;

    LidarrCatalogueData({
        @required this.title,
        @required this.sortTitle,
        @required this.overview,
        @required this.path,
        @required this.artistID,
        @required this.monitored,
        @required this.statistics,
        @required this.qualityProfile,
        @required this.metadataProfile,
        @required this.quality,
        @required this.metadata,
        @required this.genres,
        @required this.links,
        @required this.albumFolders,
        @required this.foreignArtistID,
        @required this.sizeOnDisk,
        @required this.artistType,
    });

    String get genre {
        if(genres == null || genres.length == 0) {
            return 'Unknown';
        }
        return genres[0];
    }

    String subtitle(LidarrCatalogueSorting sorting) => '$albums\t•\t$tracks\n${_sortSubtitle(sorting)}';

    String _sortSubtitle(LidarrCatalogueSorting sorting) {
        switch(sorting) {
            case LidarrCatalogueSorting.metadata: return metadata;
            case LidarrCatalogueSorting.quality: return quality;
            case LidarrCatalogueSorting.tracks: return trackStats;
            case LidarrCatalogueSorting.type: return artistType;
            case LidarrCatalogueSorting.size:
            case LidarrCatalogueSorting.alphabetical: return sizeOnDisk?.lsBytes_BytesToString();
        }
        return '';
    }

    String get trackStats {
        String percentage = '(${(statistics['percentOfTracks'] as double).floor()}%)';
        return '${statistics['trackFileCount']}/${statistics['trackCount']} $percentage';
    }

    String get tracks {
        return statistics['trackCount'] == 1 ? '${statistics['trackCount']} Track' : '${statistics['trackCount']} Tracks';
    }

    String get albums {
        return statistics['albumCount'] == 1 ? '${statistics['albumCount']} Album' : '${statistics['albumCount']} Albums';
    }

    String get bandsintownURI {
        for(var link in links) {
            if(link['name'] == 'bandsintown') {
                return link['url'];
            }
        }
        return '';
    }

    String get discogsURI {
        for(var link in links) {
            if(link['name'] == 'discogs') {
                return link['url'];
            }
        }
        return '';
    }

    String get lastfmURI {
        for(var link in links) {
            if(link['name'] == 'last') {
                return link['url'];
            }
        }
        return '';
    }

    String posterURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/poster.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/fanart.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/fanart-360.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String bannerURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/banner.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/banner-70.jpg?apikey=${api['key']}';
        }
        return '';
    }
}