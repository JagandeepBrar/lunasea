import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/system/platform.dart';

enum LinkedContentType {
  MOVIE,
  SERIES,
  PERSON,
  IMAGE_POSTER,
  IMAGE_BACKDROP,
}

enum LunaLinkedContent {
  CHANGELOG('https://www.lunasea.app/changelog'),
  BUILD_CHANNELS('https://www.lunasea.app/build-channels'),
  BUILDS('https://www.lunasea.app/builds'),
  DISCORD('https://www.lunasea.app/discord'),
  DOCUMENTATION('https://www.lunasea.app/docs'),
  GITHUB('https://www.lunasea.app/github'),
  NOTIFICATIONS_DOC('https://docs.lunasea.app/lunasea/notifications'),
  REDDIT('https://www.lunasea.app/reddit'),
  WEBLATE('https:/www.lunasea.app/translate'),
  WEBSITE('https://www.lunasea.app');

  final String url;
  const LunaLinkedContent(this.url);

  Future<void> launch() async => url.openLink();

  static String? imdb(String? id) {
    if (id == null) return null;
    const base = 'https://www.imdb.com';

    return '$base/title/$id';
  }

  static String? letterboxd(int? id) {
    if (id == null) return null;
    const base = 'https://letterboxd.com';

    return '$base/tmdb/$id';
  }

  static String? musicBrainz(String? id) {
    if (id == null) return null;
    const base = 'https://musicbrainz.org/artist';

    return '$base/$id';
  }

  static String plexMobile(
    String plexIdentifier,
    int ratingKey,
  ) {
    if (LunaPlatform.isAndroid) {
      const base = 'plex://server://';
      const path = '/com.plexapp.plugins.library/library/metadata/';
      return '$base$plexIdentifier$path$ratingKey';
    } else {
      const base = 'plex://preplay/?server=';
      const path = '&metadataKey=/library/metadata/';
      return '$base$plexIdentifier$path$ratingKey';
    }
  }

  static String plexWeb(
    String plexIdentifier,
    int ratingKey, [
    bool useLegacy = false,
  ]) {
    const base = 'https://app.plex.tv/desktop#!/server/';
    const path = '/details?key=%2Flibrary%2Fmetadata%2F';
    final legacy = useLegacy ? '&legacy=1' : '';
    return '$base$plexIdentifier$path$ratingKey$legacy';
  }

  static String? theMovieDB(dynamic id, LinkedContentType type) {
    if (id == null) return null;
    const base = 'https://www.themoviedb.org';
    const baseImage = 'https://image.tmdb.org/t/p';

    switch (type) {
      case LinkedContentType.MOVIE:
        return '$base/movie/$id';
      case LinkedContentType.SERIES:
        return '$base/tv/$id';
      case LinkedContentType.PERSON:
        return '$base/person/$id';
      case LinkedContentType.IMAGE_POSTER:
        return '$baseImage/w185$id';
      case LinkedContentType.IMAGE_BACKDROP:
        return '$baseImage/w300$id';
      default:
        throw UnsupportedError('$type content type is not supported');
    }
  }

  static String? trakt(int? id, LinkedContentType type) {
    if (id == null) return null;
    const base = 'https://trakt.tv';

    switch (type) {
      case LinkedContentType.MOVIE:
        return '$base/search/tmdb/$id?id_type=movie';
      case LinkedContentType.SERIES:
        return '$base/search/tvdb/$id?id_type=show';
      default:
        throw UnsupportedError('$type content type is not supported');
    }
  }

  static String? tvMaze(int? id) {
    if (id == null) return null;
    const base = 'https://www.tvmaze.com';

    return '$base/shows/$id';
  }

  static String? theTVDB(int? id, LinkedContentType type) {
    if (id == null) return null;
    const base = 'https://thetvdb.com';

    switch (type) {
      case LinkedContentType.MOVIE:
        return '$base/dereferrer/movie/$id';
      case LinkedContentType.SERIES:
        return '$base/dereferrer/series/$id';
      case LinkedContentType.PERSON:
        return '$base/people/$id';
      default:
        throw UnsupportedError('$type content type is not supported');
    }
  }

  static String? youtube(String? id) {
    if (id == null) return null;
    const base = 'https://www.youtube.com';

    return '$base/watch?v=$id';
  }
}
