import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingRoute extends StatefulWidget {
    @override
    State<SonarrMissingRoute> createState() => _State();
}

class _State extends State<SonarrMissingRoute> with AutomaticKeepAliveClientMixin {
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
        _state.resetMissing();
        await _state.missing;
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
        child: Selector<SonarrState, Future<SonarrMissing>>(
            selector: (_, state) => state.missing,
            builder: (context, future, _) => FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<SonarrMissing> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_SonarrMissingRoute',
                                '_body',
                                'Unable to fetch Sonarr missing episodes',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) {
                        return snapshot.data.records.length == 0
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

    Widget _episodes(SonarrMissing missing) => LSListView(
        children: List.generate(
            missing.records.length,
            (index) => SonarrMissingTile(record: missing.records[index]),
        ),
    );
}