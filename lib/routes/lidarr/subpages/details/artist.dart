import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/routes/lidarr/subpages/details/album.dart';
import 'package:lunasea/routes/lidarr/subpages/details/edit.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrArtistDetails extends StatefulWidget {
    final LidarrAPI api = LidarrAPI.from(Database.currentProfileObject);
    final LidarrCatalogueData entry;
    final int artistID;
    
    LidarrArtistDetails({
        Key key,
        @required this.entry,
        @required this.artistID,
    }) : super(key: key);

    @override
    State<LidarrArtistDetails> createState() {
        return _State(entry: entry);
    }
}

class _State extends State<LidarrArtistDetails> {
    LidarrCatalogueData entry;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final List<String> _tabTitles = [
        'Overview',
        'Albums',  
    ];
    List<LidarrAlbumData> _albumEntries;
    bool _loading = false;
    bool _loadingAlbums = true;
    bool _hideUnmonitored = false;

    _State({
        Key key,
        this.entry,
    });
    
    @override
    void initState() {
        super.initState();
        if(entry == null) {
            _needFetch();
        }
        _refreshArtist();
        _refreshAlbums();
    }

    void _needFetch() {
        if(mounted) setState(() {
            _loading = true;
        });
    }

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _tabTitles.length,
            initialIndex: 1,
            child: Scaffold(
                key: _scaffoldKey,
                body: _loading ?
                    LSLoading() :
                    entry == null ?
                        Notifications.centeredMessage('Connection Error') :
                        _buildPage(),
            ),
        );
    }

    Future<void> _refreshArtist() async {
        LidarrCatalogueData _entry = await widget.api.getArtist(widget.artistID);
        _entry ??= entry;
        entry = _entry;
        if(mounted) setState(() {
            _loading = false;
        });
    }

    Future<void> _refreshAlbums() async {
        if(mounted) {
            setState(() {
                _loadingAlbums = true;
            });
        }
        _albumEntries = await widget.api.getArtistAlbums(widget.artistID);
        if(mounted) {
            setState(() {
                _loadingAlbums = false;
            });
        }
    }

    Widget _buildPage() {
        return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                    child: SliverSafeArea(
                        top: false,
                        bottom: false,
                        sliver: SliverAppBar(
                            expandedHeight: 200.0,
                            pinned: true,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                                titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 64.0),
                                title: Container(
                                    child: Text(
                                        entry.title,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: Constants.UI_LETTER_SPACING,
                                        ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 96.0),
                                ),
                                background: Image(
                                    image: AdvancedNetworkImage(
                                        entry.fanartURI(highRes: true),
                                        useDiskCache: true,
                                        fallbackAssetImage: 'assets/images/secondary_color.png',
                                        loadFailedCallback: () {},
                                        retryLimit: 1,
                                    ),
                                    fit: BoxFit.cover,
                                    color: Color(Constants.SECONDARY_COLOR).withAlpha((255/1.5).floor()),
                                    colorBlendMode: BlendMode.darken,
                                ),
                            ),
                            actions: <Widget>[
                                IconButton(
                                    icon: Icon(_hideUnmonitored ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () async {
                                        if(mounted) {
                                            setState(() {
                                                _hideUnmonitored = !_hideUnmonitored;
                                            });
                                        }
                                    },
                                    tooltip: 'Hide/Unhide Unmonitored Content',
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                        List<dynamic> values = await LidarrDialogs.showEditArtistPrompt(context, entry);
                                        if(values[0]) {
                                            switch(values[1]) {
                                                case 'refresh_artist': {
                                                    if(await widget.api.refreshArtist(entry.artistID)) {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Refreshing ${entry.title}...');
                                                    } else {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Failed to refresh ${entry.title}');
                                                    }
                                                    break;
                                                }
                                                case 'edit_artist': {
                                                    _enterEditArtist();
                                                    break;
                                                }
                                                case 'remove_artist': {
                                                    values = await LidarrDialogs.showDeleteArtistPrompt(context);
                                                    if(values[0]) {
                                                        if(values[1]) {
                                                            values = await SystemDialogs.showDeleteCatalogueWithFilesPrompt(context, entry.title);
                                                            if(values[0]) {
                                                                if(await widget.api.removeArtist(entry.artistID, deleteFiles: true)) {
                                                                    Navigator.of(context).pop('remove_artist');
                                                                } else {
                                                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to remove ${entry.title}');
                                                                }
                                                            }
                                                        } else {
                                                            if(await widget.api.removeArtist(entry.artistID)) {
                                                                Navigator.of(context).pop('remove_artist');
                                                            } else {
                                                                Notifications.showSnackBar(_scaffoldKey, 'Failed to remove ${entry.title}');
                                                            }
                                                        }
                                                        
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                    },
                                    tooltip: 'Edit Artist Configuration',
                                ),
                            ],
                            bottom: TabBar(
                                tabs: <Widget>[
                                    for(int i =0; i<_tabTitles.length; i++)
                                        Tab(
                                            child: Text(
                                                _tabTitles[i],
                                                style: TextStyle(
                                                    letterSpacing: Constants.UI_LETTER_SPACING,
                                                ),
                                            ),
                                        )
                                ],
                            ),
                        ),
                    ),
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
            ],
            body: TabBarView(
                children: <Widget>[
                    _buildOverview(),
                    _loadingAlbums ?
                        LSLoading() :
                        _albumEntries == null || _albumEntries.length == 0 ? 
                            _noAlbums('No Albums Found') : 
                            _buildAlbumList(),
                ],
            ),
        );
    }

    Widget _noAlbums(String message) {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Text(
                                message,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                ),
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 2.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Widget _buildAlbumList() {
        bool monitored = false;
        if(_hideUnmonitored) {
            for(var entry in _albumEntries) {
                if(entry.monitored) {
                    monitored = true;
                    break;
                }
            }
        }
        if(!_hideUnmonitored || monitored) {
            return Scrollbar(
                child: ListView.builder(
                    itemCount: _albumEntries.length,
                    itemBuilder: (context, index) {
                        return _buildAlbum(_albumEntries[index], index);
                    },
                    padding: Elements.getListViewPadding(extraBottom: true),
                ),
            );
        } else {
            return _noAlbums('No Monitored Albums Found');
        }
    }

    Widget _buildAlbum(LidarrAlbumData entry, int index) {
        if(_hideUnmonitored) {
            if(!entry.monitored) {
                return Container();
            }
        }
        return Card(
            child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Row(
                    children: <Widget>[
                        entry.albumCoverURI() != null && entry.albumCoverURI() != '' ? (
                            ClipRRect(
                                child: Image(
                                    image: AdvancedNetworkImage(
                                        entry.albumCoverURI(),
                                        useDiskCache: true,
                                        fallbackAssetImage: 'assets/images/noalbumart.png',
                                        loadFailedCallback: () {},
                                        retryLimit: 1,
                                    ),
                                    height: 70.0,
                                    width: 70.0,
                                    fit: BoxFit.cover,
                                    color: entry.monitored ? null : Color(Constants.SECONDARY_COLOR).withAlpha((255/1.5).floor()),
                                    colorBlendMode: entry.monitored ? null : BlendMode.darken,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            )
                        ) : (
                            Container()
                        ),
                        Expanded(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle(entry.title, darken: !entry.monitored),
                                        RichText(
                                            text: TextSpan(
                                                text: "${entry.tracks}",
                                                style: TextStyle(
                                                    color: entry.monitored ? Colors.white70 : Colors.white30,
                                                    fontSize: 14.0,
                                                    letterSpacing: Constants.UI_LETTER_SPACING,
                                                ),
                                                children: <TextSpan> [
                                                    TextSpan(
                                                        text: '\n${entry.releaseDateString}',
                                                        style: TextStyle(
                                                            color: entry.monitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30),
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                        ),
                        Padding(
                            child: IconButton(
                                icon: Elements.getIcon(
                                    entry.monitored ? 
                                        Icons.turned_in :
                                        Icons.turned_in_not,
                                    color: entry.monitored ?
                                        Colors.white :
                                        Colors.white30,
                                ),
                                tooltip: 'Toggle Monitored',
                                onPressed: () async {
                                    if(await widget.api.toggleAlbumMonitored(entry.albumID, !entry.monitored)) {
                                        if(mounted) {
                                            setState(() {
                                                entry.monitored = !entry.monitored;
                                            });
                                        }
                                        Notifications.showSnackBar(
                                            _scaffoldKey,
                                            entry.monitored ? 'Monitoring ${entry.title}' : 'No longer monitoring ${entry.title}',
                                        );
                                    } else {
                                        Notifications.showSnackBar(
                                            _scaffoldKey,
                                            entry.monitored ? 'Failed to stop monitoring ${entry.title}' : 'Failed to start monitoring ${entry.title}',
                                        );
                                    }
                                },
                            ),
                            padding: EdgeInsets.fromLTRB(8.0, 0.0, 12.0, 0.0),
                        )
                    ],
                ),
                onTap: () async {
                    await _enterAlbum(entry);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 2.0,
        );
    }

    Widget _buildOverview() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildSummary(),
                    _buildPath(),
                    _buildQualityMetadata(),
                    _buildGenresStats(),
                    _buildExternalLinks(),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Widget _buildSummary() {
        return Card(
            child: InkWell(
                child: Row(
                    children: <Widget>[
                        entry.posterURI() != null && entry.posterURI() != '' ? (
                            ClipRRect(
                                child: Image(
                                    image: AdvancedNetworkImage(
                                        entry.posterURI(),
                                        useDiskCache: true,
                                        fallbackAssetImage: 'assets/images/secondary_color.png',
                                        loadFailedCallback: () {},
                                        retryLimit: 1,
                                    ),
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            )
                        ) : (
                            Container()
                        ),
                        Expanded(
                            child: Padding(
                                child: Text(
                                    entry.overview ?? 'No summary is available.\n\n\n',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                        ),
                    ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                onTap: () async {
                    await SystemDialogs.showTextPreviewPrompt(context, entry.title, entry.overview ?? 'No summary is available.');
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 2.0,
        );
    }

    Widget _buildPath() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: InkWell(
                                child: Padding(
                                    child: Column(
                                        children: <Widget>[
                                            Elements.getTitle('Artist Path'),
                                            Elements.getSubtitle(entry.path ?? 'Unknown', preventOverflow: true),
                                        ],
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                onTap: () async {
                                    await SystemDialogs.showTextPreviewPrompt(context, 'Artist Path', entry.path);
                                },
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildQualityMetadata() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Quality Profile'),
                                        Elements.getSubtitle(entry.quality ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Metadata Profile'),
                                        Elements.getSubtitle(entry.metadata ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildGenresStats() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Genre'),
                                        Elements.getSubtitle(entry.genre ?? 'None', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Statistics'),
                                        Elements.getSubtitle('${entry.albums ?? 'Unknown'}, ${entry.tracks ?? 'Unknown'}', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildExternalLinks() {
        return Padding(
            child: Row(
                children: <Widget>[
                    entry.bandsintownURI != '' ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/bandsintown.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    onTap: () async {
                                        await entry?.bandsintownURI?.lsLinks_OpenLink();
                                    },
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 2.0,
                            ),
                        )
                    ) : (
                        Container()
                    ),
                    entry.discogsURI != '' ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/discogs.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    onTap: () async {
                                        await entry?.discogsURI?.lsLinks_OpenLink();
                                    },
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 2.0,
                            ),
                        )
                    ) : (
                        Container()
                    ),
                    entry.lastfmURI != '' ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/lastfm.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    onTap: () async {
                                        await entry?.lastfmURI?.lsLinks_OpenLink();
                                    },
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 2.0,
                            ),
                        )
                    ) : (
                        Container()
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Future<void> _enterAlbum(LidarrAlbumData entry) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LidarrAlbumDetails(
                    title: entry.title,
                    albumID: entry.albumID,
                    monitored: entry.monitored,
                ),
            ),
        );
    }

    Future<void> _enterEditArtist() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LidarrEditArtist(entry: entry),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'updated_artist': {
                    if(mounted) {
                        setState(() {
                            entry = result[1];
                        });
                    }
                    Notifications.showSnackBar(_scaffoldKey, 'Updated ${entry.title}');
                    break;
                }
            }
        }
        _refreshAlbums();
    }
}