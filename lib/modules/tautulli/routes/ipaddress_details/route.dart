import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliIPAddressDetailsRouter extends TautulliPageRouter {
    TautulliIPAddressDetailsRouter() : super('/tautulli/ipaddress/:ipaddress');

    @override
    Future<void> navigateTo(BuildContext context, { @required String ipAddress }) async => LunaRouter.router.navigateTo(context, route(ipAddress: ipAddress));

    @override
    String route({ @required String ipAddress }) => fullRoute.replaceFirst(':ipaddress', ipAddress);

    @override
    void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(router, (context, params) {
        String ipAddress = params['ipaddress'] == null || params['ipaddress'].length == 0 ? null : params['ipaddress'][0];
        return _TautulliIPAddressRoute(ipAddress: ipAddress);
    });
}

class _TautulliIPAddressRoute extends StatefulWidget {
    final String ipAddress;

    _TautulliIPAddressRoute({
        Key key,
        @required this.ipAddress,
    }) : super(key: key);

    @override
    State<_TautulliIPAddressRoute> createState() => _State();
}

class _State extends State<_TautulliIPAddressRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<TautulliState>().fetchGeolocationInformation(widget.ipAddress);
        context.read<TautulliState>().fetchWHOISInformation(widget.ipAddress);
        setState(() => _initialLoad = true);
        await Future.wait([
            context.read<TautulliState>().geolocationInformation[widget.ipAddress],
            context.read<TautulliState>().whoisInformation[widget.ipAddress],
        ]);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _initialLoad ? _body : LSLoader(),
    );

    Widget get _appBar => LunaAppBar(title: 'IP Address Details');

    Widget get _body => FutureBuilder(
        future: Future.wait([
            context.watch<TautulliState>().geolocationInformation[widget.ipAddress],
            context.watch<TautulliState>().whoisInformation[widget.ipAddress],
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if(snapshot.hasError) {
                if(snapshot.connectionState != ConnectionState.waiting) {
                    LunaLogger().error('Unable to fetch Tautulli IP address information', snapshot.error, StackTrace.current);
                }
                return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
            }
            if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);          
            return LSLoader(); 
        },
    );

    Widget _list(TautulliGeolocationInfo geolocation, TautulliWHOISInfo whois) => LSListView(
        children: [
            TautulliIPAddressDetailsGeolocationTile(geolocation: geolocation),
            TautulliIPAddressDetailsWHOISTile(whois: whois),
        ],
    );
}
