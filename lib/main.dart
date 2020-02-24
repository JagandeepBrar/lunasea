import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/routes.dart';

void main() async {
    await Database.initialize();
    Logger.initialize();
    runZoned<Future<void>>(() async {
        runApp(_BIOS());
    }, onError: (Object error, StackTrace stack) {
        Logger.fatal(error, stack);
    });
}

class _BIOS extends StatelessWidget {
    final Store<AppState> store = Store<AppState>(
        appReducer,
        initialState: AppState.initialState(),
    );

    @override
    Widget build(BuildContext context) {
        return StoreProvider(
            store: store,
            child: MaterialApp(
                title: 'LunaSea',
                debugShowCheckedModeBanner: false,
                routes: Routes.getRoutes(),
                theme: Themes.getDefaultTheme(),
            ),
        );
    }
}
