class TheMovieDB {
  static const String _IMAGE_ENDPOINT_URL = 'https://image.tmdb.org/t/p/';
  static const String _IMAGE_POSTER_SIZE = 'w154';

  static String? getImageURL(String? id) {
    if (id != null) return '$_IMAGE_ENDPOINT_URL$_IMAGE_POSTER_SIZE$id';
    return null;
  }
}
