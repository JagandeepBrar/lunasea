import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrTagsRouter {
    static const String ROUTE_NAME = '/sonarr/tags/list';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrTagsRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrTagsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrTagsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<SonarrState>().resetTags();
        await context.read<SonarrState>().tags;
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Tags',
        actions: [
            SonarrTagsAppBarActionAddTag(),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: context.watch<SonarrState>().tags,
            builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_SonarrTagsRoute',
                            '_body',
                            'Unable to fetch Sonarr tags',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
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

    Widget _tags(List<SonarrTag> tags) => LSListView(
        children: List.generate(
            tags.length,
            (index) => SonarrTagsTagTile(
                key: ObjectKey(tags[index].id),
                tag: tags[index],
            ),
        ),
    );
}
