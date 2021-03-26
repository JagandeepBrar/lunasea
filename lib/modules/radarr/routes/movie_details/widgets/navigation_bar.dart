import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [Icons.subject_rounded, Icons.insert_drive_file_outlined, Icons.history, Icons.person];
    static const List<String> titles = ['Overview', 'Files', 'History', 'Cast & Crew'];
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());
    final PageController pageController;
    final RadarrMovie movie;

    RadarrMovieDetailsNavigationBar({
        Key key,
        @required this.pageController,
        @required this.movie,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsNavigationBar> {
    LunaLoadingState _automaticLoadingState = LunaLoadingState.INACTIVE;


    @override
    Widget build(BuildContext context) {
        return LunaBottomNavigationBar(
            pageController: widget.pageController,
            scrollControllers: RadarrMovieDetailsNavigationBar.scrollControllers,
            icons: RadarrMovieDetailsNavigationBar.icons,
            titles: RadarrMovieDetailsNavigationBar.titles,
            topActions: [
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'Automatic',
                    onTap: _automatic,
                    loadingState: _automaticLoadingState,
                    backgroundColor: LunaColours.primary,
                ),
                LunaButton.text(
                    text: 'Interactive',
                    backgroundColor: LunaColours.primary,
                    onTap: _manual,
                ),
            ],
        );
    }

    Future<void> _automatic() async {
        setState(() => _automaticLoadingState = LunaLoadingState.ACTIVE);
        RadarrAPIHelper().automaticSearch(context: context, movieId: widget.movie.id, title: widget.movie.title)
        .then((value) {
            if(mounted) setState(() {
                _automaticLoadingState = value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR;
            });
        });
    }

    Future<void> _manual() async => RadarrReleasesRouter().navigateTo(context, movieId: widget.movie.id ?? -1);
}
