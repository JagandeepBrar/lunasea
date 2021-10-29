import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNotEnabledRoute extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String module;

  LunaNotEnabledRoute({
    Key key,
    @required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: LunaAppBar(
        title: module,
        scrollControllers: const [],
      ),
      body: LunaMessage.moduleNotEnabled(
        context: context,
        module: module,
      ),
    );
  }
}
