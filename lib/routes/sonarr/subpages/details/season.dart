import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lunasea/routes/sonarr/subpages/details/selectable_card.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SonarrSeasonDetails extends StatefulWidget {
    final String title;
    final int seriesID;
    final int seasonNumber;

    SonarrSeasonDetails({
        Key key,
        @required this.title,
        @required this.seriesID,
        @required this.seasonNumber
    }): super(key: key);

    @override
    State<SonarrSeasonDetails> createState() {
        return _State();
    }
}

class _State extends State<SonarrSeasonDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    Map _episodes = {};
    List<SonarrEpisodeEntry> _selected = [];
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
            appBar: LSAppBar(widget.title),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _episodes == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) :
                        _episodes.length == 0 ?
                            Notifications.centeredMessage('No Episodes', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) :
                            widget.seasonNumber == -1 ?
                                _buildAllSeasons() :
                                _buildSingleSeason(),

            ),
            floatingActionButton: _selected.length == 0 ?
                Container() :
                _buildFloatingActionButton(),
        );
    }

    Widget _buildFloatingActionButton() {
        return FloatingActionButton.extended(
            heroTag: null,
            icon: Elements.getIcon(Icons.search),
            label: Text(
                _selected.length == 1 ? '1 Episode' : '${_selected.length} Episodes',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            onPressed: () async {
                List<dynamic> values = await _searchEpisodes();
                if(values[0]) {
                    if(values[1] == 1) {
                        Notifications.showSnackBar(_scaffoldKey, 'Searching for ${values[1]} episode...');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Searching for ${values[1]} episodes...');
                    }
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Bulk episode search failed');
                }
            },
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _episodes = await SonarrAPI.getEpisodes(widget.seriesID, widget.seasonNumber);
        _selected.clear();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    void _selectedCallback() {
        if(mounted) {
            setState(() {});
        }
    }

    Future<List<dynamic>> _searchEpisodes() async {
        bool status = false;
        int length = _selected.length;
        List<int> episodeIDs = [];
        for(var episode in _selected) {
            episode.isSelected = false;
            episodeIDs.add(episode.episodeID);
        }
        _selected.clear();
        if(await SonarrAPI.searchEpisodes(episodeIDs)) {
            _selectedCallback();
            status = true;
        }
        return [status, length];
    }

    Widget _buildAllSeasons() {
        List<Widget> seasons = [];
        for(var key in _episodes.keys) {
            if(key != -1) {
                List<Widget> season = key == 0 ?
                    _buildSeason(key, 'Specials') :
                    _buildSeason(key, 'Season $key');
                seasons = new List.from(seasons)..addAll(season);
            }
        }
        seasons = List.from(seasons.reversed);
        seasons.add(
            SliverPadding(
                padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
            )
        );
        return Scrollbar(
            child: Container(
                child: CustomScrollView(
                    slivers: seasons,
                    physics: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
            ),
        );
    }

    Widget _buildSingleSeason() {
        List<Widget> season = widget.seasonNumber == 0 ? 
            _buildSeason(widget.seasonNumber, 'Specials') : 
            _buildSeason(widget.seasonNumber, 'Season ${widget.seasonNumber}');
        season.add(
            SliverPadding(
                padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
            )
        );
        return Container(
            child: CustomScrollView(
                slivers: season,
                physics: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        );
    }

    List<Widget> _buildSeason(int season, String title) {
        List<Widget> episodeCards = [];
        int size = _episodes[season].length;
        for(int i=0; i<size; i++) {
            episodeCards.add(_buildEntry(_episodes[season][size-i-1]));
        }
        return [
            SliverStickyHeader(
                header: Card(
                    child: ListTile(
                        title: Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                            bool flag = false;
                            for(SelectableCard card in episodeCards) {
                                if(!card.entry.isSelected) {
                                    flag = true;
                                    break;
                                }
                            }
                            for(SelectableCard card in episodeCards) {
                                if(flag) {
                                    if(!_selected.contains(card.entry)) {
                                        _selected.add(card.entry);
                                    }
                                } else {
                                    _selected.remove(card.entry);
                                }
                                card.entry.isSelected = flag;
                            }
                            if(mounted) {
                                setState(() {});
                            }
                        },
                        onLongPress: () async {
                            List<dynamic> values = await SonarrDialogs.showSearchSeasonPrompt(context, season);
                            if(values[0]) {
                                if(await SonarrAPI.searchSeason(widget.seriesID, season)) {
                                    Notifications.showSnackBar(_scaffoldKey, season == 0 ? 'Searching for all episodes in specials...' : 'Searching for all episodes in season $season...');
                                } else {
                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to search for episodes');
                                }
                            }
                        },
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

    Widget _buildEntry(SonarrEpisodeEntry entry) {
        return SelectableCard(
            entry: entry,
            scaffoldKey: _scaffoldKey,
            selected: _selected,
            selectedCallback: _selectedCallback,
        );
    }
}
