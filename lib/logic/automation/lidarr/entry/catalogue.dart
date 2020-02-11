import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';

class LidarrCatalogueEntry {
    String title;
    String sortTitle;
    String overview;
    String path;
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

    LidarrCatalogueEntry(
        this.title,
        this.sortTitle,
        this.overview,
        this.path,
        this.artistID,
        this.monitored,
        this.statistics,
        this.qualityProfile,
        this.metadataProfile,
        this.quality,
        this.metadata,
        this.genres,
        this.links,
        this.albumFolders,
        this.foreignArtistID,
        this.sizeOnDisk,
    );

    String get genre {
        if(genres == null || genres.length == 0) {
            return 'Unknown';
        }
        return genres[0];
    }

    String get subtitle {
        return '$albums\t•\t$tracks\n${sizeOnDisk.toStringFromBytes()}';
    }

    String get tracks {
        return statistics['totalTrackCount'] == 1 ? '${statistics['trackCount']} Track' : '${statistics['trackCount']} Tracks';
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
        List<dynamic> values = Values.lidarrValues;
        if(highRes) {
            return '${values[1]}/api/v1/MediaCover/Artist/$artistID/poster.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/v1/MediaCover/Artist/$artistID/poster-500.jpg?apikey=${values[2]}';
    }

    String fanartURI({bool highRes = false}) {
        List<dynamic> values = Values.lidarrValues;
        if(highRes) {
            return '${values[1]}/api/v1/MediaCover/Artist/$artistID/fanart.jpg?apikey=${values[2]}'; 
        }
        return '${values[1]}/api/v1/MediaCover/Artist/$artistID/fanart-360.jpg?apikey=${values[2]}'; 
    }

    String bannerURI({bool highRes = false}) {
        List<dynamic> values = Values.lidarrValues;
        if(highRes) {
            return '${values[1]}/api/v1/MediaCover/Artist/$artistID/banner.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/v1/MediaCover/Artist/$artistID/banner-70.jpg?apikey=${values[2]}';
    }
}