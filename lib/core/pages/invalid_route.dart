import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaInvalidRoute extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String title;
  final String message;

  LunaInvalidRoute({
    Key key,
    this.title = 'LunaSea',
    this.message = '404: Not Found',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SETTINGS,
      appBar: LunaAppBar(
        title: title,
        scrollControllers: const [],
      ),
      body: LunaMessage.goBack(
        context: context,
        text: message,
      ),
    );
  }
}
