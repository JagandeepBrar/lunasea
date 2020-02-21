import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/routes/radarr/subpages/catalogue/addmovie/search.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/radarr/subpages.dart';

class Radarr extends StatefulWidget {
    @override
    State<Radarr> createState() {
        return _State();
    }
}

class _State extends State<Radarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;
    String _profile = Database.currentProfile;
    RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.movies),
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
                if(_profile != box.get('profile')) _refreshProfile(box);
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

    Widget get _drawer => LSDrawer(page: 'radarr');

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
                    : LSNotEnabled('Radarr'),
            ),
        )),
    );

    Widget get _appBar => LSAppBar(
        title: 'Radarr',
        actions: _api.enabled
            ? <Widget>[
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
            ]
            : null,
    );

    List<Widget> get _tabs => [
        Catalogue(refreshIndicatorKey: _refreshKeys[0]),
        Upcoming(refreshIndicatorKey: _refreshKeys[1]),
        Missing(refreshIndicatorKey: _refreshKeys[2]),
        History(refreshIndicatorKey: _refreshKeys[3]),
    ];

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await RadarrDialogs.showSettingsPrompt(context);
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
                case 'missing_search':
                    List<dynamic> values = await RadarrDialogs.showSearchMissingPrompt(context);
                    if(values[0]) await _api.searchAllMissing()
                        ? Notifications.showSnackBar(_scaffoldKey, 'Searching for all missing movies...')
                        : Notifications.showSnackBar(_scaffoldKey, 'Failed to search for all missing movies');
                    break;
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

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    void _refreshProfile(Box<dynamic> box) {
        _profile = box.get('profile');
        _api = RadarrAPI.from(Database.currentProfileObject);
        if(_api.enabled) _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) {
            key?.currentState?.show();
        }
    }
}
