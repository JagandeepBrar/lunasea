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
    static final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;

    final List<Widget> _children = [
        Catalogue(refreshIndicatorKey: _refreshKeys[0]),
        Upcoming(refreshIndicatorKey: _refreshKeys[1]),
        Missing(refreshIndicatorKey: _refreshKeys[2]),
        History(refreshIndicatorKey: _refreshKeys[3]),
    ];

    final List<String> _titles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    final List<Icon> _icons = [
        Icon(CustomIcons.television),
        Icon(CustomIcons.upcoming),
        Icon(CustomIcons.calendar_missing),
        Icon(CustomIcons.history)
    ];

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: Stack(
                children: <Widget>[
                    for(int i=0; i < _children.length; i++)
                        Offstage(
                            offstage: _currIndex != i,
                            child: TickerMode(
                                enabled: _currIndex == i,
                                child: _children[i],
                            ),
                        )
                ],
            ),
            appBar: _buildAppBar(),
            drawer: LSDrawer(page: 'sonarr'),
            bottomNavigationBar: LSBottomNavigationBar(
                index: _currIndex,
                icons: _icons,
                titles: _titles,
                onTap: _navOnTap,
            ),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'Sonarr',
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: <Widget>[
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
                        _handlePopup(context);
                    },
                ),
            ],
        );
    }

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await SonarrDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': {
                    List<dynamic> sonarrValues = Values.sonarrValues;
                    await sonarrValues[1]?.toString()?.lsLinks_OpenLink();
                    break;
                }
                case 'update_library': {
                    if(await SonarrAPI.updateLibrary()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Updating entire library...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to update entire library');
                    }
                    break;
                }
                case 'rss_sync': {
                    if(await SonarrAPI.triggerRssSync()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Running RSS sync...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to run RSS sync');
                    }
                    break;
                }
                case 'backup': {
                    if(await SonarrAPI.triggerBackup()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Backing up database...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to backup database');
                    }
                    break;
                }
                case 'missing_search': {
                    List<dynamic> values = await SonarrDialogs.showSearchMissingPrompt(context);
                    if(values[0]) {
                        if(await SonarrAPI.searchAllMissing()) {
                            Notifications.showSnackBar(_scaffoldKey, 'Searching for all missing episodes...');
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Failed to search for all missing episodes');
                        }
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterAddSeries() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrSeriesSearch(),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'series_added': {
                    Notifications.showSnackBar(_scaffoldKey, 'Added ${result[1]}');
                    _refreshAllPages();
                    break;
                }
            }
        }
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) {
            key?.currentState?.show();
        }
    }
}
