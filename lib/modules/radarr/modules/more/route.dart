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
            body: _body,
        );
    }

    Widget get _body => LunaListView(
        children: [
            // TODO:
            // LSCardTile(
            //     title: LSTitle(text: 'Health Check'),
            //     subtitle: LSSubtitle(text: 'Check for Configuration Issues'),
            //     trailing: LSIconButton(icon: CustomIcons.monitoring, color: LunaColours.list(0)),
            //     onTap: () async => RadarrHealthCheckRouter().navigateTo(context),
            // ),
            LSCardTile(
                title: LSTitle(text: 'History'),
                subtitle: LSSubtitle(text: 'View Recent Activity'),
                trailing: LSIconButton(icon: CustomIcons.history, color: LunaColours.list(0)),
                onTap: () async => RadarrHistoryRouter().navigateTo(context),
            ),
            // TODO:
            // LSCardTile(
            //     title: LSTitle(text: 'Queue'),
            //     subtitle: LSSubtitle(text: 'View Active & Queued Content'),
            //     trailing: LSIconButton(icon: Icons.queue, color: LunaColours.list(2)),
            //     onTap: () async => RadarrQueueRouter().navigateTo(context),
            // ),
            LSCardTile(
                title: LSTitle(text: 'System Status'),
                subtitle: LSSubtitle(text: 'System Status & Disk Space'),
                trailing: LSIconButton(icon: Icons.tune, color: LunaColours.list(1)),
                onTap: () async => RadarrSystemStatusRouter().navigateTo(context),
            ),
            LSCardTile(
                title: LSTitle(text: 'Tags'),
                subtitle: LSSubtitle(text: 'Manage Your Tags'),
                trailing: LSIconButton(icon: Icons.style, color: LunaColours.list(2)),
                onTap: () async => RadarrTagsRouter().navigateTo(context),
            ),
        ],
    );
}
