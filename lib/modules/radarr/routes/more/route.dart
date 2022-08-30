import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/radarr.dart';

class RadarrMoreRoute extends StatefulWidget {
  const RadarrMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<RadarrMoreRoute> createState() => _State();
}

class _State extends State<RadarrMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaListView(
      controller: RadarrNavigationBar.scrollControllers[3],
      itemExtent: LunaBlock.calculateItemExtent(1),
      children: [
        LunaBlock(
          title: 'radarr.History'.tr(),
          body: [TextSpan(text: 'radarr.HistoryDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.history_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: RadarrRoutes.HISTORY.go,
        ),
        LunaBlock(
          title: 'radarr.ManualImport'.tr(),
          body: [TextSpan(text: 'radarr.ManualImportDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.download_done_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: RadarrRoutes.MANUAL_IMPORT.go,
        ),
        LunaBlock(
          title: 'radarr.Queue'.tr(),
          body: [TextSpan(text: 'radarr.QueueDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.queue_play_next_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: RadarrRoutes.QUEUE.go,
        ),
        LunaBlock(
          title: 'radarr.SystemStatus'.tr(),
          body: [TextSpan(text: 'radarr.SystemStatusDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.computer_rounded,
            color: LunaColours().byListIndex(3),
          ),
          onTap: RadarrRoutes.SYSTEM_STATUS.go,
        ),
        LunaBlock(
          title: 'radarr.Tags'.tr(),
          body: [TextSpan(text: 'radarr.TagsDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.style_rounded,
            color: LunaColours().byListIndex(4),
          ),
          onTap: RadarrRoutes.TAGS.go,
        ),
      ],
    );
  }
}
