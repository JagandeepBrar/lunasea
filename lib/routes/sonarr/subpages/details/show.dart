import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/routes/sonarr/subpages/details/edit.dart';
import 'package:lunasea/routes/sonarr/subpages/details/season.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SonarrShowDetails extends StatefulWidget {
    final SonarrCatalogueEntry entry;
    final int seriesID;

    SonarrShowDetails({
        Key key,
        @required this.entry,
        @required this.seriesID,
    }): super(key: key);

    @override
    State<SonarrShowDetails> createState() {
        return _State(entry: entry);
    }
}

class _State extends State<SonarrShowDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SonarrCatalogueEntry entry;
    bool _loading = false;

    final List<String> _tabTitles = [
        'Overview',
        'Seasons',  
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

    void _needFetch() {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _tabTitles.length,
            initialIndex: 1,
            child: Scaffold(
                key: _scaffoldKey,
                body: _loading
                    ? Notifications.centeredMessage('Loading...')
                    : entry == null
                        ? Notifications.centeredMessage('Connection Error')
                        : _buildPage(),
            ),
        );
    }

    Future<void> _refreshData() async {
        SonarrCatalogueEntry _entry = await SonarrAPI.getSeries(widget.seriesID);
        _entry ??= entry;
        entry = _entry;
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildOverview() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildSummary(),
                    _buildPath(),
                    _buildTypeProfile(),
                    _buildShowDetails(),
                    _buildDates(),
                    _buildExternalLinks(),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Widget _buildShowDetails() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Network'),
                                        Elements.getSubtitle(entry.network ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Runtime'),
                                        Elements.getSubtitle(entry.runtime > 0 ? Functions.toCapitalize('${entry.runtime} Minutes') : 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
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
                                            Elements.getTitle('Series Path'),
                                            Elements.getSubtitle(entry.path ?? 'Unknown', preventOverflow: true),
                                        ],
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                onTap: () async {
                                    await SystemDialogs.showTextPreviewPrompt(context, 'Series Path', entry.path);
                                },
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildTypeProfile() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Quality Profile'),
                                        Elements.getSubtitle(entry.profile ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Series Type'),
                                        Elements.getSubtitle(Functions.toCapitalize(entry.type) ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildDates() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Next Air Date'),
                                        Elements.getSubtitle(
                                            entry.status == 'ended' ?
                                                'Series Ended' :
                                                entry.nextEpisode ?? 'Unknown',
                                            preventOverflow: true
                                        ),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Air Time'),
                                        Elements.getSubtitle(entry.airTimeString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
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
            elevation: 4.0,
        );
    }

    Widget _buildExternalLinks() {
        return Padding(
            child: Row(
                children: <Widget>[
                    entry.imdbId != null && entry.imdbId != '' ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/imdb.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    onTap: () async {
                                        await entry.imdbId.lsLinks_OpenIMDB();
                                    },
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 4.0,
                            ),
                        )
                    ) : (
                        Container()
                    ),
                    entry.tvdbId != null && entry.tvdbId != 0 ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/thetvdb.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    onTap: () async {
                                        await entry?.tvdbId?.toString()?.lsLinks_OpenTVDB();
                                    },
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 4.0,
                            ),
                        )
                    ) : (
                        Container()
                    ),
                    entry.tvMazeId != null && entry.tvMazeId != 0 ? (
                        Expanded(
                            child: Card(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/tvmaze.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    onTap: () async {
                                        await entry?.tvMazeId?.toString()?.lsLinks_OpenTVMaze();
                                    },
                                ),
                                margin: EdgeInsets.all(6.0),
                                elevation: 4.0,
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

    Widget _noSeasons() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Text(
                                'No Seasons Found',
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
                        elevation: 4.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Widget _buildSeasons() {
        return Scrollbar(
            child: ListView.builder(
                itemCount:  entry.seasonData.length+1,
                itemBuilder: (context, index) {
                    Map season;
                    int seasonNumber, episodeCount, availableEpisodeCount, percentage;
                    bool isMonitored;
                    if(index == 0) {
                        seasonNumber = -1;
                        episodeCount = entry.episodeCount;
                        availableEpisodeCount = entry.episodeFileCount;
                        percentage = (episodeCount == null || availableEpisodeCount == null || episodeCount == 0) ? 0 : ((availableEpisodeCount/episodeCount)*100).round();
                        isMonitored = entry.monitored;
                    } else {
                        season = entry.seasonData[entry.seasonData.length-index];
                        seasonNumber = season['seasonNumber'];
                        episodeCount = season['statistics']['totalEpisodeCount'];
                        availableEpisodeCount = season['statistics']['episodeFileCount'];
                        percentage = (episodeCount == null || availableEpisodeCount == null || episodeCount == 0) ? 0 : ((availableEpisodeCount/episodeCount)*100).round();
                        isMonitored = season['monitored'];
                    }
                    return Card(
                        child: ListTile(
                            title: Elements.getTitle(
                                seasonNumber == -1 ? 'All Seasons' : seasonNumber == 0 ? 'Specials' : 'Season $seasonNumber',
                                darken: !isMonitored,
                            ),
                            subtitle: RichText(
                                text: TextSpan(
                                    text: '$availableEpisodeCount/$episodeCount Episodes Available\n',
                                    style: TextStyle(
                                        color: isMonitored ? Colors.white70 : Colors.white30,
                                        letterSpacing: Constants.LETTER_SPACING,
                                    ),
                                    children: <TextSpan> [
                                        TextSpan(
                                            text: '$percentage% Complete',
                                            style: TextStyle(
                                                color: isMonitored ? 
                                                    percentage == 100 ? 
                                                        Color(Constants.ACCENT_COLOR) : 
                                                        Colors.red :
                                                            Colors.orange.withOpacity(0.30),
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            trailing: IconButton(
                                icon: Elements.getIcon(
                                    seasonNumber >= 0 ?
                                        isMonitored ?
                                            Icons.turned_in :
                                            Icons.turned_in_not :
                                                Icons.arrow_forward_ios,
                                    color: isMonitored ?
                                        Colors.white :
                                        Colors.white30
                                ),
                                tooltip: seasonNumber >= 0 ? 'Toggle Monitored' : 'View All Seasons',
                                onPressed: seasonNumber >= 0 ?
                                    () async {
                                        String snackMsg = seasonNumber == 0 ? 'specials' : 'season $seasonNumber';
                                        if(await SonarrAPI.toggleSeasonMonitored(entry.seriesID, seasonNumber, !season['monitored']) && mounted) {
                                            setState(() {
                                                season['monitored'] = !season['monitored'];
                                            });
                                            Notifications.showSnackBar(_scaffoldKey, season['monitored'] ? 'Monitoring $snackMsg' : 'No longer monitoring $snackMsg');
                                        } else {
                                            Notifications.showSnackBar(_scaffoldKey, season['monitored'] ? 'Failed to stop monitoring $snackMsg' : 'Failed to start monitoring $snackMsg');
                                        }
                                    } :
                                    () async {
                                        _enterSeason(seasonNumber);
                                    }
                            ),
                            onTap: () async {
                                _enterSeason(seasonNumber);
                            },
                            onLongPress: seasonNumber == -1 ? null : () async {
                                List<dynamic> values = await SonarrDialogs.showSearchSeasonPrompt(context, seasonNumber);
                                if(values[0]) {
                                    if(await SonarrAPI.searchSeason(entry.seriesID, seasonNumber)) {
                                        Notifications.showSnackBar(_scaffoldKey, seasonNumber == 0 ? 'Searching for all episodes in specials...' : 'Searching for all episodes in season $seasonNumber...');
                                    } else {
                                        Notifications.showSnackBar(_scaffoldKey, 'Failed to search for episodes');
                                    }
                                }
                            },
                            contentPadding: Elements.getContentPadding(),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    );
                },
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
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
                                        List<dynamic> values = await SonarrDialogs.showEditSeriesPrompt(context, entry);
                                        if(values[0]) {
                                            switch(values[1]) {
                                                case 'refresh_series': {
                                                    if(await SonarrAPI.refreshSeries(entry.seriesID)) {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Refreshing ${entry.title}...');
                                                    } else {
                                                        Notifications.showSnackBar(_scaffoldKey, 'Failed to refresh ${entry.title}');
                                                    }
                                                    break;
                                                }
                                                case 'edit_series': {
                                                    await _enterEditSeries();
                                                    break;
                                                }
                                                case 'remove_series': {
                                                    values = await SonarrDialogs.showDeleteSeriesPrompt(context);
                                                    if(values[0]) {
                                                        if(values[1]) {
                                                            values = await SystemDialogs.showDeleteCatalogueWithFilesPrompt(context, entry.title);
                                                            if(values[0]) {
                                                                if(await SonarrAPI.removeSeries(entry.seriesID, deleteFiles: true)) {
                                                                    Navigator.of(context).pop('series_deleted');
                                                                } else {
                                                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to remove ${entry.title}');
                                                                }
                                                            }
                                                        } else {
                                                            if(await SonarrAPI.removeSeries(entry.seriesID)) {
                                                                Navigator.of(context).pop('series_deleted');
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
                                    tooltip: 'Edit Series Configuration',
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
                    entry.seasonCount == 0 ? _noSeasons() : _buildSeasons(),
                ],
            ),
        );
    }

    Future<void> _enterSeason(int seasonNumber) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrSeasonDetails(title: entry.title, seriesID: entry.seriesID, seasonNumber: seasonNumber),
            ),
        );
        _refreshData();
    }

    Future<void> _enterEditSeries() async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrEditSeries(entry: entry),
            ),
        );
        //Handle the result
        if(result != null) {
            switch(result[0]) {
                case 'updated_series': {
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
