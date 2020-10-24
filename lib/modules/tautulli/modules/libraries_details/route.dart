import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/libraries/details/:sectionid';

    static Future<void> navigateTo(BuildContext context, {
        @required int sectionId,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(sectionId: sectionId),
    );

    static String route({ @required int sectionId }) => ROUTE_NAME.replaceFirst(':sectionid', sectionId?.toString() ?? '-1');

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLibrariesDetailsRoute(
                sectionId: params['sectionid'] != null && params['sectionid'].length != 0
                    ? int.tryParse(params['sectionid'][0]) ?? -1
                    : -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLibrariesDetailsRouter._();
}

class _TautulliLibrariesDetailsRoute extends StatefulWidget {
    final int sectionId;

    _TautulliLibrariesDetailsRoute({
        Key key,
        @required this.sectionId,
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

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Library Details',
        popUntil: '/tautulli',
    );

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
    );

    List<Widget> get _tabs => [
        TautulliLibrariesDetailsInformation(sectionId: widget.sectionId),
        TautulliLibrariesDetailsUserStats(sectionId: widget.sectionId),
    ];
}
