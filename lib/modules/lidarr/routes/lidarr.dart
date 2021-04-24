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
  LunaPageController _pageController;
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
    _pageController = LunaPageController(
        initialPage: LidarrDatabaseValue.NAVIGATION_INDEX.data);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      drawer: _drawer(),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      onProfileChange: (_) {
        if (_profileState != Database.currentProfileObject.toString())
          _refreshProfile();
      },
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.LIDARR.key);

  Widget _bottomNavigationBar() {
    if (_api.enabled)
      return LidarrNavigationBar(pageController: _pageController);
    return null;
  }

  Widget _body() {
    if (!_api.enabled)
      return LunaMessage.moduleNotEnabled(
        context: context,
        module: LunaModule.LIDARR.name,
      );
    return PageView(
      controller: _pageController,
      children: [
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
      ],
    );
  }

  Widget _appBar() {
    List<String> profiles =
        Database.profilesBox.keys.fold([], (value, element) {
      if (Database.profilesBox.get(element)?.lidarrEnabled ?? false)
        value.add(element);
      return value;
    });
    List<Widget> actions;
    if (_api.enabled)
      actions = [
        LunaIconButton(
          icon: Icons.add,
          onPressed: () async => _enterAddArtist(),
        ),
        LunaIconButton(
          icon: Icons.more_vert,
          onPressed: () async => _handlePopup(),
        ),
      ];
    return LunaAppBar.dropdown(
      title: LunaModule.LIDARR.name,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: LidarrNavigationBar.scrollControllers,
    );
  }

  Future<void> _enterAddArtist() async {
    final _model = Provider.of<LidarrState>(context, listen: false);
    _model.addSearchQuery = '';
    final dynamic result =
        await Navigator.of(context).pushNamed(LidarrAddSearch.ROUTE_NAME);
    if (result != null)
      switch (result[0]) {
        case 'artist_added':
          {
            showLunaSuccessSnackBar(
              title: 'Artist Added',
              message: result[1],
              showButton: true,
              buttonOnPressed: () => Navigator.of(context).pushNamed(
                LidarrDetailsArtist.ROUTE_NAME,
                arguments: LidarrDetailsArtistArguments(
                  artistID: result[2],
                  data: null,
                ),
              ),
            );
            _refreshAllPages();
            break;
          }
        default:
          LunaLogger().warning(
              'Lidarr', '_enterAddArtist', 'Unknown Case: ${result[0]}');
      }
  }

  Future<void> _handlePopup() async {
    List<dynamic> values = await LidarrDialogs.globalSettings(context);
    if (values[0])
      switch (values[1]) {
        case 'web_gui':
          ProfileHiveObject profile = Database.currentProfileObject;
          await profile.lidarrHost
              ?.lunaOpenGenericLink(headers: profile.lidarrHeaders);
          break;
        case 'update_library':
          await _api
              .updateLibrary()
              .then((_) => showLunaSuccessSnackBar(
                  title: 'Updating Library...',
                  message: 'Updating your library in the background'))
              .catchError((error) => showLunaErrorSnackBar(
                  title: 'Failed to Update Library', error: error));
          break;
        case 'rss_sync':
          await _api
              .triggerRssSync()
              .then((_) => showLunaSuccessSnackBar(
                  title: 'Running RSS Sync...',
                  message: 'Running RSS sync in the background'))
              .catchError((error) => showLunaErrorSnackBar(
                  title: 'Failed to Run RSS Sync', error: error));
          break;
        case 'backup':
          await _api
              .triggerBackup()
              .then((_) => showLunaSuccessSnackBar(
                  title: 'Backing Up Database...',
                  message: 'Backing up database in the background'))
              .catchError((error) => showLunaErrorSnackBar(
                  title: 'Failed to Backup Database', error: error));
          break;
        case 'missing_search':
          {
            List<dynamic> values =
                await LidarrDialogs.searchAllMissing(context);
            if (values[0])
              await _api
                  .searchAllMissing()
                  .then((_) => showLunaSuccessSnackBar(
                      title: 'Searching...',
                      message: 'Search for all missing albums'))
                  .catchError((error) => showLunaErrorSnackBar(
                      title: 'Failed to Search', error: error));
            break;
          }
        default:
          LunaLogger()
              .warning('Lidarr', '_handlePopup', 'Unknown Case: ${values[1]}');
      }
  }

  void _refreshProfile() {
    _api = LidarrAPI.from(Database.currentProfileObject);
    _profileState = Database.currentProfileObject.toString();
    _refreshAllPages();
  }

  void _refreshAllPages() {
    for (var key in _refreshKeys) key?.currentState?.show();
  }
}
