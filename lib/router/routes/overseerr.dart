import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/overseerr/core/state.dart';
import 'package:lunasea/modules/overseerr/routes/overseerr/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum OverseerrRoutes with LunaRoutesMixin {
  HOME('/overseerr');

  @override
  final String path;

  const OverseerrRoutes(this.path);

  @override
  LunaModule get module => LunaModule.OVERSEERR;

  @override
  bool isModuleEnabled(BuildContext context) {
    return context.read<OverseerrState>().enabled;
  }

  @override
  GoRoute get routes {
    switch (this) {
      case OverseerrRoutes.HOME:
        return route(widget: const OverseerrRoute());
    }
  }
}
