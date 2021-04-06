import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoreRoute extends StatefulWidget {
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
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            body: _body(),
        );
    }

    Widget _body() {
        return LunaListView(
            controller: RadarrNavigationBar.scrollControllers[3],
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'radarr.History'.tr()),
                    subtitle: LunaText.subtitle(text: 'radarr.HistoryDescription'.tr()),
                    trailing: LunaIconButton(icon: Icons.history_rounded, color: LunaColours.list(0)),
                    onTap: () async => RadarrHistoryRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'radarr.ManualImport'.tr()),
                    subtitle: LunaText.subtitle(text: 'radarr.ManualImportDescription'.tr()),
                    trailing: LunaIconButton(icon: Icons.download_done_rounded, color: LunaColours.list(1)),
                    onTap: () async => RadarrManualImportRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'radarr.Queue'.tr()),
                    subtitle: LunaText.subtitle(text: 'radarr.QueueDescription'.tr()),
                    trailing: LunaIconButton(icon: Icons.queue_rounded, color: LunaColours.list(2)),
                    onTap: () async => RadarrQueueRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'radarr.SystemStatus'.tr()),
                    subtitle: LunaText.subtitle(text: 'radarr.SystemStatusDescription'.tr()),
                    trailing: LunaIconButton(icon: LunaIcons.monitoring, color: LunaColours.list(3)),
                    onTap: () async => RadarrSystemStatusRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'radarr.Tags'.tr()),
                    subtitle: LunaText.subtitle(text: 'radarr.TagsDescription'.tr()),
                    trailing: LunaIconButton(icon: Icons.style_rounded, color: LunaColours.list(4)),
                    onTap: () async => RadarrTagsRouter().navigateTo(context),
                ),
            ],
        );
    }
}
