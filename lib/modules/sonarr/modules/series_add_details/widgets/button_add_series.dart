import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsAddSeriesButton extends StatefulWidget {
    final SonarrSeriesLookup series;
    final List<SonarrRootFolder> rootFolders;

    SonarrSeriesAddDetailsAddSeriesButton({
        Key key,
        @required this.series,
        @required this.rootFolders,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddDetailsAddSeriesButton> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsAddSeriesButton> {
    LunaLoadingState _state = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: InkWell(
                            child: ListTile(
                                title: _state == LunaLoadingState.INACTIVE
                                    ? Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                        ),
                                        textAlign: TextAlign.center,
                                    )
                                    : LSLoader(
                                        color: Colors.white,
                                        size: 20.0,
                                    ),
                            ),
                            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                            onTap: _state == LunaLoadingState.INACTIVE
                                ? () async => _onTap(false)
                                : null,
                        ),
                        color: LunaColours.accent,
                        margin: EdgeInsets.all(6.0),
                        elevation: Constants.UI_ELEVATION,
                        shape: LSRoundedShape(),
                    ),
                ),
                Expanded(
                    child: Card(
                        child: InkWell(
                            child: ListTile(
                                title: _state == LunaLoadingState.INACTIVE
                                    ? Text(
                                        'Add + Search',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                        ),
                                        textAlign: TextAlign.center,
                                    )
                                    : LSLoader(
                                        color: Colors.white,
                                        size: 20.0,
                                    ),
                            ),
                            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                            onTap: _state == LunaLoadingState.INACTIVE
                                ? () async => _onTap(true)
                                : null,
                        ),
                        color: LunaColours.orange,
                        margin: EdgeInsets.all(6.0),
                        elevation: Constants.UI_ELEVATION,
                        shape: LSRoundedShape(),
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );

    Future<void> _onTap(bool search) async {
        if(context.read<SonarrState>().api != null) {
            setState(() => _state = LunaLoadingState.ACTIVE);
            SonarrRootFolder _rootFolder = widget.rootFolders.firstWhere(
                (folder) => folder.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
                orElse: () => null,
            );
            if(_rootFolder != null) {
                await context.read<SonarrState>().api.series.addSeries(
                    tvdbId: widget.series.tvdbId,
                    profileId: SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
                    languageProfileId: SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
                    title: widget.series.title,
                    titleSlug: widget.series.titleSlug,
                    images: widget.series.images,
                    seasons: widget.series.seasons,
                    rootFolderPath: _rootFolder.path,
                    tvRageId: widget.series.tvRageId,
                    seasonFolder: SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.data,
                    monitored: SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.data,
                    ignoreEpisodesWithFiles: 
                        SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.MISSING ||
                        SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.FUTURE,
                    ignoreEpisodesWithoutFiles: 
                        SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.EXISTING ||
                        SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.FUTURE,
                    searchForMissingEpisodes: search,
                ).then((addedSeries) async {
                    context.read<SonarrState>().resetSeries();
                    await context.read<SonarrState>().series;
                    widget.series.id = addedSeries.id;
                    LSSnackBar(
                        context: context,
                        title: search ?  'Series Added (Searching...)' : 'Series Added',
                        message: widget.series.title,
                        type: SNACKBAR_TYPE.success,
                    );
                    // TODO: This will cause problems when deleting a series through the calendar view
                    Navigator.of(context).popAndPushNamed(SonarrSeriesDetailsRouter.route(seriesId: addedSeries.id));
                })
                .catchError((error, stack) {
                    LunaLogger.error(
                        'SonarrSeriesAddDetailsAddSeriesButton',
                        '_onTap',
                        'Failed to add series: ${widget.series.id}',
                        error,
                        stack,
                        uploadToSentry: !(error is DioError),
                    );
                    LSSnackBar(
                        context: context,
                        title: 'Failed to Add Series',
                        type: SNACKBAR_TYPE.failure,
                    );
                });
            } else {
                LSSnackBar(
                    context: context,
                    title: 'Invalid Root Folder',
                    message: 'Please select a valid root folder',
                    type: SNACKBAR_TYPE.failure,
                );
            }
            setState(() => _state = LunaLoadingState.INACTIVE);
        }
    }
}
