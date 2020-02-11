import 'package:url_launcher/url_launcher.dart';

extension LinksExtension on String {
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

    Future<void> lsOpenLink() async => await _openLink(this);
    Future<void> lsOpenIMDB() async => await _openLink('https://www.imdb.com/title/$this');
    Future<void> lsOpenYoutube() async => await _openLink('https://www.youtube.com/watch?v=$this');
    Future<void> lsOpenMovieDB() async => await _openLink('https://www.themoviedb.org/movie/$this');
    Future<void> lsOpenTVDB() async => await _openLink('https://www.thetvdb.com/?id=$this&tab=series');
    Future<void> lsOpenTVMaze() async => await _openLink('https://www.tvmaze.com/shows/$this');
}
