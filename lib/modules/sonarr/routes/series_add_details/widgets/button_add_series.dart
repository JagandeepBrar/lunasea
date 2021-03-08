import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsAddSeriesButton extends StatefulWidget {
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
                                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
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
                        elevation: LunaUI.ELEVATION,
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
                                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
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
                        elevation: LunaUI.ELEVATION,
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
            context.read<SonarrSeriesAddDetailsState>().series.tags = context.read<SonarrSeriesAddDetailsState>().tags.map<int>((e) => e.id).toList();
            await context.read<SonarrState>().api.series.addSeries(
                tvdbId: context.read<SonarrSeriesAddDetailsState>().series.tvdbId,
                profileId: context.read<SonarrSeriesAddDetailsState>().qualityProfile.id,
                languageProfileId: context.read<SonarrSeriesAddDetailsState>().languageProfile.id,
                title: context.read<SonarrSeriesAddDetailsState>().series.title,
                titleSlug: context.read<SonarrSeriesAddDetailsState>().series.titleSlug,
                images: context.read<SonarrSeriesAddDetailsState>().series.images,
                seasons: context.read<SonarrSeriesAddDetailsState>().series.seasons,
                rootFolderPath: context.read<SonarrSeriesAddDetailsState>().rootFolder.path,
                tvRageId: context.read<SonarrSeriesAddDetailsState>().series.tvRageId,
                seasonFolder: context.read<SonarrSeriesAddDetailsState>().useSeasonFolders,
                monitored: context.read<SonarrSeriesAddDetailsState>().monitored,
                tags: context.read<SonarrSeriesAddDetailsState>().tags.map<int>((e) => e.id).toList(),
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
                context.read<SonarrSeriesAddDetailsState>().series.id = addedSeries.id;
                LSSnackBar(
                    context: context,
                    title: search ?  'Series Added (Searching...)' : 'Series Added',
                    message: context.read<SonarrSeriesAddDetailsState>().series.title,
                    type: SNACKBAR_TYPE.success,
                );
                Navigator.of(context).popAndPushNamed(SonarrSeriesDetailsRouter().route(seriesId: addedSeries.id));
            })
            .catchError((error, stack) {
                LunaLogger().error('Failed to add series: ${context.read<SonarrSeriesAddDetailsState>().series.tvdbId}', error, stack);
                LSSnackBar(
                    context: context,
                    title: 'Failed to Add Series',
                    type: SNACKBAR_TYPE.failure,
                );
            });
            setState(() => _state = LunaLoadingState.INACTIVE);
        }
    }
}
