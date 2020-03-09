import 'package:flutter/material.dart';
import 'package:lunasea/routes/lidarr/subpages/details/search.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrAlbumDetails extends StatefulWidget {
    final LidarrAPI api = LidarrAPI.from(Database.currentProfileObject);
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
    State<LidarrAlbumDetails> createState() {
        return _State();
    }
}

class _State extends State<LidarrAlbumDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    List<LidarrTrackEntry> _tracks = [];
    bool _loading = true;
    
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
            appBar: LSAppBar(title: widget.title),
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
                    LSLoading() :
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
        _tracks = await widget.api.getAlbumTracks(widget.albumID);
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
                    if(await widget.api.searchAlbums([widget.albumID])) {
                        Notifications.showSnackBar(_scaffoldKey, 'Searching for ${widget.title}...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to search for ${widget.title}');
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
                title: Elements.getTitle(entry.title, darken: !widget.monitored),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: widget.monitored ? Colors.white70 : Colors.white30,
                            letterSpacing: Constants.UI_LETTER_SPACING,
                        ),
                        children: <TextSpan>[
                            TextSpan(
                                text: '${entry?.duration?.lsTime_timestampString(divisor: 1000)}\n',
                            ),
                            entry.file(widget.monitored),
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
                builder: (context) => LidarrAlbumSearch(albumID: widget.albumID),
            ),
        );
    }
}