import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliIPAddressDetailsRouter extends TautulliPageRouter {
  TautulliIPAddressDetailsRouter() : super('/tautulli/ipaddress/:ipaddress');

  @override
  _Widget widget({
    @required String ipAddress,
  }) =>
      _Widget(ipAddress: ipAddress);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required String ipAddress,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(ipAddress: ipAddress),
      );

  @override
  String route({
    @required String ipAddress,
  }) =>
      fullRoute.replaceFirst(':ipaddress', ipAddress);

  @override
  void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(
        router,
        (context, params) {
          String ipAddress = (params['ipaddress']?.isNotEmpty ?? false)
              ? params['ipaddress'][0]
              : null;
          return _Widget(ipAddress: ipAddress);
        },
      );
}

class _Widget extends StatefulWidget {
  final String ipAddress;

  _Widget({
    Key key,
    @required this.ipAddress,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TautulliIPAddressDetailsState(context, widget.ipAddress),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'IP Address Details',
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<TautulliIPAddressDetailsState>().fetchAll(context),
      child: FutureBuilder(
        future: Future.wait([
          context.watch<TautulliIPAddressDetailsState>().geolocation,
          context.watch<TautulliIPAddressDetailsState>().whois,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Tautulli IP address information',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData)
            return _list(snapshot.data[0], snapshot.data[1]);
          return LunaLoader();
        },
      ),
    );
  }

  Widget _list(TautulliGeolocationInfo geolocation, TautulliWHOISInfo whois) {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaHeader(text: 'Location'),
        TautulliIPAddressDetailsGeolocationTile(geolocation: geolocation),
        LunaHeader(text: 'Connection'),
        TautulliIPAddressDetailsWHOISTile(whois: whois),
      ],
    );
  }
}
