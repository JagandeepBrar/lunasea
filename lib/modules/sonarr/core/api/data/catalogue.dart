import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrCatalogueData {
    final Map<String, dynamic> api = Database.currentProfileObject.getSonarr();
    String title;
    String sortTitle;
    String status;
    String previousAiring;
    String nextAiring;
    String network;
    String overview;
    String path;
    String type;
    List<dynamic> seasonData;
    int qualityProfile;
    int seasonCount;
    int episodeCount;
    int episodeFileCount;
    int seriesID;
    String profile;
    bool seasonFolder;
    bool monitored;
    int tvdbId;
    int tvMazeId;
    String imdbId;
    int runtime;
    int sizeOnDisk;

    SonarrCatalogueData({
        @required this.title,
        @required this.sortTitle,
        @required this.seasonCount,
        @required this.seasonData,
        @required this.episodeCount,
        @required this.episodeFileCount,
        @required this.status,
        @required this.seriesID,
        @required this.previousAiring,
        @required this.nextAiring,
        @required this.network,
        @required this.monitored,
        @required this.path,
        @required this.qualityProfile,
        @required this.type,
        @required this.seasonFolder,
        @required this.overview,
        @required this.tvdbId,
        @required this.tvMazeId,
        @required this.imdbId,
        @required this.runtime,
        @required this.profile,
        @required this.sizeOnDisk,
    });

    DateTime get nextAiringObject {
        return DateTime.tryParse(nextAiring)?.toLocal();
    }

    DateTime get previousAiringObject {
        return DateTime.tryParse(previousAiring)?.toLocal();
    }

    String get seasonCountString {
        return seasonCount == 1 ? '$seasonCount Season' : '$seasonCount Seasons';
    }

    String get nextEpisode {
        if(nextAiringObject != null) {
            return DateFormat('MMMM dd, y').format(nextAiringObject);
        }
        return 'Unknown';
    }

    int get percentageComplete {
        int _total = episodeCount ?? 0;
        int _available = episodeFileCount ?? 0;
        return _total == 0
            ? 0
            : ((_available/_total)*100).round();
    }

    String get airTimeString {
        if(previousAiringObject != null) {
            return DateFormat('hh:mm a').format(previousAiringObject);
        }
        return 'Unknown';
    }

    String subtitle(SonarrCatalogueSorting sorting) {
        if(previousAiringObject != null) {
            if(network == null) {
                return status == 'ended' ?
                    '$seasonCountString (Ended)\t•\t${_sortSubtitle(sorting)}\nAired on Unknown' :
                    '$seasonCountString\t•\t${_sortSubtitle(sorting)}\n${DateFormat('hh:mm a').format(previousAiringObject)} on Unknown';
            }
            return status == 'ended' ?
                '$seasonCountString (Ended)\t•\t${_sortSubtitle(sorting)}\nAired on $network' :
                '$seasonCountString\t•\t${_sortSubtitle(sorting)}\n${DateFormat('hh:mm a').format(previousAiringObject)} on $network';
        } else {
            if(network == null) {
                return status == 'ended' ? 
                    '$seasonCountString (Ended)\t•\t${_sortSubtitle(sorting)}\nAired on Unknown' :
                    '$seasonCountString\t•\t${_sortSubtitle(sorting)}\nAirs on Unknown';
            }
            return status == 'ended' ? 
                '$seasonCountString (Ended)\t•\t${_sortSubtitle(sorting)}\nAired on $network' :
                '$seasonCountString\t•\t${_sortSubtitle(sorting)}\nAirs on $network';
        }
    }

    String _sortSubtitle(SonarrCatalogueSorting sorting) {
        switch(sorting) {
            case SonarrCatalogueSorting.type: return type.lsLanguage_Capitalize();
            case SonarrCatalogueSorting.quality: return profile;
            case SonarrCatalogueSorting.episodes: return '${episodeFileCount ?? 0}/${episodeCount ?? 0} ($percentageComplete%)';
            case SonarrCatalogueSorting.nextAiring: return nextEpisode;
            case SonarrCatalogueSorting.network:
            case SonarrCatalogueSorting.size:
            case SonarrCatalogueSorting.alphabetical: return sizeOnDisk?.lsBytes_BytesToString() ?? '0.0 B';
        }
        return 'Unknown';
    }

    String posterURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/poster.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/fanart.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }

    String bannerURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/banner.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/banner-70.jpg?apikey=${api['key']}'; 
        }
        return '';
    }
}