import 'package:lunasea/core.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringLinksExtension on String {
  Future<void> _openLink(String url, {Map<String, String>? headers}) async {
    try {
      //Attempt to launch the link forced as a universal link
      if (await _launchUniversalLink(url)) return;
      //If that fails and we're using a custom browser, format the link for the correct browser and attempt to launch
      LunaBrowser? _browser = LunaDatabaseValue.SELECTED_BROWSER.data;
      if (_browser != LunaBrowser.APPLE_SAFARI &&
          await _launchCustomBrowser(_browser.formatted(url))) return;
      //If all else fails, just launch it in Safari/stock browser
      await _launch(url, headers: headers ?? {});
    } catch (error, stack) {
      LunaLogger().error('Unable to open link: $url', error, stack);
    }
  }

  Future<bool> _launchUniversalLink(String url) async =>
      await launch(url, forceSafariVC: false, universalLinksOnly: true);
  Future<bool> _launchCustomBrowser(String url) async =>
      await launch(url, forceSafariVC: false);
  Future<bool> _launch(String url,
          {required Map<String, String> headers}) async =>
      await launch(url, headers: headers);

  /// Attempt to open this string as a URL in a browser.
  Future<void> lunaOpenGenericLink({Map<dynamic, dynamic>? headers}) async =>
      await _openLink(this, headers: headers?.cast<String, String>());

  /// Attach this string as an ID/title to IMDB and attempt to launch it as a URL.
  Future<void> lunaOpenIMDB() async =>
      await _openLink('https://www.imdb.com/title/$this');

  /// Attach this string as a movie ID to TheMovieDB and attempt to launch it as a URL.
  Future<void> lunaOpenTheMovieDBMovie() async =>
      await _openLink('https://www.themoviedb.org/movie/$this');

  /// Attach this string as a person ID to TheMovieDB and attempt to launch it as a URL.
  Future<void> lunaOpenTheMovieDBCredits() async =>
      await _openLink('https://www.themoviedb.org/person/$this');

  /// Attach this string as a series ID to TheTVDB and attempt to launch it as a URL.
  Future<void> lunaOpenTheTVDB() async =>
      await _openLink('https://www.thetvdb.com/?id=$this&tab=series');

  /// Attach this string as a TVDB ID to Trakt and attempt to launch it as a URL.
  Future<void> lunaOpenTraktSeries() async =>
      await _openLink('http://trakt.tv/search/tvdb/$this?id_type=show');

  /// Attach this string as a TMDB ID to Trakt and attempt to launch it as a URL.
  Future<void> lunaOpenTraktMovie() async =>
      await _openLink('https://trakt.tv/search/tmdb/$this?id_type=movie');

  /// Attach this string as a series ID to TVMaze and attempt to launch it as a URL.
  Future<void> lunaOpenTVMaze() async =>
      await _openLink('https://www.tvmaze.com/shows/$this');
}
