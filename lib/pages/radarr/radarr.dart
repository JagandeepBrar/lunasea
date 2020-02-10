import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/radarr/api.dart';
import 'package:lunasea/pages/radarr/subpages/catalogue/addmovie/search.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/pages/radarr/subpages.dart';

class Radarr extends StatefulWidget {
    @override
    State<Radarr> createState() {
        return _State();
    }
}

class _State extends State<Radarr> {
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
        Icon(CustomIcons.movies),
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
            drawer: Navigation.getDrawer('radarr', context),
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'Radarr',
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
                    tooltip: 'Add Movie',
                    onPressed: () async {
                        _enterAddMovie();
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
        List<dynamic> values = await RadarrDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': {
                    List<dynamic> radarrValues = Values.radarrValues;
                    await Functions.openURL(radarrValues[1]);
                    break;
                }
                case 'update_library': {
                    if(await RadarrAPI.updateLibrary()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Updating entire library...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to update entire library');
                    }
                    break;
                }
                case 'rss_sync': {
                    if(await RadarrAPI.triggerRssSync()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Running RSS sync...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to run RSS sync');
                    }
                    break;
                }
                case 'backup': {
                    if(await RadarrAPI.triggerBackup()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Backing up database...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to backup database');
                    }
                    break;
                }
                case 'missing_search': {
                    List<dynamic> values = await RadarrDialogs.showSearchMissingPrompt(context);
                    if(values[0]) {
                        if(await RadarrAPI.searchAllMissing()) {
                            Notifications.showSnackBar(_scaffoldKey, 'Searching for all missing movies...');
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Failed to search for all missing movies');
                        }
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterAddMovie() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RadarrMovieSearch(),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'movie_added': {
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
