import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMetadataDetailsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/metadata/details/:ratingkey/:profile';
    final int ratingKey;

    TautulliMetadataDetailsRoute({
        Key key,
        @required this.ratingKey,
    }) : super(key: key);

    @override
    State<TautulliMetadataDetailsRoute> createState() => _State();

    static String route({
        String profile,
        @required int ratingKey,
    }) {
        if(profile == null) return '/tautulli/metadata/details/$ratingKey/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/metadata/details/$ratingKey/$profile';
    }

    static void defineRoute(Router router) => router.define(
        TautulliMetadataDetailsRoute.ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliMetadataDetailsRoute(
            ratingKey: int.tryParse(params['ratingkey'][0]),
        )),
        transitionType: LunaRouter.transitionType,
    );
}

class _State extends State<TautulliMetadataDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliLocalState>(context, listen: false).metadataNavigationIndex);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Metadata Details');

    Widget get _bottomNavigationBar => TautulliMetadataNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    List<Widget> get _tabs => [
        Container(),
        TautulliMetadataDetailsHistory(ratingKey: widget.ratingKey),
    ];

    void _onPageChanged(int index) => Provider.of<TautulliLocalState>(context, listen: false).metadataNavigationIndex = index;
}