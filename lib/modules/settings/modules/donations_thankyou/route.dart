import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsDonationsThankYouRouter {
    static const ROUTE_NAME = '/settings/donations/thankyou';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsDonationsThankYouRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsDonationsThankYouRouter._();
}

class _SettingsDonationsThankYouRoute extends StatefulWidget {
    @override
    State<_SettingsDonationsThankYouRoute> createState() => _State();
}

class _State extends State<_SettingsDonationsThankYouRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Donations',
    );

    Widget get _body => Padding(
        child: Column(
            children: [
                LSHeader(
                    text: 'Thank You',
                    subtitle: [
                        "Thank you for supporting the open-source community! ",
                        "LunaSea was and still is a passion project built for the community, and will remain entirely open-source.",
                        "\n\n",
                        "Donations are never expected or assumed, so thank you for giving back and helping LunaSea remain free, forever!",
                    ].join(),
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.only(top: 6.0),
    );
}
