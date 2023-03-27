import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/rss/routes/feeds/route.dart';
import 'package:lunasea/modules/rss/routes/results/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum RssRoutes with LunaRoutesMixin {
  HOME('/rss'),
  RESULTS('results');

  @override
  final String path;

  const RssRoutes(this.path);

  @override
  LunaModule get module => LunaModule.RSS;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case RssRoutes.HOME:
        return route(widget: const RssRoute());
      case RssRoutes.RESULTS:
        return route(widget: const RssResultsRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case RssRoutes.HOME:
        return [
          RssRoutes.RESULTS.routes,
        ];
      default:
        return const [];
    }
  }
}
