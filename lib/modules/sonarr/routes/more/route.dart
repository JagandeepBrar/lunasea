import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMoreRoute extends StatefulWidget {
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
      body: _body(),
    );
  }

  Widget _body() {
    return LunaListView(
      controller: SonarrNavigationBar.scrollControllers[3],
      children: [
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'sonarr.History'.tr()),
          subtitle: LunaText.subtitle(text: 'sonarr.HistoryDescription'.tr()),
          trailing: LunaIconButton(
            icon: Icons.history_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: () async => SonarrHistoryRouter().navigateTo(context),
        ),
        /** LunaListTile(
          context: context,
          title: LunaText.title(text: 'sonarr.ManualImport'.tr()),
          subtitle:
              LunaText.subtitle(text: 'sonarr.ManualImportDescription'.tr()),
          trailing: LunaIconButton(
            icon: Icons.download_done_rounded,
            color: LunaColours().byListIndex(1),
          ),
        ),
        **/
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'sonarr.Queue'.tr()),
          subtitle: LunaText.subtitle(text: 'sonarr.QueueDescription'.tr()),
          trailing: LunaIconButton(
            icon: Icons.queue_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: () async => SonarrQueueRouter().navigateTo(context),
        ),
        /**
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'sonarr.SystemStatus'.tr()),
          subtitle:
              LunaText.subtitle(text: 'sonarr.SystemStatusDescription'.tr()),
          trailing: LunaIconButton(
            icon: LunaIcons.monitoring,
            color: LunaColours().byListIndex(1),
          ),
        ),
        **/
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'sonarr.Tags'.tr()),
          subtitle: LunaText.subtitle(text: 'sonarr.TagsDescription'.tr()),
          trailing: LunaIconButton(
            icon: Icons.style_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: () async => SonarrTagsRouter().navigateTo(context),
        ),
      ],
    );
  }
}
