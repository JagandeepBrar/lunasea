import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNotEnabledRoute extends StatelessWidget {
    final String module;

    LunaNotEnabledRoute({
        Key key,
        @required this.module, 
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: LunaAppBar(
                title: module,
                scrollControllers: [],
            ),
            body: LunaMessage.moduleNotEnabled(
                context: context,
                module: module,
            ),
        );
    }
}
