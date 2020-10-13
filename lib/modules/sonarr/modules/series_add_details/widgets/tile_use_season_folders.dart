import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsUseSeasonFoldersTile extends StatefulWidget {
    final SonarrSeriesLookup series;

    SonarrSeriesAddDetailsUseSeasonFoldersTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddDetailsUseSeasonFoldersTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsUseSeasonFoldersTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Use Season Folders'),
        subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
        trailing: Switch(
            value: widget.series.seasonFolder,
            onChanged: (value) {
                setState(() => widget.series.seasonFolder = value);
                SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.put(value);
            },
        ),
    );
}
