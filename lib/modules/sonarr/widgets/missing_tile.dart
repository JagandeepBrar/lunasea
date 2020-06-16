import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingTile extends StatefulWidget {
    final SonarrMissingData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    SonarrMissingTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<SonarrMissingTile> createState() => _State();
}

class _State extends State<SonarrMissingTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.showTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        text: widget.data.seasonEpisode,
                        style: TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                        ),
                    ),
                    TextSpan(
                        text: ': ${widget.data.episodeTitle}\n',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                        ),
                    ),
                    TextSpan(
                        text: 'Aired ${widget.data.airDateString}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 2,
        ),
        trailing: LSIconButton(
            icon: Icons.search,
            onPressed: () async => _search(),
        ),
        onTap: () async => _enterSeason(),
        onLongPress: () async => _enterSeries(),
        decoration: LSCardBackground(
            uri: widget.data.bannerURI(),
            headers: Database.currentProfileObject.getSonarr()['headers'],
        ),
        padContent: true,
    );

    Future<void> _search() async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.searchEpisodes([widget.data.episodeID])
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: widget.data.episodeTitle))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _enterSeason() async => await Navigator.of(context).pushNamed(
        SonarrDetailsSeason.ROUTE_NAME,
        arguments: SonarrDetailsSeasonArguments(
            season: widget.data.seasonNumber,
            title: widget.data.showTitle,
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
                    message: widget.data.showTitle,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
            default: Logger.warning('SonarrMissingTile', '_enterSeries', 'Unknown Case: ${result[0]}');
        }
    }
}