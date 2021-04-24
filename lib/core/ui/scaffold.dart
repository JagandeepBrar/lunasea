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

  /// Called when [LunaDatabaseValue.ENABLED_PROFILE] has changed. Triggered within the build function.
  final void Function(BuildContext) onProfileChange;

  LunaScaffold({
    Key key,
    @required this.scaffoldKey,
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.onProfileChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (drawer != null)
      return LunaWillPopScope(
        scaffoldKey: scaffoldKey,
        child: scaffold,
      );
    return scaffold;
  }

  Widget get scaffold {
    return ValueListenableBuilder(
      valueListenable: Database.lunaSeaBox
          .listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
      builder: (context, _, __) {
        if (onProfileChange != null) onProfileChange(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          body: body,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          onDrawerChanged: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        );
      },
    );
  }
}
