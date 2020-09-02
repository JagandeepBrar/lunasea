import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:flare_flutter/flare_actor.dart';

class SettingsDonationsThankYouRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/donations/thankyou';

    SettingsDonationsThankYouRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsDonationsThankYouRoute> createState() => _State();
}

class _State extends State<SettingsDonationsThankYouRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Donations');

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
                Container(
                    height: MediaQuery.of(context).size.height/3,
                    width: MediaQuery.of(context).size.width,
                    child: FlareActor(
                        RiveAnimations.CODER['path'],
                        shouldClip: false,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: RiveAnimations.CODER['animation'],
                    ),
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.only(top: 6.0),
    );
}
