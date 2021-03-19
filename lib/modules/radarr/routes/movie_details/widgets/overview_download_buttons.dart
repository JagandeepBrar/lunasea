import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewDownloadButtons extends StatefulWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsOverviewDownloadButtons({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsOverviewDownloadButtons> {
    LunaLoadingState _automaticLoadingState = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'radarr.Automatic'.tr(),
                    onTap: () async => _automatic(context),
                    loadingState: _automaticLoadingState,
                ),
                LunaButton(
                    text: 'radarr.Interactive'.tr(),
                    backgroundColor: LunaColours.orange,
                    onTap: () async => _manual(context),
                ),
            ],
        );
    }

    Future<void> _automatic(BuildContext context) async {
        setState(() => _automaticLoadingState = LunaLoadingState.ACTIVE);
        RadarrAPIHelper().automaticSearch(context: context, movieId: widget.movie.id, title: widget.movie.title)
        .then((value) {
            if(mounted) setState(() {
                _automaticLoadingState = value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR;
            });
        });
    }

    Future<void> _manual(BuildContext context) async => RadarrReleasesRouter().navigateTo(context, movieId: widget.movie.id ?? -1);
}
