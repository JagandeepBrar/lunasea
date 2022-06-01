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

  /// Called when [LunaSeaDatabase.ENABLED_PROFILE] has changed. Triggered within the build function.
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaWillPopScope(
      scaffoldKey: scaffoldKey,
      child: scaffold,
    );
  }

  Widget get scaffold {
    return LunaSeaDatabase.ENABLED_PROFILE.listen(
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
