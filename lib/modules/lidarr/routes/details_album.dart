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

class _State extends State<LidarrDetailsAlbum> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

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
            _future = LidarrAPI.from(Database.currentProfileObject).getAlbumTracks(_arguments?.albumID);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(
        title: _arguments == null ? 'Details Album' : _arguments.title,
        actions: <Widget>[
            InkWell(
                child: LSIconButton(
                    icon: Icons.search,
                    onPressed: () async => _automaticSearch(),
                ),
                onLongPress: () async => _manualSearch(),
                borderRadius: BorderRadius.all(Radius.circular(28.0)),
            ),
        ],
    );

    Widget get _body => _arguments == null
        ? null
        : LSRefreshIndicator(
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

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Tracks Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : LSListViewBuilder(
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
        _api.searchAlbums([_arguments.albumID])
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: _arguments.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _manualSearch() async => Navigator.of(context).pushNamed(
        LidarrSearchResults.ROUTE_NAME,
        arguments: LidarrSearchResultsArguments(
            title: _arguments.title,
            albumID: _arguments.albumID,
        ),
    );
}
