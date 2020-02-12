import 'package:lunasea/core.dart';

class SonarrSearchEntry {
    String title;
    String overview;
    int seasonCount;
    int tvdbId;
    int tvMazeId;
    String imdbId;
    String status;
    List<dynamic> images;
    List<dynamic> seasons;

    SonarrSearchEntry(
        this.title,
        this.overview,
        this.seasonCount,
        this.status,
        this.images,
        this.seasons,
        this.tvdbId,
        this.tvMazeId,
        this.imdbId,
    );

    String get titleSlug {
        return title.lsConvertToSlug();
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