import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

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

    Widget get _list => Text('');
}
