import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryRoute extends StatefulWidget {
    @override
    State<SonarrHistoryRoute> createState() => _State();
}

class _State extends State<SonarrHistoryRoute> with AutomaticKeepAliveClientMixin {
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
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _state.resetHistory();
        await _state.history;
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body(),
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: _refresh,
            child: Selector<SonarrState, Future<SonarrHistory>>(
                selector: (_, state) => state.history,
                builder: (context, future, _) => FutureBuilder(
                    future: future,
                    builder: (context, AsyncSnapshot<SonarrHistory> snapshot) {
                        if(snapshot.hasError) {
                            if(snapshot.connectionState != ConnectionState.waiting) {
                                LunaLogger().error('Unable to fetch Sonarr history', snapshot.error, snapshot.stackTrace);
                            }
                            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
                        }
                        if(snapshot.hasData) return _history(snapshot.data);
                        return LunaLoader();
                    },
                ),
            ),
        );
    }

    Widget _history(SonarrHistory history) {
        if((history?.records?.length ?? 0) == 0) return LunaMessage(
            text: 'No History Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState?.show,
        );
        return LunaListViewBuilder(
            controller: SonarrNavigationBar.scrollControllers[3],
            itemCount: history.records.length,
            itemBuilder: (context, index) => SonarrHistoryTile(record: history.records[index]),
        );
    }
}
