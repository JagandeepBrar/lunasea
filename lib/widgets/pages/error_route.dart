import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class ErrorRoutePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Exception? exception;

  ErrorRoutePage({
    Key? key,
    this.exception,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: LunaAppBar(
        title: 'LunaSea',
        scrollControllers: const [],
      ),
      body: LunaMessage.goBack(
        context: context,
        text: exception?.toString() ?? '404: Not Found',
      ),
    );
  }
}
