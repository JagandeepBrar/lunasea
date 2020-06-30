import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMissingTile extends StatefulWidget {
    final RadarrMissingData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    RadarrMissingTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMissingTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: widget.data.subtitle,
            ),
        ),
        trailing: LSIconButton(
            icon: Icons.search,
            onPressed: () async => _search(),
        ),
        onTap: () async => _enterMovie(),
        decoration: LSCardBackground(
            uri: widget.data.posterURI(),
            headers: Database.currentProfileObject.getRadarr()['headers'],
        ),
        padContent: true,
    );

    Future<void> _search() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.searchMissingMovies([widget.data.movieID])
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _enterMovie() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            RadarrDetailsMovie.ROUTE_NAME,
            arguments: RadarrDetailsMovieArguments(
                data: null,
                movieID: widget.data.movieID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_movie': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.data.title,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
        }
    }
}
