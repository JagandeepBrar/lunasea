import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusAboutPage extends StatefulWidget {
    final ScrollController scrollController;

    RadarrSystemStatusAboutPage({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrSystemStatusAboutPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<RadarrSystemStatus> _status;

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        if(context.read<RadarrState>().enabled && mounted) setState(() {
            _status = context.read<RadarrState>().api.system.status();
        });
        await _status;
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _status,
            builder: (context, AsyncSnapshot<RadarrSystemStatus> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr system status', snapshot.error, snapshot.stackTrace);
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _about(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _about(RadarrSystemStatus status) => LunaListView(
        scrollController: widget.scrollController,
        children: [
            LSTableBlock(
                children: [
                    LSTableContent(title: 'Version', body: status.lunaVersion),
                    LSTableContent(title: 'Package', body: status.lunaPackageVersion),
                    LSTableContent(title: '.NET Core', body: status.lunaNetCore),
                    LSTableContent(title: 'Docker', body: status.lunaDocker),
                    LSTableContent(title: 'Migration', body: status.lunaDBMigration),
                    LSTableContent(title: 'AppData', body: status.lunaAppDataDirectory),
                    LSTableContent(title: 'Startup', body: status.lunaStartupDirectory),
                    LSTableContent(title: 'mode', body: status.lunaMode),
                    LSTableContent(title: 'uptime', body: status.lunaUptime),
                ],
            ),
        ],
    );
}
