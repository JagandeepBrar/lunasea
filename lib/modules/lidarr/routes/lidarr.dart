import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class Lidarr extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr';

    @override
    State<Lidarr> createState() => _State();
}

class _State extends State<Lidarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController(initialPage: LidarrDatabaseValue.NAVIGATION_INDEX.data);
    String _profileState = Database.currentProfileObject.toString();
    LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        Future.microtask(() => Provider.of<LidarrModel>(context, listen: false).navigationIndex = 0);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
            if(_scaffoldKey.currentState.isDrawerOpen) {
                //If the drawer is open, return true to close it
                return true;
            } else {
                //If the drawer isn't open, open the drawer
                _scaffoldKey.currentState.openDrawer();
                return false;
            }
        },
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
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
        ),
    );

    Widget get _drawer => LSDrawer(page: 'lidarr');

    Widget get _bottomNavigationBar => LidarrNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        LidarrCatalogue(
            refreshIndicatorKey: _refreshKeys[0],
            refreshAllPages: _refreshAllPages,
        ),
        LidarrMissing(
            refreshIndicatorKey: _refreshKeys[1],
            refreshAllPages: _refreshAllPages,
        ),
        LidarrHistory(
            refreshIndicatorKey: _refreshKeys[2],
            refreshAllPages: _refreshAllPages,
        ),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _api.enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Lidarr')),
        onPageChanged: _onPageChanged,
    );

    Widget get _appBar => LSAppBarDropdown(
        title: 'Lidarr',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject).lidarrEnabled)
                value.add(element);
            return value;
        }),
        actions: _api.enabled
            ? <Widget>[
                LSIconButton(
                    icon: Icons.add,
                    onPressed: () async => _enterAddArtist(),
                ),
                LSIconButton(
                    icon: Icons.more_vert,
                    onPressed: () async => _handlePopup(),
                )
            ]
            : null,
    );

    Future<void> _enterAddArtist() async {
        final _model = Provider.of<LidarrModel>(context, listen: false);
        _model.addSearchQuery = '';
        final dynamic result = await Navigator.of(context).pushNamed(LidarrAddSearch.ROUTE_NAME);
        if(result != null) switch(result[0]) {
            case 'artist_added': {
                LSSnackBar(context: context, title: 'Artist Added', message: result[1], type: SNACKBAR_TYPE.success);
                _refreshAllPages();
                break;
            }
            default: Logger.warning('Lidarr', '_enterAddArtist', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await LidarrDialogs.globalSettings(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui': await _api.host?.toString()?.lsLinks_OpenLink(); break;
            case 'update_library': await _api.updateLibrary()
                .then((_) => LSSnackBar(context: context, title: 'Updating Library...', message: 'Updating your library in the background'))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Update Library', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                break;
            case 'rss_sync': await _api.triggerRssSync()
                .then((_) => LSSnackBar(context: context, title: 'Running RSS Sync...', message: 'Running RSS sync in the background'))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Run RSS Sync', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                break;
            case 'backup': await _api.triggerBackup()
                .then((_) => LSSnackBar(context: context, title: 'Backing Up Database...', message: 'Backing up database in the background'))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Backup Database', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                break;
            case 'missing_search': {
                List<dynamic> values = await LidarrDialogs.searchAllMissing(context);
                if(values[0]) await _api.searchAllMissing()
                .then((_) => LSSnackBar(context: context, title: 'Searching...', message: 'Search for all missing albums'))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                break;
            }
            default: Logger.warning('Lidarr', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    void _onPageChanged(int index) => Provider.of<LidarrModel>(context, listen: false).navigationIndex = index;
    
    void _refreshProfile() {
        _api = LidarrAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}
