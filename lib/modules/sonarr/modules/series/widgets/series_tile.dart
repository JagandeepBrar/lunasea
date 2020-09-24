import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

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
            text: '\n\n',
            darken: !widget.series.monitored,
            maxLines: 2,
        ),
        trailing: _trailing,
        padContent: true,
        onTap: () async => _tileOnTap(),
        decoration: LSCardBackground(
            uri: Provider.of<SonarrState>(context, listen: false).getBannerURL(seriesId: widget.series.id),
            headers: Provider.of<SonarrState>(context, listen: false).headers,
        ),
    );

    Widget get _trailing => LSIconButton(
        icon: widget.series.monitored ? Icons.turned_in : Icons.turned_in_not,
        color: widget.series.monitored ? Colors.white : Colors.white30,
        onPressed: () => {
            // TODO
        },
    );

    Future<void> _tileOnTap() async => SonarrSeriesDetailsRouter.navigateTo(context, seriesId: widget.series.id);
}
