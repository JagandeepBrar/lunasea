import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final LunaModule? module;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool hideDrawer;

  /// Called when [LunaDatabaseValue.ENABLED_PROFILE] has changed. Triggered within the build function.
  final void Function(BuildContext)? onProfileChange;

  const LunaScaffold({
    Key? key,
    required this.scaffoldKey,
    this.module,
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.onProfileChange,
    this.hideDrawer = false,
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
      valueListenable: Database.lunasea.box.listenable(
        keys: [LunaDatabaseValue.ENABLED_PROFILE.key],
      ),
      builder: (context, dynamic _, __) {
        if (onProfileChange != null) onProfileChange!(context);
        return AdaptiveBuilder.builder(
          builder: (context, layout, child) {
            if (kDebugMode && layout.breakpoint >= LayoutBreakpoint.md)
              return _scaffoldMedium(child!);
            return _scaffoldSmall(child);
          },
          child: body,
        );
      },
    );
  }

  Widget _scaffoldSmall(Widget? child) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: child,
      drawer: hideDrawer ? null : drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      onDrawerChanged: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  Widget _scaffoldMedium(Widget child) => Scaffold(
        key: scaffoldKey,
        body: Row(
          children: [
            if (!hideDrawer) LunaDrawer(page: module?.key ?? ''),
            Expanded(
              child: Column(
                children: [
                  if (appBar != null) appBar!,
                  Expanded(child: child),
                  if (bottomNavigationBar != null) bottomNavigationBar!,
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        onDrawerChanged: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      );
}
