import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrUpcomingTile extends StatefulWidget {
    final SonarrUpcomingData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    SonarrUpcomingTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrUpcomingTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.seriesTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: 'Season ${widget.data.seasonNumber} Episode ${widget.data.episodeNumber}: '),
                    TextSpan(
                        text: '${widget.data.episodeTitle}\n',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                        ),
                    ),
                    widget.data.downloaded,
                ],
            ),
            maxLines: 2,
            softWrap: false,
            overflow: TextOverflow.fade,
        ),
        trailing: InkWell(
            child: IconButton(
                icon: Text(
                    widget.data.airTimeString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.UI_FONT_SIZE_SUBHEADER-2.0,
                    ),
                ),
                onPressed: () async => _search(),
            ),
            onLongPress: () async => _interactiveSearch(),
        ),
        onTap: () async => _enterSeason(),
        onLongPress: () async => _enterSeries(),
        padContent: true,
        decoration: LSCardBackground(
            uri: widget.data.bannerURI(),
            headers: Database.currentProfileObject.getSonarr()['headers'],
        ),
    );

    Future<void> _search() async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.searchEpisodes([widget.data.id])
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: widget.data.episodeTitle))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _interactiveSearch() async => Navigator.of(context).pushNamed(
        SonarrSearchResults.ROUTE_NAME,
        arguments: SonarrSearchResultsArguments(
            episodeID: widget.data.id,
            title: widget.data.episodeTitle,
        ),
    );

    Future<void> _enterSeason() async => await Navigator.of(context).pushNamed(
        SonarrDetailsSeason.ROUTE_NAME,
        arguments: SonarrDetailsSeasonArguments(
            season: widget.data.seasonNumber,
            title: widget.data.seriesTitle,
            seriesID: widget.data.seriesID,
        ),
    );

    Future<void> _enterSeries() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SonarrDetailsSeries.ROUTE_NAME,
            arguments: SonarrDetailsSeriesArguments(
                data: null,
                seriesID: widget.data.seriesID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_series': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.data.seriesTitle,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
            default: LunaLogger.warning('SonarrUpcomingTile', '_enterSeries', 'Unknown Case: ${result[0]}');
        }
    }
}
