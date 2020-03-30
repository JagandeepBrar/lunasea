import 'package:url_launcher/url_launcher.dart';

extension StringLinksExtension on String {
    Future<void> _openLink(String url) async {
        try {
            bool launched = await launch(
                url,
                forceSafariVC: false,
                universalLinksOnly: true,
            );
            if(!launched) await launch(url);
        } catch (e) {}
    }

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
