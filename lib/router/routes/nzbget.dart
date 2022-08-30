import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/nzbget/routes/nzbget.dart';
import 'package:lunasea/modules/nzbget/routes/statistics.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum NZBGetRoutes with LunaRoutesMixin {
  HOME('/nzbget'),
  STATISTICS('statistics');

  @override
  final String path;

  const NZBGetRoutes(this.path);

  @override
  LunaModule get module => LunaModule.NZBGET;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case NZBGetRoutes.HOME:
        return route(widget: const NZBGetRoute());
      case NZBGetRoutes.STATISTICS:
        return route(widget: const StatisticsRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case NZBGetRoutes.HOME:
        return [
          NZBGetRoutes.STATISTICS.routes,
        ];
      default:
        return const [];
    }
  }
}
