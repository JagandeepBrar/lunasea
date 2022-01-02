import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliActivityDetailsMetadataBlock extends StatelessWidget {
  final TautulliSession session;

  const TautulliActivityDetailsMetadataBlock({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
            title: 'tautulli.Title'.tr(), body: session.lunaFullTitle),
        if (session.year != null)
          LunaTableContent(title: 'tautulli.Year'.tr(), body: session.lunaYear),
        LunaTableContent(
            title: 'tautulli.Duration'.tr(), body: session.lunaDuration),
        LunaTableContent(title: 'tautulli.ETA'.tr(), body: session.lunaETA),
        LunaTableContent(
            title: 'tautulli.Library'.tr(), body: session.lunaLibraryName),
        LunaTableContent(
            title: 'tautulli.User'.tr(), body: session.lunaFriendlyName),
      ],
    );
  }
}
