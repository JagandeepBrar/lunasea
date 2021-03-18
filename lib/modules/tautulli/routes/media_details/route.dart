import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsRouter extends TautulliPageRouter {
    TautulliMediaDetailsRouter() : super('/tautulli/media/:mediatype/:ratingkey');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required int ratingKey,
        @required TautulliMediaType mediaType,
    }) async => LunaRouter.router.navigateTo(context, route(ratingKey: ratingKey, mediaType: mediaType));

    @override
    String route({
        @required int ratingKey,
        @required TautulliMediaType mediaType,
    }) => fullRoute.replaceFirst(':mediatype', mediaType?.value ?? 'mediatype').replaceFirst(':ratingkey', ratingKey.toString());

    @override
    void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(router, (context, params) {
        TautulliMediaType mediaType = params['mediatype'] == null || params['mediatype'].length == 0 ? null : TautulliMediaType.NULL.from(params['mediatype'][0]);
        int ratingKey = params['ratingkey'] == null || params['ratingkey'].length == 0 ? -1 : int.tryParse(params['ratingkey'][0]) ?? -1;
        return _TautulliMediaDetailsRoute(ratingKey: ratingKey, mediaType: mediaType);
    });
}

class _TautulliMediaDetailsRoute extends StatefulWidget {
    final int ratingKey;
    final TautulliMediaType mediaType;

    _TautulliMediaDetailsRoute({
        Key key,
        @required this.ratingKey,
        @required this.mediaType,
    }) : super(key: key);

    @override
    State<_TautulliMediaDetailsRoute> createState() => _State();
}

class _State extends State<_TautulliMediaDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: widget.mediaType != null && widget.mediaType != TautulliMediaType.NULL && widget.ratingKey != null
            ? _body
            : _contentNotFound,
    );

    Widget get _appBar => LunaAppBar(title: 'Media Details');

    Widget get _bottomNavigationBar {
        if(
            widget.mediaType != null &&
            widget.mediaType != TautulliMediaType.NULL &&
            widget.mediaType != TautulliMediaType.COLLECTION &&
            widget.ratingKey != null
        ) return TautulliMediaDetailsNavigationBar(pageController: _pageController);
        return null;
    }


    Widget get _body => widget.mediaType != TautulliMediaType.COLLECTION
        ? PageView(
            controller: _pageController,
            children: _tabs,
        )
        : TautulliMediaDetailsMetadata(ratingKey: widget.ratingKey, type: widget.mediaType);

    List<Widget> get _tabs => [
        TautulliMediaDetailsMetadata(ratingKey: widget.ratingKey, type: widget.mediaType),
        TautulliMediaDetailsHistory(ratingKey: widget.ratingKey, type: widget.mediaType),
    ];

    Widget get _contentNotFound => LSGenericMessage(text: 'No Content Found');
}
