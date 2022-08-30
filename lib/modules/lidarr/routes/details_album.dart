import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/routes/lidarr.dart';

class ArtistAlbumDetailsRoute extends StatefulWidget {
  final int artistId;
  final int albumId;
  final bool monitored;

  const ArtistAlbumDetailsRoute({
    Key? key,
    required this.artistId,
    required this.albumId,
    required this.monitored,
  }) : super(key: key);

  @override
  State<ArtistAlbumDetailsRoute> createState() => _State();
}

class _State extends State<ArtistAlbumDetailsRoute>
    with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<List<LidarrTrackData>>? _future;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
    final api = LidarrAPI.from(LunaProfile.current);
    setState(() {
      _future = api.getAlbumTracks(widget.albumId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body,
      appBar: _appBar,
    );
  }

  PreferredSizeWidget get _appBar {
    return LunaAppBar(
      title: 'Album Details',
      scrollControllers: [scrollController],
      actions: <Widget>[
        LunaIconButton(
          icon: Icons.search_rounded,
          onPressed: () async => _automaticSearch(),
          onLongPress: () async => _manualSearch(),
        ),
      ],
    );
  }

  Widget get _body {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<List<LidarrTrackData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                if (snapshot.hasError || snapshot.data == null) {
                  return LunaMessage.error(onTap: _refresh);
                }
                return _list(snapshot.data!);
              }
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            default:
              return const LunaLoader();
          }
        },
      ),
    );
  }

  Widget _list(List<LidarrTrackData> results) {
    if (results.isEmpty) {
      return LunaMessage(
        text: 'No Tracks Found',
        buttonText: 'Refresh',
        onTap: _refresh,
      );
    }

    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: results.length,
      itemBuilder: (context, index) {
        return LidarrDetailsTrackTile(
          data: results[index],
          monitored: widget.monitored,
        );
      },
    );
  }

  Future<void> _automaticSearch() async {
    LidarrAPI _api = LidarrAPI.from(LunaProfile.current);
    _api.searchAlbums([widget.albumId]).then((_) {
      showLunaSuccessSnackBar(
        title: 'Searching...',
        message: '',
      );
    }).catchError((error, stack) {
      LunaLogger().error('Failed to search for album', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Search',
        error: error,
      );
    });
  }

  Future<void> _manualSearch() async {
    LidarrRoutes.ARTIST_ALBUM_RELEASES.go(params: {
      'artist': widget.artistId.toString(),
      'album': widget.albumId.toString(),
    });
  }
}
