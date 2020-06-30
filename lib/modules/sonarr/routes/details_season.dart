import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsSeasonArguments {
    final String title;
    final int seriesID;
    final int season;

    SonarrDetailsSeasonArguments({
        @required this.season,
        @required this.seriesID,
        @required this.title,
    });
}

class SonarrDetailsSeason extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/details/season';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrDetailsSeason> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    SonarrDetailsSeasonArguments _arguments;

    Future<Map<dynamic, dynamic>> _future;
    Map<dynamic, dynamic> _results;
    List<int> _selected = [];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() => { _arguments = ModalRoute.of(context).settings.arguments });
            _refresh();
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
        floatingActionButton: _floatingActionButton,
    );

    Future<void> _refresh() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        setState(() {
            _future = _api.getEpisodes(_arguments.seriesID, _arguments.season);
        });
    }

    Widget get _appBar => _arguments == null
        ? null
        : LSAppBar(title: _arguments.title);

    Widget get _floatingActionButton => _selected.length == 0
        ? null
        : LSFloatingActionButtonExtended(
            label: _selected.length == 1 ? '1 Episode' : '${_selected.length} Episodes',
            icon: Icons.search,
            onPressed: () => _searchSelected(),
        );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshIndicatorKey,
        onRefresh: () => _refresh(),
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

    Widget get _list => !_hasEpisodes
        ? LSGenericMessage(
            text: 'No Episodes Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : _arguments.season == -1
            ? _allSeasons
            : _singleSeason;

    Widget get _allSeasons {
        List<List<Widget>> _seasons = [];
        for(var entry in _results.keys) {
            if(entry != -1) _seasons.add(_season(entry));
        }
        return LSListView(
            children: _seasons.reversed.expand((element) => element).toList(),
        );
    }

    Widget get _singleSeason => LSListView(
        children: _season(_arguments.season),
    );

    List<Widget> _season(int seasonNumber) {
        List<SonarrEpisodeTile> episodeCards = [];
        for(int i=0; i<_results[seasonNumber].length; i++) episodeCards.add(SonarrEpisodeTile(
            data: _results[seasonNumber][_results[seasonNumber].length-i-1],
            selectedCallback: (status, episodeID) => _selectedCallback(status, episodeID),
        ));
        return [
            GestureDetector(
                child: seasonNumber == 0
                    ? LSHeader(text: 'Specials')
                    : LSHeader(text: 'Season $seasonNumber'),
                onTap: () => _selectSeason(episodeCards, seasonNumber),
                onLongPress: () => _searchSeason(seasonNumber),
            ),
            ...episodeCards,
        ];
    }

    void _selectedCallback(bool status, int episodeID) => status
        ? setState(() => _selected.add(episodeID))
        : setState(() => _selected.remove(episodeID));

    bool get _hasEpisodes {
        if(_results == null || _results.length == 0) return false;
        return true;
    }

    void _selectSeason(List<SonarrEpisodeTile> episodeCards, int seasonNumber) {
        bool flag = false;
        for(SonarrEpisodeData data in _results[seasonNumber]) {
            if(!data.isSelected) {
                flag = true;
                break;
            }
        }
        for(SonarrEpisodeData data in _results[seasonNumber]) {
            data.isSelected = flag ? true : false;
            if(flag) {
                if(!_selected.contains(data.episodeID))
                    _selected.add(data.episodeID);
            } else {
                _selected.remove(data.episodeID);
            }
        }
        setState(() {});
    }

    Future<void> _searchSelected() async {
        for(var key in _results.keys) {
            if(key != -1)  for(SonarrEpisodeData data in _results[key]) {
                data.isSelected = false;
            }
        }
        await SonarrAPI.from(Database.currentProfileObject).searchEpisodes(_selected)
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching for Episodes',
            message: 'Searching for ${_selected.length} ${_selected.length == 1 ? 'episode' : 'episodes'}',
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Search for Selected Episodes',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
        setState(() {
            _selected.clear();
        });
    }

    Future<void> _searchSeason(int season) async {
        List _values = await SonarrDialogs.searchEntireSeason(context, season);
        if(_values[0]) {
            SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
            await _api.searchSeason(_arguments.seriesID, season)
            .then((_) => LSSnackBar(
                context: context,
                title: 'Searching...',
                message: season == 0
                    ? 'Searching for all episodes in specials'
                    : 'Searching for all episodes in season $season',
            ))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Search',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }
}
