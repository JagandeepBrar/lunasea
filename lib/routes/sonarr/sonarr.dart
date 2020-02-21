import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/routes/sonarr/subpages/catalogue/addseries/search.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/sonarr/subpages.dart';

class Sonarr extends StatefulWidget {
    @override
    State<Sonarr> createState() {
        return _State();
    }
}

class _State extends State<Sonarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;
    String _profileState = Database.currentProfileObject.toString();
    SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.television),
        Icon(CustomIcons.upcoming),
        Icon(CustomIcons.calendar_missing),
        Icon(CustomIcons.history)
    ];

    final List<String> _navbarTitles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    @override
    Widget build(BuildContext context) {
        return ValueListenableBuilder(
            valueListenable: Database.getLunaSeaBox().listenable(keys: ['profile']),
            builder: (context, box, widget) {
                if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
                return Scaffold(
                    key: _scaffoldKey,
                    body: _body,
                    drawer: _drawer,
                    appBar: _appBar,
                    bottomNavigationBar: _bottomNavigationBar,
                );
            },
        );
    }

    Widget get _drawer => LSDrawer(page: 'sonarr');

    Widget get _bottomNavigationBar => LSBottomNavigationBar(
        index: _currIndex,
        icons: _navbarIcons,
        titles: _navbarTitles,
        onTap: _navOnTap,
    );

    Widget get _body => Stack(
        children: List.generate(_tabs.length, (index) => Offstage(
            offstage: _currIndex != index,
            child: TickerMode(
                enabled: _currIndex == index,
                child: _api.enabled
                    ? _tabs[index]
                    : LSNotEnabled('Sonarr'),
            ),
        )),
    );

    Widget get _appBar => LSAppBar(
        title: 'Sonarr',
        actions: _api.enabled
            ? <Widget>[
                IconButton(
                    icon: Elements.getIcon(Icons.add),
                    tooltip: 'Add Series',
                    onPressed: () async {
                        _enterAddSeries();
                    },
                ),
                IconButton(
                    icon: Elements.getIcon(Icons.more_vert),
                    tooltip: 'More Settings',
                    onPressed: () async {
                        _handlePopup();
                    },
                ),
            ]
            : null,
    );

    List<Widget> get _tabs => [
        Catalogue(refreshIndicatorKey: _refreshKeys[0]),
        Upcoming(refreshIndicatorKey: _refreshKeys[1]),
        Missing(refreshIndicatorKey: _refreshKeys[2]),
        History(refreshIndicatorKey: _refreshKeys[3]),
    ];

    Future<void> _handlePopup() async {
        List<dynamic> values = await SonarrDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': await _api.host?.toString()?.lsLinks_OpenLink(); break;
                case 'update_library': await _api.updateLibrary()
                    ? Notifications.showSnackBar(_scaffoldKey, 'Updating entire library...')
                    : Notifications.showSnackBar(_scaffoldKey, 'Failed to update entire library');
                    break;
                case 'rss_sync': await _api.triggerRssSync()
                    ? Notifications.showSnackBar(_scaffoldKey, 'Running RSS sync...')
                    : Notifications.showSnackBar(_scaffoldKey, 'Failed to run RSS sync');
                    break;
                case 'backup': await _api.triggerBackup()
                    ? Notifications.showSnackBar(_scaffoldKey, 'Backing up database...')
                    : Notifications.showSnackBar(_scaffoldKey, 'Failed to backup database');
                    break;
                case 'missing_search': {
                    List<dynamic> values = await SonarrDialogs.showSearchMissingPrompt(context);
                    if(values[0]) await _api.searchAllMissing()
                        ? Notifications.showSnackBar(_scaffoldKey, 'Searching for all missing episodes...')
                        : Notifications.showSnackBar(_scaffoldKey, 'Failed to search for all missing episodes');
                    break;
                }
            }
        }
    }

    Future<void> _enterAddSeries() async {
        final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SonarrSeriesSearch()));
        if(result != null && result[0] == 'series_added') {
            Notifications.showSnackBar(_scaffoldKey, 'Added ${result[1]}');
            _refreshAllPages();
        }
    }

    void _navOnTap(int index) {
        if(mounted) setState(() {
            _currIndex = index;
        });
    }

    void _refreshProfile() {
        _api = SonarrAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) {
            key?.currentState?.show();
        }
    }
}
