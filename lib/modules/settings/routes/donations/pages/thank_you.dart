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
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'settings.Donations'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaHeader(
          text: 'lunasea.ThankYou'.tr(),
          subtitle: 'lunasea.ThankYouMessage'.tr(),
        ),
      ],
    );
  }
}
