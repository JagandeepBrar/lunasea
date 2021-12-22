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
  String added;
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
    @required this.added,
  });

  String get genre {
    if (genres?.isNotEmpty ?? false) return genres.join('\n');
    return 'Unknown';
  }

  DateTime get dateAddedObject => DateTime.tryParse(added)?.toLocal();

  String get dateAdded {
    if (added != null) {
      return DateFormat('MMMM dd, y').format(dateAddedObject);
    }
    return 'Unknown';
  }

  String subtitle(LidarrCatalogueSorting sorting) => _sortSubtitle(sorting);

  String _sortSubtitle(LidarrCatalogueSorting sorting) {
    switch (sorting) {
      case LidarrCatalogueSorting.metadata:
        return metadata;
      case LidarrCatalogueSorting.quality:
        return quality;
      case LidarrCatalogueSorting.tracks:
        return trackStats;
      case LidarrCatalogueSorting.type:
        return artistType;
      case LidarrCatalogueSorting.dateAdded:
        return dateAdded;
      case LidarrCatalogueSorting.size:
      case LidarrCatalogueSorting.alphabetical:
        return sizeOnDisk?.lunaBytesToString();
    }
    return '';
  }

  String get trackStats {
    String percentage =
        '(${(statistics['percentOfTracks'] as double).floor()}%)';
    return '${statistics['trackFileCount']}/${statistics['trackCount']} $percentage';
  }

  String get tracks {
    return statistics['trackCount'] == 1
        ? '${statistics['trackCount']} Track'
        : '${statistics['trackCount']} Tracks';
  }

  String get albums {
    return statistics['albumCount'] == 1
        ? '${statistics['albumCount']} Album'
        : '${statistics['albumCount']} Albums';
  }

  String get bandsintownURI {
    for (var link in links) {
      if (link['name'] == 'bandsintown') {
        return link['url'];
      }
    }
    return '';
  }

  String get discogsURI {
    for (var link in links) {
      if (link['name'] == 'discogs') {
        return link['url'];
      }
    }
    return '';
  }

  String get lastfmURI {
    for (var link in links) {
      if (link['name'] == 'last') {
        return link['url'];
      }
    }
    return '';
  }

  String posterURI({bool highRes = false}) {
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Artist'
          : '${api['host']}/api/v1/MediaCover/Artist';
      return highRes
          ? '$_base/$artistID/poster.jpg?apikey=${api['key']}'
          : '$_base/$artistID/poster-500.jpg?apikey=${api['key']}';
    }
    return '';
  }

  String fanartURI({bool highRes = false}) {
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Artist'
          : '${api['host']}/api/v1/MediaCover/Artist';
      return highRes
          ? '$_base/$artistID/fanart.jpg?apikey=${api['key']}'
          : '$_base/$artistID/fanart-360.jpg?apikey=${api['key']}';
    }
    return '';
  }

  String bannerURI({bool highRes = false}) {
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Artist'
          : '${api['host']}/api/v1/MediaCover/Artist';
      return highRes
          ? '$_base/$artistID/banner.jpg?apikey=${api['key']}'
          : '$_base/$artistID/banner-70.jpg?apikey=${api['key']}';
    }
    return '';
  }
}
