import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/core/ui.dart';
import 'package:url_launcher/url_launcher.dart';

part 'links.g.dart';

@HiveType(typeId: 11, adapterName: 'LSBrowsersAdapter')
enum LSBrowsers {
    @HiveField(0)
    APPLE_SAFARI,
    @HiveField(1)
    BRAVE_BROWSER,
    @HiveField(2)
    GOOGLE_CHROME,
    @HiveField(3)
    MICROSOFT_EDGE,
    @HiveField(4)
    MOZILLA_FIREFOX,
}

extension LSBrowsersExtension on LSBrowsers {
    String get name {
        switch(this) {
            case LSBrowsers.APPLE_SAFARI: return 'Apple Safari';
            case LSBrowsers.BRAVE_BROWSER: return 'Brave Browser';
            case LSBrowsers.GOOGLE_CHROME: return 'Google Chrome';
            case LSBrowsers.MICROSOFT_EDGE: return 'Microsoft Edge';
            case LSBrowsers.MOZILLA_FIREFOX: return 'Mozilla Firefox';
            default: return 'Unknown Browser';
        }
    }

    String get key {
        switch(this) {
            case LSBrowsers.APPLE_SAFARI: return 'applesafari';
            case LSBrowsers.BRAVE_BROWSER: return 'bravebrowser';
            case LSBrowsers.GOOGLE_CHROME: return 'googlechrome';
            case LSBrowsers.MICROSOFT_EDGE: return 'microsoftedge';
            case LSBrowsers.MOZILLA_FIREFOX: return 'mozillafirefox';
            default: return 'unknown';
        }
    }

    IconData get icon {
        switch(this) {
            case LSBrowsers.APPLE_SAFARI: return CustomIcons.safari;
            case LSBrowsers.BRAVE_BROWSER: return CustomIcons.bravebrowser;
            case LSBrowsers.GOOGLE_CHROME: return CustomIcons.chrome;
            case LSBrowsers.MICROSOFT_EDGE: return CustomIcons.microsoftedge;
            case LSBrowsers.MOZILLA_FIREFOX: return CustomIcons.firefox;
            default: return null;
        }
    }

    String formatted(String url) {
        bool isHttps = url.substring(0, 8) == 'https://';
        switch(this) {
            case LSBrowsers.BRAVE_BROWSER: return 'brave://open-url?url=$url';
            case LSBrowsers.GOOGLE_CHROME: return isHttps
                ? url.replaceFirst('https://', 'googlechromes://')
                : url.replaceFirst('http://', 'googlechrome://');
            case LSBrowsers.MICROSOFT_EDGE: return isHttps
                ? url.replaceFirst('https://', 'microsoft-edge-https://')
                : url.replaceFirst('http://', 'microsoft-edge-http://');
            case LSBrowsers.MOZILLA_FIREFOX: return 'firefox://open-url?url=$url';
            case LSBrowsers.APPLE_SAFARI:
            default: return url;
        }
    }
}

extension StringLinksExtension on String {
    Future<void> _openLink(String url) async {
        try {
            //Attempt to launch the link forced as a universal link
            if(await _launchUniversalLink(url)) return;
            //If that fails and we're using a custom browser, format the link for the correct browser and attempt to launch
            LSBrowsers _browser = LunaSeaDatabaseValue.SELECTED_BROWSER.data;
            if(
                _browser != LSBrowsers.APPLE_SAFARI &&
                await _launchCustomBrowser(_browser.formatted(url))
            ) return;
            //If all else fails, just launch it in Safari
            await _launch(url);
        } catch (e) {}
    }

    Future<bool> _launchUniversalLink(String url) async => await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
    );

    Future<bool> _launchCustomBrowser(String url) async => await launch(
        url,
        forceSafariVC: false,
    );

    Future<bool> _launch(String url) async => await launch(url);

    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenLink() async => await _openLink(this);
    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenIMDB() async => await _openLink('https://www.imdb.com/title/$this');
    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenYoutube() async => await _openLink('https://www.youtube.com/watch?v=$this');
    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenMovieDB() async => await _openLink('https://www.themoviedb.org/movie/$this');
    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenTVDB() async => await _openLink('https://www.thetvdb.com/?id=$this&tab=series');
    // ignore: non_constant_identifier_names
    Future<void> lsLinks_OpenTVMaze() async => await _openLink('https://www.tvmaze.com/shows/$this');
}
