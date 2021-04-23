import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsAlbumArguments {
  final String title;
  final int albumID;
  final bool monitored;

  LidarrDetailsAlbumArguments({
    @required this.title,
    @required this.albumID,
    @required this.monitored,
  });
}

class LidarrDetailsAlbum extends StatefulWidget {
  static const ROUTE_NAME = '/lidarr/details/album';

  @override
  State<LidarrDetailsAlbum> createState() => _State();
}

class _State extends State<LidarrDetailsAlbum> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  LidarrDetailsAlbumArguments _arguments;
  Future<List<LidarrTrackData>> _future;
  List<LidarrTrackData> _results;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _arguments = ModalRoute.of(context).settings.arguments;
      _refresh();
    });
  }

  Future<void> _refresh() async {
    _results = [];
    setState(() {
      _future = LidarrAPI.from(Database.currentProfileObject)
          .getAlbumTracks(_arguments?.albumID);
    });
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        body: _body,
        appBar: _appBar,
      );

  Widget get _appBar => LunaAppBar(
        title: _arguments == null ? 'Details Album' : _arguments.title,
        scrollControllers: [scrollController],
        actions: <Widget>[
          LunaIconButton(
            icon: Icons.search,
            onPressed: () async => _automaticSearch(),
            onLongPress: () async => _manualSearch(),
          ),
        ],
      );

  Widget get _body => _arguments == null
      ? null
      : LunaRefreshIndicator(
          context: context,
          key: _refreshKey,
          onRefresh: _refresh,
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  {
                    if (snapshot.hasError || snapshot.data == null)
                      return LunaMessage.error(onTap: () => _refresh());
                    _results = snapshot.data;
                    return _list;
                  }
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                default:
                  return LunaLoader();
              }
            },
          ),
        );

  Widget get _list => _results.length == 0
      ? LunaMessage(
          text: 'No Tracks Found',
          buttonText: 'Refresh',
          onTap: () => _refresh(),
        )
      : LunaListViewBuilder(
          controller: scrollController,
          itemCount: _results.length,
          itemBuilder: (context, index) {
            return LidarrDetailsTrackTile(
              data: _results[index],
              monitored: _arguments?.monitored ?? false,
            );
          },
        );

  Future<void> _automaticSearch() async {
    LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
    _api.searchAlbums([_arguments.albumID]).then((_) {
      showLunaSuccessSnackBar(
        title: 'Searching...',
        message: _arguments.title,
      );
    }).catchError((error, stack) {
      LunaLogger().error('Failed to search for album', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Search',
        error: error,
      );
    });
  }

  Future<void> _manualSearch() async => Navigator.of(context).pushNamed(
        LidarrSearchResults.ROUTE_NAME,
        arguments: LidarrSearchResultsArguments(
          title: _arguments.title,
          albumID: _arguments.albumID,
        ),
      );
}
