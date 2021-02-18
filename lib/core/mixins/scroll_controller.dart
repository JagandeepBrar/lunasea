import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

mixin LunaScrollControllerMixin<T extends StatefulWidget> on State<T> {
    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (_) => ScrollController(),
            builder: (context, _) => child(context),
        );
    }

    Widget child(BuildContext context);
}
