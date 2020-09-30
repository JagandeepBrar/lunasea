import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/add/details/:tvdbid';

    static Future<void> navigateTo(BuildContext context, {
        @required int tvdbId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(tvdbId: tvdbId),
    );

    static String route({ @required int tvdbId }) => ROUTE_NAME
        .replaceFirst(':tvdbid', tvdbId?.toString() ?? '-1');

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesAddDetailsRoute(
                tvdbId: int.tryParse(params['tvdbid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesAddDetailsRoute extends StatefulWidget {
    final int tvdbId;

    _SonarrSeriesAddDetailsRoute({
        Key key,
        @required this.tvdbId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesAddDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Add Series',
        popUntil: '/sonarr',
        actions: [
            SonarrSeriesDetailsAppbarLinkAction(tvdbId: widget.tvdbId),
        ],
    );

    Widget get _body => FutureBuilder(
        future: Provider.of<SonarrLocalState>(context, listen: false).seriesLookup,
        builder: (context, AsyncSnapshot<List<SonarrSeriesLookup>> snapshot) {
            if(snapshot.hasError) return LSErrorMessage(hideButton: true, onTapHandler: () => null);
            if(snapshot.hasData) {
                SonarrSeriesLookup series = snapshot.data.firstWhere(
                    (series) => series?.tvdbId == widget.tvdbId,
                    orElse: () => null,
                );
                if(series != null) return _list(series);
                return _unknown;
            }
            return LSLoader();
        },
    );

    Widget _list(SonarrSeriesLookup series) => LSListView(
        children: [
            SonarrSeriesAddSearchResultTile(series: series, onTapShowOverview: true),
        ],
    );

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
