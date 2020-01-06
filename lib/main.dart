import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/pages/pages.dart';
import 'package:lunasea/configuration/configuration.dart';
import 'package:lunasea/system/logger.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Configuration.pullAndSanitizeValues();
    Logger.initialize();
    runZoned<Future<void>>(() async {
        runApp(_BIOS());
    }, onError: (Object error, StackTrace stack) {
        Logger.fatal(error, stack);
    });
}

class _BIOS extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'LunaSea',
            debugShowCheckedModeBanner: false,
            routes: _setRoute(),
            theme: _setTheme(),
        );
    }

    Map<String, WidgetBuilder> _setRoute() {
        return <String, WidgetBuilder> {
            '/': (BuildContext context) => Home(),
            '/settings': (BuildContext context) => Settings(),
            '/lidarr': (BuildContext context) => Lidarr(),
            '/radarr': (BuildContext context) => Radarr(),
            '/sonarr': (BuildContext context) => Sonarr(),
            '/sabnzbd': (BuildContext context) => SABnzbd(),
        };
    }

    ThemeData _setTheme() {
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
                body1: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                body2: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                display1: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                display2: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                display3: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                display4: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                headline: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                button: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                caption: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                title: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                subtitle: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                subhead: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
                overline: TextStyle(
                    color: Colors.white,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
        );
    }
}
