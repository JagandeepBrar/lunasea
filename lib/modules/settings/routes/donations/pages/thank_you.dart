import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsDonationsThankYouRouter extends LunaPageRouter {
    SettingsDonationsThankYouRouter() : super('/settings/donations/thankyou');

    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsDonationsThankYouRoute());
}

class _SettingsDonationsThankYouRoute extends StatefulWidget {
    @override
    State<_SettingsDonationsThankYouRoute> createState() => _State();
}

class _State extends State<_SettingsDonationsThankYouRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Donations',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaHeader(
                    text: 'Thank You',
                    subtitle: [
                        "Thank you for supporting the open-source community!",
                        "Donations are never expected or assumed, so thank you for giving back and helping ${Constants.APPLICATION_NAME} remain free, forever!",
                    ].join("\n\n"),
                ),
            ],
        );
    }
}
