import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrTagsRouter extends LunaPageRouter {
    RadarrTagsRouter() : super('/radarr/tags/list');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrTagsRoute());
}

class _RadarrTagsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrTagsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<RadarrState>().fetchTags();
        await context.read<RadarrState>().tags;
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        title: 'Tags',
        actions: [
            RadarrTagsAppBarActionAddTag(),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: context.watch<RadarrState>().tags,
            builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Radarr tags', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return snapshot.data.length == 0
                    ? _noTags
                    : _tags(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget get _noTags => LSGenericMessage(
        text: 'No Tags Found',
        buttonText: 'Refresh',
        showButton: true,
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _tags(List<RadarrTag> tags) => LSListView(
        children: List.generate(
            tags.length,
            (index) => RadarrTagsTagTile(
                key: ObjectKey(tags[index].id),
                tag: tags[index],
            ),
        ),
    );
}
