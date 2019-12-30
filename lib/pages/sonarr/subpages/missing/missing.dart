import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/pages/sonarr/subpages.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class Missing extends StatelessWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    Missing({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _MissingWidget(refreshIndicatorKey: refreshIndicatorKey);
    }
}

class _MissingWidget extends StatefulWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _MissingWidget({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _MissingState(refreshIndicatorKey: refreshIndicatorKey);
    }
}

class _MissingState extends State<StatefulWidget> {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<SonarrMissingEntry> _missingEntries = [];
    bool _loading = true;

    _MissingState({
        Key key,
        @required this.refreshIndicatorKey,
    });

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                refreshIndicatorKey?.currentState?.show();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: RefreshIndicator(
                key: refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _missingEntries == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {refreshIndicatorKey?.currentState?.show();}) :
                        _missingEntries.length == 0 ?
                            Notifications.centeredMessage('No Missing Episodes', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {refreshIndicatorKey?.currentState?.show();}) :
                            _buildList(),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
                _missingEntries = [];
            });
        }
        _missingEntries = await SonarrAPI.getMissing();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _missingEntries.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_missingEntries[index]);
                },
                padding: Elements.getListViewPadding(),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(SonarrMissingEntry entry) {
        return Card(
            child: Container(
                child: ListTile(
                    title: Elements.getTitle(entry.showTitle),
                    subtitle: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.LETTER_SPACING,
                            ),
                            children: <TextSpan>[
                                TextSpan(
                                    text: entry.seasonEpisode,
                                ),
                                TextSpan(
                                    text: ': ${entry.episodeTitle}\n',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                    ),
                                ),
                                TextSpan(
                                    text: 'Aired ${entry.airDateString}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ],
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                    ),
                    trailing: IconButton(
                        icon: Elements.getIcon(Icons.search),
                        tooltip: 'Search',
                        onPressed: () async {
                            if(await SonarrAPI.searchEpisodes([entry.episodeID])) {
                                Notifications.showSnackBar(_scaffoldKey, 'Searching for ${entry.episodeTitle}...');
                            } else {
                                Notifications.showSnackBar(_scaffoldKey, 'Failed to search for episode');
                            }
                        },
                    ),
                    contentPadding: Elements.getContentPadding(),
                    onTap: () async {
                        await _enterSeason(entry, entry.seasonNumber);
                    },
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AdvancedNetworkImage(
                            entry.bannerURI(),
                            useDiskCache: true,
                            loadFailedCallback: () {},
                            fallbackAssetImage: 'assets/images/secondary_color.png',
                            retryLimit: 1,
                        ),
                        colorFilter: new ColorFilter.mode(Color(Constants.SECONDARY_COLOR).withOpacity(0.20), BlendMode.dstATop),
                        fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Future<void> _enterSeason(SonarrMissingEntry entry, int seasonNumber) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrSeasonDetails(title: entry.showTitle, seriesID: entry.seriesID, seasonNumber: seasonNumber),
            ),
        );
    }
}