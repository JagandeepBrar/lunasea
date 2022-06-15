import 'package:flutter/material.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/system/platform.dart';

class LunaScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final LunaModule? module;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  /// Called when [LunaSeaDatabase.ENABLED_PROFILE] has changed. Triggered within the build function.
  final void Function(BuildContext)? onProfileChange;

  // ignore: use_key_in_widget_constructors
  const LunaScaffold({
    this.scaffoldKey,
    this.module,
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.onProfileChange,
  });

  @override
  Widget build(BuildContext context) {
    final state = scaffoldKey?.currentState;
    final hasDrawer = state?.hasDrawer ?? false;

    if (hasDrawer && LunaPlatform.isAndroid) {
      return WillPopScope(
        onWillPop: () async {
          if (state!.isDrawerOpen) return true;
          state.openDrawer();
          return false;
        },
        child: scaffold,
      );
    }

    return scaffold;
  }

  Widget get scaffold {
    return LunaSeaDatabase.ENABLED_PROFILE.watch(
      builder: (context, _) {
        onProfileChange?.call(context);
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
