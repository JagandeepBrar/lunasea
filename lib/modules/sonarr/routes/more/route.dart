import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

class SonarrMoreRoute extends StatefulWidget {
  const SonarrMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SonarrMoreRoute> createState() => _State();
}

class _State extends State<SonarrMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: _body(),
    );
  }

  // ignore: unused_element
  Future<void> _showComingSoonMessage() async {
    showLunaInfoSnackBar(
      title: 'lunasea.ComingSoon'.tr(),
      message: 'This feature is still being developed!',
    );
  }

  Widget _body() {
    return LunaListView(
      controller: SonarrNavigationBar.scrollControllers[3],
      children: [
        LunaBlock(
          title: 'sonarr.History'.tr(),
          body: [TextSpan(text: 'sonarr.HistoryDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.history_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: SonarrRoutes.HISTORY.go,
        ),
        // LunaBlock(
        //   title: 'sonarr.ManualImport'.tr(),
        //   body: [TextSpan(text: 'sonarr.ManualImportDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.download_done_rounded,
        //     color: LunaColours().byListIndex(1),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'sonarr.Queue'.tr(),
          body: [TextSpan(text: 'sonarr.QueueDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.queue_play_next_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: SonarrRoutes.QUEUE.go,
        ),
        // LunaBlock(
        //   title: 'sonarr.SystemStatus'.tr(),
        //   body: [TextSpan(text: 'sonarr.SystemStatusDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.computer_rounded,
        //     color: LunaColours().byListIndex(3),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'sonarr.Tags'.tr(),
          body: [TextSpan(text: 'sonarr.TagsDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.style_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: SonarrRoutes.TAGS.go,
        ),
      ],
    );
  }
}
