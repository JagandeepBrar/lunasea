import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:sonarr/sonarr.dart';

class SonarrSeriesTile extends StatefulWidget {
    final SonarrSeries series;

    SonarrSeriesTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesTile> createState() => _State();
}

class _State extends State<SonarrSeriesTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle( text: widget.series.title, darken: !widget.series.monitored),
        subtitle: LSSubtitle(
            text: '${widget.series.totalEpisodeCount}\n',
            darken: !widget.series.monitored,
            maxLines: 2,
        ),
        trailing: LSIconButton(
            icon: widget.series.monitored ? Icons.turned_in : Icons.turned_in_not,
            color: widget.series.monitored ? Colors.white : Colors.white30,
            onPressed: () => {},
        ),
        padContent: true,
        decoration: Provider.of<SonarrState>(context, listen: false).getBannerURL(seriesId: widget.series.id) != null
            ? LSCardBackground(
                uri: Provider.of<SonarrState>(context, listen: false).getBannerURL(seriesId: widget.series.id),
                headers: Provider.of<SonarrState>(context, listen: false).headers,
            )
            : null,
        onTap: () async => _tileOnTap(),
    );

    Future<void> _tileOnTap() async {}
}