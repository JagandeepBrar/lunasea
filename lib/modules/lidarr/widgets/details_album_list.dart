import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsAlbumList extends StatefulWidget {
    final int artistID;

    LidarrDetailsAlbumList({
        Key key,
        @required this.artistID,
    }): super(key: key);

    @override
    State<LidarrDetailsAlbumList> createState() => _State();
}

class _State extends State<LidarrDetailsAlbumList> with AutomaticKeepAliveClientMixin {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<LidarrAlbumData>> _future;
    List<LidarrAlbumData> _results;

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = [];
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
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

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                        _results = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => Consumer<LidarrModel>(
        builder: (context, model, widget) {
            List<LidarrAlbumData> _filtered = model.hideUnmonitoredAlbums ? _hide(_results) : _results;
            return LSListViewBuilder(
                itemCount: _filtered.length == 0 ? 1 : _filtered.length,
                itemBuilder:  _filtered.length == 0
                    ? (context, _) => LSGenericMessage(text: 'No Albums Found')
                    : (context, index) => LidarrDetailsAlbumTile(
                        data: _filtered[index],
                        refreshState: _refreshState,
                    ),
            );
        },
    );

    List<LidarrAlbumData> _hide(List<LidarrAlbumData> data) => data == null || data.length == 0
        ? data
        : data.where(
            (entry) => entry.monitored,
        ).toList();
}