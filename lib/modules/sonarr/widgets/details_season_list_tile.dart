import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsSeasonListTile extends StatefulWidget {
    final SonarrCatalogueData data;
    final int index;
    
    SonarrDetailsSeasonListTile({
        Key key,
        @required this.data,
        @required this.index,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrDetailsSeasonListTile> {
    @override
    Widget build(BuildContext context) => widget.index == -1
        ? _allSeasons
        : _season;

    Widget get _allSeasons {
        return LSCardTile(
            title: LSTitle(text: 'All Seasons', darken: !widget.data.monitored),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: widget.data.monitored
                            ? Colors.white70
                            : Colors.white30,
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                    children: [
                        TextSpan(text: '${widget.data.episodeFileCount ?? 0}/${widget.data.episodeCount ?? 0} Episodes Available\n'),
                        TextSpan(
                            text: '${widget.data.percentageComplete}% Complete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.data.monitored
                                    ? widget.data.percentageComplete == 100
                                        ? LSColors.accent
                                        : Colors.red
                                    : LSColors.orange.withOpacity(0.30),
                            ),
                        ),
                    ],
                ),
            ),
            trailing: LSIconButton(
                icon: Icons.arrow_forward_ios,
                color: widget.data.monitored
                    ? Colors.white
                    : Colors.white30,
            ),
            onTap: () => _enterSeason(-1),
            padContent: true,
        );
    }

    Widget get _season {
        Map _seasonData = widget.data.seasonData[widget.index];
        int episodeCount = 0;
        int availableEpisodeCount = 0;
        if(_seasonData['statistics'] != null) {
            episodeCount = _seasonData['statistics']['totalEpisodeCount'] ?? 0;
            availableEpisodeCount = _seasonData['statistics']['episodeFileCount'] ?? 0;
        }
        int percentage = episodeCount == 0
            ? 0
            : ((availableEpisodeCount/episodeCount)*100).round();
        return LSCardTile(
            title: LSTitle(
                text: _seasonData['seasonNumber'] == 0
                    ? 'Specials'
                    : 'Season ${_seasonData['seasonNumber']}',
                darken: !_seasonData['monitored'],
            ),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: _seasonData['monitored']
                            ? Colors.white70
                            : Colors.white30,
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                    children: [
                        TextSpan(text: '$availableEpisodeCount/$episodeCount Episodes Available\n'),
                        TextSpan(
                            text: '$percentage% Complete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _seasonData['monitored']
                                    ? percentage == 100
                                        ? LSColors.accent
                                        : Colors.red
                                    : LSColors.orange.withOpacity(0.30),
                            ),
                        ),
                    ],
                ),
            ),
            trailing: LSIconButton(
                icon: _seasonData['monitored']
                    ? Icons.turned_in
                    : Icons.turned_in_not,
                color: _seasonData['monitored']
                    ? Colors.white
                    : Colors.white30,
                onPressed: () async => _toggleMonitorStatus(),
            ),
            onTap: () async => _enterSeason(_seasonData['seasonNumber']),
            onLongPress: () async => _searchSeason(_seasonData['seasonNumber']),
            padContent: true,
        );
    }

    Future<void> _toggleMonitorStatus() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.toggleSeasonMonitored(widget.data.seriesID, widget.data.seasonData[widget.index]['seasonNumber'], !widget.data.seasonData[widget.index]['monitored'])
        .then((_) {
            if(mounted) setState(() => widget.data.seasonData[widget.index]['monitored'] = !widget.data.seasonData[widget.index]['monitored']);
            LSSnackBar(context: context, title: widget.data.seasonData[widget.index]['monitored'] ? 'Monitoring' : 'No Longer Monitoring', message: widget.data.seasonData[widget.index]['seasonNumber'] == 0 ? 'Specials' : 'Season ${widget.data.seasonData[widget.index]['seasonNumber']}', type: SNACKBAR_TYPE.success);
        })
        .catchError((_) => LSSnackBar(context: context, title: widget.data.seasonData[widget.index]['monitored'] ? 'Failed to Stop Monitoring' : 'Failed to Monitor', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _enterSeason(int season) async => await Navigator.of(context).pushNamed(
        SonarrDetailsSeason.ROUTE_NAME,
        arguments: SonarrDetailsSeasonArguments(
            season: season,
            title: widget.data.title,
            seriesID: widget.data.seriesID,
        ),
    );

    Future<void> _searchSeason(int season) async {
        List _values = await SonarrDialogs.searchEntireSeason(context, season);
        if(_values[0]) {
            SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
            await _api.searchSeason(widget.data.seriesID, season)
            .then((_) => LSSnackBar(
                context: context,
                title: 'Searching...',
                message: season == 0
                    ? 'Searching for all episodes in specials'
                    : 'Searching for all episodes in season $season',
            ))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Search',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }
}
