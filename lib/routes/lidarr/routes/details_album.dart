import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/lidarr/routes.dart';
import 'package:lunasea/widgets.dart';

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
        floatingActionButton: _floatingActionButton,
    );

    Widget get _appBar => LSAppBar(title: _arguments == null ? 'Details Album' : _arguments.title);

    Widget get _floatingActionButton => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.done: {
                    if(!snapshot.hasError && snapshot.data != null) return InkWell(
                        child: LSFloatingActionButton(
                            icon: Icons.search,
                            onPressed: () async => _automaticSearch(),
                        ),
                        onLongPress: () async => _manualSearch(),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    );
                    break;
                }
                default: break;
            }
            return Container();
        },
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
            padBottom: true,
        );

    
    Future<void> _automaticSearch() async {
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.searchAlbums([_arguments.albumID])
            ? LSSnackBar(
                context: context,
                title: 'Searching...',
                message: _arguments.title,
            )
            : LSSnackBar(
                context: context,
                title: 'Failed to Search',
                message: _arguments.title,
                type: SNACKBAR_TYPE.failure,
            );
    }

    Future<void> _manualSearch() async => Navigator.of(context).pushNamed(
        LidarrSearchResults.ROUTE_NAME,
        arguments: LidarrSearchResultsArguments(
            title: _arguments.title,
            albumID: _arguments.albumID,
        ),
    );
}
