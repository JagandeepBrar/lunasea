import 'package:lunasea/system/logger.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringAsLinksExtension on String {
  Future<bool> _launchUniversal(uri) async {
    return await launchUrl(
      uri,
      webOnlyWindowName: '_blank',
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }

  Future<bool> _launchDefault(uri) async {
    return await launchUrl(
      uri,
      webOnlyWindowName: '_blank',
      mode: LaunchMode.platformDefault,
    );
  }

  Future<void> openLink() async {
    try {
      Uri uri = Uri.parse(this);
      if (await _launchUniversal(uri)) return;
      await _launchDefault(uri);
    } catch (error, stack) {
      LunaLogger().error(
        'Unable to open URL',
        error,
        stack,
      );
    }
  }

  Future<void> openImdb() async =>
      await 'https://www.imdb.com/title/$this'.openLink();

  Future<void> openTmdbMovie() async {
    await 'https://www.themoviedb.org/movie/$this'.openLink();
  }

  Future<void> openTmdbPerson() async {
    await 'https://www.themoviedb.org/person/$this'.openLink();
  }

  Future<void> openTraktMovie() async {
    await 'https://trakt.tv/search/tmdb/$this?id_type=movie'.openLink();
  }

  Future<void> openTraktSeries() async {
    await 'http://trakt.tv/search/tvdb/$this?id_type=show'.openLink();
  }

  Future<void> openTvMaze() async {
    await 'https://www.tvmaze.com/shows/$this'.openLink();
  }

  Future<void> openTvdbSeries() async {
    await 'https://www.thetvdb.com/?id=$this&tab=series'.openLink();
  }

  Future<void> openYouTube() async {
    await 'https://www.youtube.com/watch?v=$this'.openLink();
  }
}
