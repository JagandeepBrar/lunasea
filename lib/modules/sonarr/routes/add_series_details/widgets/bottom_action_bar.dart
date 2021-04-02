import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesDetailsActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'Add Series',
                    icon: Icons.add_rounded,
                    onTap: () async => _onTap(context, false),
                    loadingState: context.watch<SonarrSeriesAddDetailsState>().state,
                ),
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'Add + Search',
                    icon: Icons.search_rounded,
                    onTap: () async => _onTap(context, true),
                    loadingState: context.watch<SonarrSeriesAddDetailsState>().state,
                ),
            ],
        );
    }

    Future<void> _onTap(BuildContext context, bool searchOnAdd) async {
        if(context.read<SonarrState>().api != null) {
            context.read<SonarrSeriesAddDetailsState>().state = LunaLoadingState.ACTIVE;
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
                seriesType: context.read<SonarrSeriesAddDetailsState>().seriesType,
                tags: context.read<SonarrSeriesAddDetailsState>().tags.map<int>((e) => e.id).toList(),
                ignoreEpisodesWithFiles: 
                    SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.MISSING ||
                    SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.FUTURE,
                ignoreEpisodesWithoutFiles: 
                    SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.EXISTING ||
                    SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data == SonarrMonitorStatus.FUTURE,
                searchForMissingEpisodes: searchOnAdd,
            ).then((addedSeries) async {
                context.read<SonarrState>().resetSeries();
                await context.read<SonarrState>().series;
                context.read<SonarrSeriesAddDetailsState>().series.id = addedSeries.id;
                showLunaSuccessSnackBar(
                    title: searchOnAdd ?  'Series Added (Searching...)' : 'Series Added',
                    message: context.read<SonarrSeriesAddDetailsState>().series.title,
                );
                Navigator.of(context).popAndPushNamed(SonarrSeriesDetailsRouter().route(seriesId: addedSeries.id));
            })
            .catchError((error, stack) {
                context.read<SonarrSeriesAddDetailsState>().state = LunaLoadingState.ERROR;
                LunaLogger().error('Failed to add series: ${context.read<SonarrSeriesAddDetailsState>().series.tvdbId}', error, stack);
                showLunaErrorSnackBar(title: 'Failed to Add Series', error: error);
            });
            context.read<SonarrSeriesAddDetailsState>().state = LunaLoadingState.INACTIVE;
        }
    }
}
