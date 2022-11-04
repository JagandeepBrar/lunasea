import 'package:flutter/material.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/system/sentry.dart';
import 'package:lunasea/widgets/pages/error_route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

class LunaRouter {
  static late GoRouter router;
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  void initialize() {
    router = GoRouter(
      navigatorKey: navigator,
      errorBuilder: (_, state) => ErrorRoutePage(exception: state.error),
      initialLocation: LunaRoutes.initialLocation,
      observers: [LunaSentry().navigatorObserver],
      routes: LunaRoutes.values.map((r) => r.root.routes).toList(),
    );
  }

  void popSafely() {
    if (router.canPop()) router.pop();
  }

  void popToRootRoute() {
    if (navigator.currentState == null) {
      LunaLogger().warning('Not observing any navigation navigators, skipping');
      return;
    }
    navigator.currentState!.popUntil((route) => route.isFirst);
  }
}
