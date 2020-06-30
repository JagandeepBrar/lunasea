import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrUpcoming extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/upcoming';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    SonarrUpcoming({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<SonarrUpcoming> createState() => _State();
}

class _State extends State<SonarrUpcoming> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<Map> _future;
    Map _results = {};

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = {};
        final _api = SonarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() {
            _future = _api.getUpcoming();
        });
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
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
            text: 'No Upcoming Episodes',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : _days;

    Widget get _days {
        List<List<Widget>> days = [];
        for(var key in _results.keys) if(_results[key]['entries'].length > 0) days.add(_day(key));
        return LSListView(
            children: days.expand((element) => element).toList(),
        );
    }

    List<Widget> _day(String day) {
        List<Widget> episodeCards = [];
        for(int i=0; i<_results[day]['entries'].length; i++) episodeCards.add(SonarrUpcomingTile(
            data: _results[day]['entries'][i],
            refresh: () => _refresh(),
            scaffoldKey: _scaffoldKey,
        ));
        return [
            LSHeader(
                text: _results[day]['date'],
                // subtitle: _results[day]['entries'].length == 1
                //     ? '1 Episode'
                //     : '${_results[day]['entries'].length} Episodes',
            ),
            ...episodeCards,
        ];
    }

    bool get _hasEpisodes {
        if(_results == null || _results.length == 0) return false;
        for(var key in _results.keys) {
            if(_results[key]['entries'].length > 0) return true;
        }
        return false;
    }
}
