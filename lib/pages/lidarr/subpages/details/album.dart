import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/lidarr.dart';
import 'package:lunasea/pages/lidarr/subpages/details/search.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/system/functions.dart';

class LidarrAlbumDetails extends StatelessWidget {
    final String title;
    final int albumID;
    final bool monitored;

    LidarrAlbumDetails({
        Key key,
        @required this.title,
        @required this.albumID,
        @required this.monitored,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _LidarrAlbumDetailsWidget(
            title: this.title,
            albumID: this.albumID,
            monitored: this.monitored,
        );
    }
}

class _LidarrAlbumDetailsWidget extends StatefulWidget {
    final String title;
    final int albumID;
    final bool monitored;
    
    _LidarrAlbumDetailsWidget({
        Key key,
        @required this.title,
        @required this.albumID,
        @required this.monitored,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _LidarrAlbumDetailsState(
            title: this.title,
            albumID: this.albumID,
            monitored: monitored,
        );
    }
}

class _LidarrAlbumDetailsState extends State<StatefulWidget> {
    final String title;
    final int albumID;
    final bool monitored;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    List<LidarrTrackEntry> _tracks = [];
    bool _loading = true;

    _LidarrAlbumDetailsState({
        Key key,
        @required this.title,
        @required this.albumID,
        @required this.monitored,
    });
    
    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            _refreshIndicatorKey?.currentState?.show();
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar(title, context),
            floatingActionButton: _loading ?
                null :
                _tracks == null || _tracks.length == 0 ?
                    null :
                    _buildFloatingActionButton(),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _tracks == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) :
                        _tracks.length == 0 ?
                            Notifications.centeredMessage('No Tracks', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) :
                            _buildList(),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _tracks = await LidarrAPI.getAlbumTracks(albumID);
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildFloatingActionButton() {
        return InkWell(
            child: FloatingActionButton(
                heroTag: null,
                child: Elements.getIcon(Icons.search),
                onPressed: () async {
                    if(await LidarrAPI.searchAlbums([albumID])) {
                        Notifications.showSnackBar(_scaffoldKey, 'Searching for $title...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to search for $title');
                    }
                },
            ),
            onLongPress: () async {
                await _enterSearch();
            },
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_tracks[index]);
                },
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(LidarrTrackEntry entry) {
        return Card(
            child: ListTile(
                title: Elements.getTitle(entry.title, darken: !monitored),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: monitored ? Colors.white70 : Colors.white30,
                            letterSpacing: Constants.LETTER_SPACING,
                        ),
                        children: <TextSpan>[
                            TextSpan(
                                text: '${Functions.trackDurationReadable(entry.duration)}\n',
                            ),
                            entry.file(monitored),
                        ]
                    ),
                ),
                leading: IconButton(
                    icon: Text(
                        '${entry.trackNumber}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                        ),
                    ),
                    tooltip: 'Track Number',
                    onPressed: null,
                ),
                contentPadding: Elements.getContentPadding(),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Future<void> _enterSearch() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LidarrAlbumSearch(albumID: albumID),
            ),
        );
    }
}