import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class DonationsThankYouRoute extends StatefulWidget {
  const DonationsThankYouRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<DonationsThankYouRoute> createState() => _State();
}

class _State extends State<DonationsThankYouRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
            "Donations are never expected or assumed, so thank you for giving back and helping LunaSea remain free, forever!",
          ].join("\n\n"),
        ),
      ],
    );
  }
}
