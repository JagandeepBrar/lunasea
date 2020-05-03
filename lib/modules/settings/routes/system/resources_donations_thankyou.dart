import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:flare_flutter/flare_actor.dart';

const _MESSAGE = '''Thank you for supporting the open-source community! LunaSea was and still is a passion project built for the community, and will remain entirely open-source.\n
Donations are never expected or assumed, so thank you for giving back and helping LunaSea remain free, forever!''';

class SettingsSystemDonationsThankYou extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/donations/thankyou';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemDonationsThankYou> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Donations'),
        body: Padding(
            child: Column(
                children: [
                    Column(
                        children: [
                            LSHeader(
                                text: 'Thank You',
                                subtitle: _MESSAGE,
                            ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
    );
}
