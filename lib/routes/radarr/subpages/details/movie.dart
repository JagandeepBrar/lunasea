import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/routes/radarr/subpages/details/edit.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/radarr/subpages/details/tabs/tabs.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrMovieDetails extends StatefulWidget {
    final RadarrCatalogueEntry entry;
    final int movieID;

    RadarrMovieDetails({
        Key key,
        @required this.entry,
        @required this.movieID,
    }): super(key: key);

    @override
    State<RadarrMovieDetails> createState() {
        return _State(
            entry: entry,
        );
    }
}

class _State extends State<RadarrMovieDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    RadarrCatalogueEntry entry;
    bool _loading = false;

    final List<String> _tabTitles = [
        'Overview',
        'Releases',
        'Files',  
    ];

    _State({
        Key key,
        @required this.entry,
    });

    @override
    void initState() {
        super.initState();
        if(entry == null) {
            _needFetch();
        }
        _refreshData();
    }

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _tabTitles.length,
            initialIndex: 1,
            child: Scaffold(
                key: _scaffoldKey,
                body: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    entry == null ?
                        Notifications.centeredMessage('Connection Error') :
                        _buildPage(),
            ),
        );
    }

    void _needFetch() {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
    }

    Future<void> _refreshData() async {
        RadarrCatalogueEntry _entry = await RadarrAPI.getMovie(widget.movieID);
        _entry ??= entry;
        entry = _entry;
        if(mounted) {
            setState(() {
                _loading = false;
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
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: Constants.LETTER_SPACING,
                                        ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 72.0),
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
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                        List<dynamic> values = await RadarrDialogs.showEditMoviePrompt(context, entry);
                                        if(values[0]) {
                                            switch(values[1]) {
                                                case 'refresh_movie': {
                                                    if(await RadarrAPI.refreshMovie(entry.movieID)) {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Refreshing ${entry.title}...');
                                                    } else {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Failed to refresh ${entry.title}');
                                                    }
                                                    break;
                                                }
                                                case 'edit_movie': {
                                                    await _enterEditSeries();
                                                    break;
                                                }
                                                case 'remove_movie': {
                                                    values = await RadarrDialogs.showDeleteMoviePrompt(context);
                                                    if(values[0]) {
                                                        if(values[1]) {
                                                            values = await SystemDialogs.showDeleteCatalogueWithFilesPrompt(context, entry.title);
                                                            if(values[0]) {
                                                                if(await RadarrAPI.removeMovie(entry.movieID, deleteFiles: true)) {
                                                                    Navigator.of(context).pop('movie_deleted');
                                                                } else {
                                                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to remove ${entry.title}');
                                                                }
                                                            }
                                                        } else {
                                                            if(await RadarrAPI.removeMovie(entry.movieID)) {
                                                                Navigator.of(context).pop('movie_deleted');
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
                                    tooltip: 'Edit Movie Configuration',
                                ),
                            ],
                            bottom: TabBar(
                                tabs: <Widget>[
                                    for(int i =0; i<_tabTitles.length; i++)
                                        Tab(
                                            child: Text(
                                                _tabTitles[i],
                                                style: TextStyle(
                                                    letterSpacing: Constants.LETTER_SPACING,
                                                ),
                                            )
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
                    buildOverview(entry, context),
                    RadarrReleases(
                        entry: entry,
                        scaffoldKey: _scaffoldKey,
                    ),
                    buildFiles(entry, _scaffoldKey, _refreshData, context),
                ],
            ),
        );
    }

    Future<void> _enterEditSeries() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RadarrEditMovie(entry: entry),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'updated_movie': {
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
        _refreshData();
    }
}