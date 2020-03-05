import 'package:flutter/material.dart';
import 'package:lunasea/core/api/sonarr.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/routes/sonarr/subpages/details/show.dart';
import 'package:lunasea/widgets.dart';

class SonarrCatalogueTile extends StatefulWidget {
    final SonarrCatalogueEntry entry;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshKey;

    SonarrCatalogueTile({
        @required this.entry,
        @required this.scaffoldKey,
        @required this.refreshKey,
    });

    @override
    State<SonarrCatalogueTile> createState() => _State(entry: entry);
}

class _State extends State<SonarrCatalogueTile> {
    SonarrAPI api = SonarrAPI.from(Database.currentProfileObject);
    SonarrCatalogueEntry entry;

    _State({
        @required this.entry,
    });

    @override
    Widget build(BuildContext context) {
        return LSCardTile(
            title: LSTitle(text: entry.title, darken: !entry.monitored),
            subtitle: LSSubtitle(text: entry.subtitle, darken: !entry.monitored, maxLines: 2),
            trailing: LSIconButton(
                icon: entry.monitored
                    ? Icons.turned_in
                    : Icons.turned_in_not,
                color: entry.monitored
                    ? Colors.white
                    : Colors.white30,
                onPressed: _toggleMonitored,
            ),
            onTap: _enterShow,
            padContent: true,
        );
    }

    Future<void> _refreshData() async {
        SonarrCatalogueEntry _entry = await api.getSeries(entry.seriesID);
        setState(() => _entry == null ? entry = entry : entry = _entry);
    }

    Future<void> _toggleMonitored() async {
        if(await api.toggleSeriesMonitored(entry.seriesID, !entry.monitored) && mounted) {
            setState(() {
                entry.monitored = !entry.monitored;
            });
            Notifications.showSnackBar(
                widget.scaffoldKey,
                entry.monitored
                    ? 'Monitoring ${entry.title}'
                    : 'No longer monitoring ${entry.title}',
            );
            //_refreshSingleEntry(entry, index);
        } else {
            Notifications.showSnackBar(
                widget.scaffoldKey,
                entry.monitored
                    ? 'Failed to stop monitoring ${entry.title}'
                    : 'Failed to start monitoring ${entry.title}',
            );
        }
    }

    Future<void> _enterShow() async {
        final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SonarrShowDetails(entry: entry, seriesID: entry.seriesID),
        ));
        if(result != null) {
            switch((result as dynamic)[0]) {
                case 'series_deleted': {
                    Notifications.showSnackBar(widget.scaffoldKey, 'Removed ${entry.title}');
                    widget.refreshKey?.currentState?.show();
                    break;
                }
                default: _refreshData(); break;
            }
        }
    }
}
