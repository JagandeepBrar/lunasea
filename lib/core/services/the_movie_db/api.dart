class TheMovieDB {
  static const String _IMAGE_ENDPOINT_URL = 'https://image.tmdb.org/t/p/';

  static const String _IMAGE_BACKDROP_SIZE = 'w300';
  static const String _IMAGE_POSTER_SIZE = 'w185';

  static String? getPosterURL(String? id) {
    if (id != null) return '$_IMAGE_ENDPOINT_URL$_IMAGE_POSTER_SIZE$id';
    return null;
  }

  static String? getBackdropURL(String? id) {
    if (id != null) return '$_IMAGE_ENDPOINT_URL$_IMAGE_BACKDROP_SIZE$id';
    return null;
  }
}
