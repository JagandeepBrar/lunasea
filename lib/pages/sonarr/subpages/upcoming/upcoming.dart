import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/pages/sonarr/subpages.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class Upcoming extends StatelessWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    Upcoming({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _UpcomingWidget(refreshIndicatorKey: refreshIndicatorKey);
    }
}

class _UpcomingWidget extends StatefulWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _UpcomingWidget({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _UpcomingState(refreshIndicatorKey: refreshIndicatorKey);
    }
}

class _UpcomingState extends State<StatefulWidget> {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Map _upcomingEntries = {};
    bool _loading = true;

    _UpcomingState({
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
                    _upcomingEntries == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {refreshIndicatorKey?.currentState?.show();}) :
                        _hasEpisodes() ?
                            _buildList() :
                            Notifications.centeredMessage('No Upcoming Episodes', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {refreshIndicatorKey?.currentState?.show();}),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _upcomingEntries = await SonarrAPI.getUpcoming();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    bool _hasEpisodes() {
        if(_upcomingEntries == null || _upcomingEntries.length == 0) {
            return false;
        }
        for(var key in _upcomingEntries.keys) {
            if(_upcomingEntries[key]['entries'].length > 0) {
                return true;
            }
        }
        return false;
    }
    
    Widget _buildList() {
        List<Widget> days = [];
        for(var key in _upcomingEntries.keys) {
            if(_upcomingEntries[key]['entries'].length > 0) {
                List<Widget> day = _buildDay(key);
                days = new List.from(days)..addAll(day);
            }
        }
        return Scrollbar(
            child: Container(
                child: CustomScrollView(
                    slivers: days,
                    physics: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 3.0),
            ),
        );
    }

    List<Widget> _buildDay(String day) {
        List<Widget> episodeCards = [];
        int size = _upcomingEntries[day]['entries'].length;
        for(int i=0; i<size; i++) {
            episodeCards.add(_buildEntry(_upcomingEntries[day]['entries'][i]));
        }
        return [
            SliverStickyHeader(
                header: Card(
                    child: ListTile(
                        title: Text(
                            _upcomingEntries[day]['date'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                            ),
                        ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                    elevation: 4.0,
                ),
                sliver: SliverPadding(
                    sliver: SliverList(
                        delegate: (SliverChildListDelegate(episodeCards)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
            ),
        ];
    }

    Widget _buildEntry(SonarrUpcomingEntry entry) {
        return Card(
            child: Container(
                child: ListTile(
                    title: Elements.getTitle(entry.seriesTitle),
                    subtitle: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.LETTER_SPACING,
                            ),
                            children: <TextSpan>[
                                TextSpan(
                                    text: '${entry.seasonEpisode}: ',
                                ),
                                TextSpan(
                                    text: '${entry.episodeTitle}\n',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                    ),
                                ),
                                entry.downloaded,
                            ],
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                    ),
                    trailing: IconButton(
                        icon: Text(
                            entry.airTimeString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                            ),
                        ),
                        tooltip: 'Air Time',
                        onPressed: () async {
                            await _enterSeason(entry, entry.seasonNumber);
                        },
                    ),
                    contentPadding: Elements.getContentPadding(),
                    onTap: () async {
                        await _enterSeason(entry, entry.seasonNumber);
                    }
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

    Future<void> _enterSeason(SonarrUpcomingEntry entry, int seasonNumber) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrSeasonDetails(title: entry.seriesTitle, seriesID: entry.seriesID, seasonNumber: seasonNumber),
            ),
        );
    }
}