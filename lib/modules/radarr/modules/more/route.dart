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
        return Scaffold(
            key: _scaffoldKey,
            body: _body(),
        );
    }

    Widget _body() {
        return LunaListView(
            scrollController: RadarrNavigationBar.scrollControllers[3],
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Health Check'),
                    subtitle: LunaText.subtitle(text: 'Check for Configuration Issues'),
                    trailing: LunaIconButton(icon: CustomIcons.monitoring, color: LunaColours.list(0)),
                    onTap: () async => RadarrHealthCheckRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'History'),
                    subtitle: LunaText.subtitle(text: 'View Recent Activity'),
                    trailing: LunaIconButton(icon: CustomIcons.history, color: LunaColours.list(1)),
                    onTap: () async => RadarrHistoryRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Queue'),
                    subtitle: LunaText.subtitle(text: 'View Active & Queued Content'),
                    trailing: LunaIconButton(icon: Icons.queue, color: LunaColours.list(2)),
                    onTap: () async => RadarrQueueRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'System Status'),
                    subtitle: LunaText.subtitle(text: 'System Status & Disk Space'),
                    trailing: LunaIconButton(icon: Icons.tune, color: LunaColours.list(3)),
                    onTap: () async => RadarrSystemStatusRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Tags'),
                    subtitle: LunaText.subtitle(text: 'Manage Your Tags'),
                    trailing: LunaIconButton(icon: Icons.style, color: LunaColours.list(4)),
                    onTap: () async => RadarrTagsRouter().navigateTo(context),
                ),
            ],
        );
    }
}
