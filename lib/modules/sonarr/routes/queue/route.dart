import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueRouter extends SonarrPageRouter {
    SonarrQueueRouter() : super('/sonarr/queue');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SonarrQueueRoute());
}

class _SonarrQueueRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrQueueRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<SonarrState>().resetQueue();
        await context.read<SonarrState>().queue;
    }

    @override
    Widget build(BuildContext context) =>  LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
    );

    Widget _appBar() {
        return LunaAppBar(
            title: 'Queue',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: _refresh,
            child: FutureBuilder(
                future: context.watch<SonarrState>().queue,
                builder: (context, AsyncSnapshot<List<SonarrQueueRecord>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Sonarr queue', snapshot.error, snapshot.stackTrace);
                        }
                        return LunaMessage.error(onTap: _refreshKey.currentState?.show);
                    }
                    if(snapshot.hasData) return _queue(snapshot.data);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _queue(List<SonarrQueueRecord> queue) {
        if((queue?.length ?? 0) == 0) return LunaMessage(
            text: 'Empty Queue',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState.show,
        );
        return LunaListViewBuilder(
            controller: scrollController,
            itemCount: queue.length,
            itemBuilder: (context, index) => SonarrQueueQueueTile(
                key: ObjectKey(queue[index].id),
                record: queue[index],
            ),
        );
    }
}
