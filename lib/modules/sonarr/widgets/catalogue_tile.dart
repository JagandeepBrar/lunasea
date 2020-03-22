import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrCatalogueTile extends StatefulWidget {
    final SonarrCatalogueData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;
    final Function refreshState;

    SonarrCatalogueTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
        @required this.refreshState,
    });

    @override
    State<SonarrCatalogueTile> createState() => _State();
}

class _State extends State<SonarrCatalogueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.data.title,
            darken: !widget.data.monitored,
        ),
        subtitle: LSSubtitle(
            text: widget.data.subtitle,
            darken: !widget.data.monitored,
            maxLines: 2,
        ),
        trailing: LSIconButton(
            icon: widget.data.monitored
                ? Icons.turned_in
                : Icons.turned_in_not,
            color: widget.data.monitored
                ? Colors.white
                : Colors.white30,
            onPressed: () => _toggleMonitoredStatus(),
        ),
        padContent: true,
        decoration: LSCardBackground(
            uri: widget.data.bannerURI(),
            darken: !widget.data.monitored,
        ),
        onTap: () => _enterSeries(),
        onLongPress: () => _handlePopup(),
    );

    Future<void> _toggleMonitoredStatus() async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.toggleSeriesMonitored(widget.data.seriesID, !widget.data.monitored)
        .then((_) {
            if(mounted) setState(() => widget.data.monitored = !widget.data.monitored);
            widget.refreshState();
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: widget.data.title,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) {
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _enterSeries() async {
        /** TODO */
    }

    Future<void> _handlePopup() async {
        /** TODO */
    }
}