import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaScaffold extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final PreferredSizeWidget appBar;
    final Widget body;
    final Widget drawer;
    final Widget bottomNavigationBar;
    final Widget floatingActionButton;
    final bool extendBody;
    final bool extendBodyBehindAppBar;

    LunaScaffold({
        Key key,
        @required this.scaffoldKey,
        this.appBar,
        this.body,
        this.drawer,
        this.bottomNavigationBar,
        this.floatingActionButton,
        this.extendBody = true,
        this.extendBodyBehindAppBar = true,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaWillPopScope(
            scaffoldKey: scaffoldKey,
            child: ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
                builder: (context, _, __) => Scaffold(
                    key: scaffoldKey,
                    appBar: appBar,
                    body: body,
                    drawer: drawer,
                    bottomNavigationBar: bottomNavigationBar,
                    floatingActionButton: floatingActionButton,
                    extendBody: extendBody,
                    extendBodyBehindAppBar: extendBodyBehindAppBar,
                    onDrawerChanged: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                ),
            ),
        );
    }
}
