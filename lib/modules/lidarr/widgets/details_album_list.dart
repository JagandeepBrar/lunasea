import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsAlbumList extends StatefulWidget {
  final int artistID;

  const LidarrDetailsAlbumList({
    Key? key,
    required this.artistID,
  }) : super(key: key);

  @override
  State<LidarrDetailsAlbumList> createState() => _State();
}

class _State extends State<LidarrDetailsAlbumList>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Future<List<LidarrAlbumData>>? _future;
  List<LidarrAlbumData>? _results;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    _results = [];
    LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject!);
    setState(() {
      _future = _api.getArtistAlbums(widget.artistID);
    });
  }

  void _refreshState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body;
  }

  Widget get _body => LunaRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasError || snapshot.data == null) {
                    return LunaMessage.error(onTap: _refresh);
                  }
                  _results = snapshot.data;
                  return _list;
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

  Widget get _list => Consumer<LidarrState>(
        builder: (context, model, widget) {
          List<LidarrAlbumData> _filtered =
              model.hideUnmonitoredAlbums ? _hide(_results)! : _results!;
          return LunaListViewBuilder(
            controller: LidarrArtistNavigationBar.scrollControllers[1],
            itemCount: _filtered.isEmpty ? 1 : _filtered.length,
            itemBuilder: _filtered.isEmpty
                ? (context, _) => LunaMessage(text: 'No Albums Found')
                : (context, index) => LidarrDetailsAlbumTile(
                      data: _filtered[index],
                      refreshState: _refreshState,
                    ),
          );
        },
      );

  List<LidarrAlbumData>? _hide(List<LidarrAlbumData>? data) {
    if (data?.isEmpty ?? true) return data;
    return data!.where((entry) => entry.monitored).toList();
  }
}
