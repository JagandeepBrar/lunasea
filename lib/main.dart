import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:lunasea/routes.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Logger.initialize();
    await Configuration.pullAndSanitizeValues();
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
                routes: _setRoutes(),
                theme: _setTheme(),
            ),
        );
    }

    Map<String, WidgetBuilder> _setRoutes() {
        return <String, WidgetBuilder> {
            '/': (BuildContext context) => Home(),
            '/settings': (BuildContext context) => Settings(),
            '/lidarr': (BuildContext context) => Lidarr(),
            '/radarr': (BuildContext context) => Radarr(),
            '/sonarr': (BuildContext context) => Sonarr(),
            '/nzbget': (BuildContext context) => NZBGet(),
            '/sabnzbd': (BuildContext context) => SABnzbd(),
        };
    }

    ThemeData _setTheme() {
        const _textStyle = TextStyle(
            color: Colors.white,
            letterSpacing: Constants.LETTER_SPACING,
        );

        return ThemeData(
            canvasColor: Color(Constants.PRIMARY_COLOR),
            primaryColor: Color(Constants.SECONDARY_COLOR),
            accentColor: Color(Constants.ACCENT_COLOR),
            highlightColor: Color(Constants.SECONDARY_COLOR),
            cardColor: Color(Constants.SECONDARY_COLOR),
            splashColor: Color(Constants.SPLASH_COLOR),
            dialogBackgroundColor: Color(Constants.SECONDARY_COLOR),
            dividerColor: Color(Constants.ACCENT_COLOR).withAlpha(0),
            iconTheme: IconThemeData(
                color: Colors.white,
            ),
            unselectedWidgetColor: Colors.white,
            textTheme: TextTheme(
                body1: _textStyle,
                body2: _textStyle,
                display1: _textStyle,
                display2: _textStyle,
                display3: _textStyle,
                display4: _textStyle,
                headline: _textStyle,
                button: _textStyle,
                caption: _textStyle,
                title: _textStyle,
                subtitle: _textStyle,
                subhead: _textStyle,
                overline: _textStyle,
            ),
        );
    }
}
