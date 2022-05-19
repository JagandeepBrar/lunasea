enum ContentType {
  MOVIE,
  SERIES,
  PERSON,
}

abstract class LinkGenerator {
  static String? imdb(String? id) {
    if (id == null) return null;
    String base = 'https://www.imdb.com';

    return '$base/title/$id';
  }

  static String? letterboxd(int? id) {
    if (id == null) return null;
    String base = 'https://letterboxd.com';

    return '$base/tmdb/$id';
  }

  static String? theMovieDB(int? id, ContentType type) {
    if (id == null) return null;
    String base = 'https://www.themoviedb.org';

    switch (type) {
      case ContentType.MOVIE:
        return '$base/movie/$id';
      case ContentType.SERIES:
        return '$base/tv/$id';
      case ContentType.PERSON:
        return '$base/person/$id';
    }
  }

  static String? trakt(int? id, ContentType type) {
    if (id == null) return null;
    String base = 'https://trakt.tv';

    switch (type) {
      case ContentType.MOVIE:
        return '$base/search/tmdb/$id?id_type=movie';
      case ContentType.SERIES:
        return '$base/search/tvdb/$id?id_type=show';
      case ContentType.PERSON:
        throw UnsupportedError('"person" content types is not supported');
    }
  }

  static String? tvMaze(int? id) {
    if (id == null) return null;
    String base = 'https://www.tvmaze.com';

    return '$base/shows/$id';
  }

  static String? theTVDB(int? id, ContentType type) {
    if (id == null) return null;
    String base = 'https://thetvdb.com';

    switch (type) {
      case ContentType.MOVIE:
        return '$base/dereferrer/series/$id';
      case ContentType.SERIES:
        return '$base/dereferrer/movie/$id';
      case ContentType.PERSON:
        return '$base/people/$id';
    }
  }

  static String? youtube(String? id) {
    if (id == null) return null;
    String base = 'https://www.youtube.com';

    return '$base/watch?v=$id';
  }
}
