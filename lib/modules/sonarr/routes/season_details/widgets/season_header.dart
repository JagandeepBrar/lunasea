import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsSeasonHeader extends StatelessWidget {
    final int seasonNumber;
    final int seriesId;
    final List<SonarrEpisode> episodes;

    SonarrSeasonDetailsSeasonHeader({
        Key key,
        @required this.seriesId,
        @required this.seasonNumber,
        @required this.episodes,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => GestureDetector(
        child: LSHeader(
            text: seasonNumber == 0
                ? 'Specials'
                : 'Season $seasonNumber',
        ),
        onTap: () async => _onTap(context),
        onLongPress: () async => handler(context, seriesId, seasonNumber),
    );

    Future<void> _onTap(BuildContext context) async {
        bool _allSelected = true;
        for(SonarrEpisode episode in episodes) {
            if(!_allSelected) break;
            _allSelected = context.read<SonarrState>().selectedEpisodes.contains(episode.id);
        }
        episodes.forEach((episode) => _allSelected
            ? context.read<SonarrState>().removeSelectedEpisode(episode.id)
            : context.read<SonarrState>().addSelectedEpisode(episode.id),
        );
    }

    static Future<void> handler(BuildContext context, int seriesId, int seasonNumber) async {
        List values = await SonarrDialogs.seasonSettings(context, seasonNumber);
        if(values[0]) switch(values[1] as SonarrSeasonSettingsType) {
            case SonarrSeasonSettingsType.AUTOMATIC_SEARCH: _automaticSearch(context, seriesId, seasonNumber); break;
            case SonarrSeasonSettingsType.INTERACTIVE_SEARCH: _interactiveSearch(context, seriesId, seasonNumber); break;
            default: LunaLogger().warning('SonarrAppBarSeriesSettingsAction', 'handler', 'Unknown case: ${(values[1] as SonarrSeasonSettingsType)}');
        }
    }

    static Future<void> _automaticSearch(BuildContext context, int seriesId, int seasonNumber) async {
        List _values = await SonarrDialogs.confirmSeasonSearch(context, seasonNumber);
        if(_values[0] && context.read<SonarrState>().api != null) context.read<SonarrState>().api.command.seasonSearch(
            seriesId: seriesId,
            seasonNumber: seasonNumber,
        )
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching for Season...',
            message: seasonNumber == 0
                ? 'Specials'
                : 'Season $seasonNumber',
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Failed season search: $seriesId, season $seasonNumber', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Season Search',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    static Future<void> _interactiveSearch(
        BuildContext context,
        int seriesId,
        int seasonNumber,
    ) async => SonarrReleasesRouter().navigateTo(context, seriesId: seriesId, seasonNumber: seasonNumber);
}
