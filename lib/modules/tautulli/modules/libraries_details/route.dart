import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/libraries/details/:sectionid';

    static Future<void> navigateTo(BuildContext context, {
        @required int sectionId,
    }) async => TautulliRouter.router.navigateTo(
        context,
        route(sectionId: sectionId),
    );

    static String route({
        String profile,
        @required int sectionId,
    }) => [
        ROUTE_NAME.replaceFirst(':sectionid', sectionId?.toString() ?? '-1'),
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliLibrariesDetailsRoute(
                sectionId: params['sectionid'] != null && params['sectionid'].length != 0
                    ? int.tryParse(params['sectionid'][0]) ?? -1
                    : -1,
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLibrariesDetailsRoute(
                sectionId: params['sectionid'] != null && params['sectionid'].length != 0
                    ? int.tryParse(params['sectionid'][0]) ?? -1
                    : -1,
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLibrariesDetailsRouter._();
}

class _TautulliLibrariesDetailsRoute extends StatefulWidget {
    final String profile;
    final int sectionId;

    _TautulliLibrariesDetailsRoute({
        @required this.profile,
        @required this.sectionId,
        Key key,
    }) : super(key: key);

    @override
    State<_TautulliLibrariesDetailsRoute> createState() => _State();
}

class _State extends State<_TautulliLibrariesDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
        bottomNavigationBar: TautulliLibrariesDetailsNavigationBar(pageController: _pageController),
    );

    Widget get _appBar => LSAppBar(title: 'Library Details');

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
    );

    List<Widget> get _tabs => [
        TautulliLibrariesDetailsInformation(sectionId: widget.sectionId),
        TautulliLibrariesDetailsUserStats(sectionId: widget.sectionId),
    ];
}
