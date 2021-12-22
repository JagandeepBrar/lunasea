import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  /// Returns a string with all first letters of each word capitalized
  ///
  /// Default word splitting pattern is by a space.
  String lunaCapitalizeFirstLetters({Pattern pattern = ' '}) {
    if (this == null) return null;
    List<String> split = this.split(pattern);
    for (var i = 0; i < split.length; i++) {
      if ((split[i]?.length ?? 0) == 0) break;
      if (split[i].length == 1) {
        split[i] = split[i].toUpperCase();
      } else {
        split[i] =
            split[i].substring(0, 1).toUpperCase() + split[i].substring(1);
      }
    }
    return split.join(pattern);
  }

  /// Convert a string into a slug format.
  ///
  /// Example "LunaSea Flutter" => 'lunasea-flutter';
  String lunaConvertToSlug() {
    if (this == null) return null;
    return this
        .toLowerCase()
        .replaceAll(RegExp(r'[\ \.]'), '-')
        .replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '')
        .trim();
  }

  /// Pad a string on both sides with the spacer value [count] amount of times.
  /// Count is the amount of times to add the [padding] on each time, and not the maximum total width of the string unlike [padLeft] and [padRight].
  ///
  /// Example "LunaSea" with count 2 and padding "1" would return "11LunaSea11".
  String lunaPad([int count = 1, String padding = ' ']) {
    if (this == null) return null;
    String _value = this
        .padLeft((this.length + count), padding)
        .padRight((this.length + (count * 2)), padding);
    return _value;
  }
}

extension StringLinksExtension on String {
  Future<void> _openLink(String url, {Map<String, String> headers}) async {
    try {
      //Attempt to launch the link forced as a universal link
      if (await _launchUniversalLink(url)) return;
      //If that fails and we're using a custom browser, format the link for the correct browser and attempt to launch
      LunaBrowser _browser = LunaDatabaseValue.SELECTED_BROWSER.data;
      if (_browser != LunaBrowser.APPLE_SAFARI &&
          await _launchCustomBrowser(_browser.formatted(url))) return;
      //If all else fails, just launch it in Safari/stock browser
      await _launch(url, headers: headers);
    } catch (error, stack) {
      LunaLogger().error('Unable to open link: $url', error, stack);
    }
  }

  Future<bool> _launchUniversalLink(String url) async =>
      await launch(url, forceSafariVC: false, universalLinksOnly: true);
  Future<bool> _launchCustomBrowser(String url) async =>
      await launch(url, forceSafariVC: false);
  Future<bool> _launch(String url, {Map<String, String> headers}) async =>
      await launch(url, headers: headers);

  /// Attempt to open this string as a URL in a browser.
  Future<void> lunaOpenGenericLink({Map<dynamic, dynamic> headers}) async =>
      await _openLink(this, headers: headers?.cast<String, String>());

  /// Attach this string as an ID/title to IMDB and attempt to launch it as a URL.
  Future<void> lunaOpenIMDB() async =>
      await _openLink('https://www.imdb.com/title/$this');

  /// Attach this string as a video ID to YouTube and attempt to launch it as a URL.
  Future<void> lunaOpenYouTube() async =>
      await _openLink('https://www.youtube.com/watch?v=$this');

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

  Future<void> copyToClipboard({
    bool showSnackBar = true,
  }) async {
    await Clipboard.setData(ClipboardData(text: this));
    if (showSnackBar)
      showLunaSuccessSnackBar(
        title: 'Copied',
        message: 'Copied content to the clipboard',
      );
  }
}
