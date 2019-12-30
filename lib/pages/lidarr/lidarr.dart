import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/lidarr/api.dart';
import 'package:lunasea/pages/lidarr/subpages.dart';
import 'package:lunasea/pages/lidarr/subpages/catalogue/addartist/search.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class Lidarr extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _LidarrWidget();
    }
}

class _LidarrWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _LidarrState();
    }
}

class _LidarrState extends State<StatefulWidget> {
    static final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;

    final List<Widget> _children = [
        Catalogue(refreshIndicatorKey: _refreshKeys[0]),
        Missing(refreshIndicatorKey: _refreshKeys[1]),
        History(refreshIndicatorKey: _refreshKeys[2]),
    ];

    final List<String> _titles = [
        'Catalogue',
        'Missing',
        'History',
    ];

    final List<Icon> _icons = [
        Icon(Icons.music_note),
        Icon(Icons.event_busy),
        Icon(Icons.history)
    ];

    void _navOnTap(int index) {
        setState(() {
            _currIndex = index;
        });
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
            drawer: Navigation.getDrawer('lidarr', context),
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'Lidarr',
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
                    tooltip: 'Add Artist',
                    onPressed: () async {
                        _enterAddArtist();
                    },
                ),
                IconButton(
                    icon: Elements.getIcon(Icons.more_vert),
                    tooltip: 'More Settings',
                    onPressed: () async {
                        _handlePopup(context);
                    },
                )
            ],
        );
    }

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await LidarrDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': {
                    List<dynamic> lidarrValues = Values.lidarrValues;
                    await Functions.openURL(lidarrValues[1]);
                    break;
                }
                case 'update_library': {
                    if(await LidarrAPI.updateLibrary()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Updating entire library...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to update entire library');
                    }
                    break;
                }
                case 'rss_sync': {
                    if(await LidarrAPI.triggerRssSync()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Running RSS sync...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to run RSS sync');
                    }
                    break;
                }
                case 'backup': {
                    if(await LidarrAPI.triggerBackup()) {
                        Notifications.showSnackBar(_scaffoldKey, 'Backing up database...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to backup database');
                    }
                    break;
                }
                case 'missing_search': {
                    List<dynamic> values = await LidarrDialogs.showSearchMissingPrompt(context);
                    if(values[0]) {
                        if(await LidarrAPI.searchAllMissing()) {
                            Notifications.showSnackBar(_scaffoldKey, 'Searching for all missing albums...');
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Failed to search for all missing albums');
                        }
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterAddArtist() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LidarrArtistSearch(),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'artist_added': {
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
