import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrUpcomingRoute extends StatefulWidget {
    @override
    State<SonarrUpcomingRoute> createState() => _State();
}

class _State extends State<SonarrUpcomingRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<SonarrState>().resetUpcoming();
        await context.read<SonarrState>().upcoming;
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
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<SonarrState, Future<List<SonarrCalendar>>>(
            selector: (_, state) => state.upcoming,
            builder: (context, future, _) => FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<List<SonarrCalendar>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Sonarr upcoming episodes', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) {
                        return snapshot.data.length == 0
                            ? _noEpisodes()
                            : _episodes(snapshot.data);
                    }
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noEpisodes() => LSGenericMessage(
        text: 'No Episodes Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _episodes(List<SonarrCalendar> upcoming) {
        // Split episodes into days into a map
        Map<String, Map<String, dynamic>> _episodeMap = upcoming.fold({}, (map, entry) {
            if(entry.airDateUtc == null) return map;
            String _date = DateFormat('y-MM-dd').format(entry.airDateUtc.toLocal());
            if(!map.containsKey(_date)) map[_date] = {
                'date': DateFormat('EEEE / MMMM dd, y').format(entry.airDateUtc.toLocal()),
                'entries': [],
            };
            (map[_date]['entries'] as List).add(entry);
            return map;
        });
        // Build the widgets
        List<List<Widget>> _episodeWidgets = [];
        _episodeMap.keys.toList()..sort()..forEach((key) => {
            _episodeWidgets.add(_buildDay(
                (_episodeMap[key]['date'] as String),
                (_episodeMap[key]['entries'] as List).cast<SonarrCalendar>(),
            )),
        });
        // Return the list
        return LSListView(
            children: _episodeWidgets.expand((e) => e).toList(),
        );
    }

    List<Widget> _buildDay(String date, List<SonarrCalendar> upcoming) => [
        LSHeader(text: date),
        ...List.generate(
            upcoming.length,
            (index) => SonarrUpcomingTile(record: upcoming[index]),
        ),
    ];
}