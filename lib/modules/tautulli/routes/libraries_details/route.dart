import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsRouter extends TautulliPageRouter {
    TautulliLibrariesDetailsRouter() : super('/tautulli/libraries/:sectionid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int sectionId }) async => LunaRouter.router.navigateTo(context, route(sectionId: sectionId));

    @override
    String route({ @required int sectionId }) => fullRoute.replaceFirst(':sectionid', sectionId.toString());

    @override
    void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(router, (context, params) {
        int sectionId = params['sectionid'] == null || params['sectionid'].length == 0 ? -1 : int.tryParse(params['sectionid'][0]) ?? -1;
        return _TautulliLibrariesDetailsRoute(sectionId: sectionId);
    });
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

    Widget get _appBar => LunaAppBar(title: 'Library Details');

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
    );

    List<Widget> get _tabs => [
        TautulliLibrariesDetailsInformation(sectionId: widget.sectionId),
        TautulliLibrariesDetailsUserStats(sectionId: widget.sectionId),
    ];
}
