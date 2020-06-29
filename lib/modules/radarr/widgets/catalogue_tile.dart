import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueTile extends StatefulWidget {
    final RadarrCatalogueData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;
    final Function refreshState;

    RadarrCatalogueTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
        @required this.refreshState,
    });
    
    @override
    State<RadarrCatalogueTile> createState() => _State();
}

class _State extends State<RadarrCatalogueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.title, darken: !widget.data.monitored),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Selector<RadarrModel, RadarrCatalogueSorting>(
                    selector: (_, model) => model.sortCatalogueType,
                    builder: (context, type, _) => LSSubtitle(
                        text: widget.data.subtitle(type),
                        darken: !widget.data.monitored,
                        maxLines: 2,
                    ),
                ),
                Row(
                    children: <Widget>[
                        Padding(
                            child: Icon(
                                Icons.videocam,
                                size: 18.0,
                                color: widget.data.isInCinemas ?
                                    widget.data.monitored ? Colors.orange : Colors.orange.withOpacity(0.30) :
                                    widget.data.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 3.0, 12.0, 3.0),
                        ),
                        Padding(
                            child: Icon(
                                Icons.album,
                                size: 18.0,
                                color: widget.data.isPhysicallyReleased ?
                                    widget.data.monitored ? Colors.blue : Colors.blue.withOpacity(0.30) : 
                                    widget.data.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 3.0, 12.0, 3.0),
                        ),
                        Padding(
                            child: Icon(
                                Icons.check_circle,
                                size: 18.0,
                                color: widget.data.downloaded ?
                                    widget.data.monitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30) :
                                    widget.data.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 3.0, 16.0, 3.0),
                        ),
                        Padding(
                            child: RichText(
                                text: widget.data.releaseSubtitle,
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
                        ),
                    ],
                ),
            ],
        ),
        trailing: LSIconButton(
            icon: widget.data.monitored
                ? Icons.turned_in
                : Icons.turned_in_not,
            color: widget.data.monitored
                ? Colors.white
                : Colors.white30,
            onPressed: () async => _toggleMonitoredStatus(),
        ),
        onTap: () async => _enterMovie(),
        onLongPress: () async => _handlePopup(),
        customPadding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 0.0),
        decoration: LSCardBackground(
            uri: widget.data.posterURI(),
            darken: !widget.data.monitored,
            headers: Database.currentProfileObject.getRadarr()['headers'],
        ),
    );

    Future<void> _toggleMonitoredStatus() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.toggleMovieMonitored(widget.data.movieID, !widget.data.monitored)
        .then((_) {
            if(mounted) setState(() => widget.data.monitored = !widget.data.monitored);
            widget.refreshState();
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: widget.data.title,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) {
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _enterMovie() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            RadarrDetailsMovie.ROUTE_NAME,
            arguments: RadarrDetailsMovieArguments(
                data: widget.data,
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
            default: Logger.warning('RadarrCatalogueTile', '_enterMovie', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await RadarrDialogs.editMovie(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_movie': _refreshMovie(); break;
            case 'edit_movie': _editMovie(); break;
            case 'remove_movie': _removeMovie(); break;
            default: Logger.warning('RadarrCatalogueTile', '_handlePopup', 'Invalid method passed through popup. (${values[1]})');
        }
    }

    Future<void> _refreshMovie() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.refreshMovie(widget.data.movieID)
        .then((_) => LSSnackBar(context: context, title: 'Refreshing...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _editMovie() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            RadarrEditMovie.ROUTE_NAME,
            arguments: RadarrEditMovieArguments(
                data: widget.data,
            ),
        );
        if(result != null && result[0]) LSSnackBar(
            context: context,
            title: 'Updated',
            message: widget.data.title,
            type: SNACKBAR_TYPE.success,
        );
    }

    Future<void> _removeMovie() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        List values = await RadarrDialogs.deleteMovie(context);
        if(values[0]) {
            if(values[1]) {
                values = await GlobalDialogs.deleteCatalogueWithFiles(context, widget.data.title);
                if(values[0]) {
                    await _api.removeMovie(widget.data.movieID, deleteFiles: true)
                    .then((_) {
                        LSSnackBar(context: context, title: 'Removed (With Data)', message: widget.data.title, type: SNACKBAR_TYPE.success);
                        widget.refresh();
                    })
                    .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                }
            } else {
                await _api.removeMovie(widget.data.movieID)
                .then((_) {
                    LSSnackBar(context: context, title: 'Removed', message: widget.data.title, type: SNACKBAR_TYPE.success);
                    widget.refresh();
                })
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
            }
        }
    }
}