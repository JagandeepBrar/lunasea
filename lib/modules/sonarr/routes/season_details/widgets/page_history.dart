import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSeasonDetailsHistoryPage extends StatefulWidget {
  const SonarrSeasonDetailsHistoryPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeasonDetailsHistoryPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
    );
  }
}
