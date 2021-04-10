import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusDiskSpacePage extends StatefulWidget {
    final ScrollController scrollController;

    RadarrSystemStatusDiskSpacePage({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrSystemStatusDiskSpacePage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

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

    Future<void> _refresh() async {
        context.read<RadarrSystemStatusState>().fetchDiskSpace(context);
        context.read<RadarrState>().fetchRootFolders();
        await Future.wait([
            context.read<RadarrSystemStatusState>().diskSpace,
            context.read<RadarrState>().rootFolders,
        ]);
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: _refresh,
            child: FutureBuilder(
                future: Future.wait([
                    context.watch<RadarrSystemStatusState>().diskSpace,
                    context.read<RadarrState>().rootFolders,
                ]),
                builder: (context, AsyncSnapshot<List> snapshot) {
                    if(snapshot.hasError) {
                        LunaLogger().error('Unable to fetch Radarr disk space', snapshot.error, snapshot.stackTrace);
                        return LunaMessage.error(onTap: _refreshKey.currentState.show);
                    }
                    if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _list(List<RadarrDiskSpace> diskSpace, List<RadarrRootFolder> rootFolders) {
        if((diskSpace?.length ?? 0) == 0 && (rootFolders?.length ?? 0) == 0) return LunaMessage(
            text: 'No Disks Found',
            buttonText: 'Try Again',
            onTap: _refreshKey.currentState.show,
        );
        return LunaListView(
            controller: RadarrSystemStatusNavigationBar.scrollControllers[1],
            children: [
                if((diskSpace?.length ?? 0) != 0) ...List.generate(
                    diskSpace.length,
                    (index) => RadarrDiskSpaceTile(diskSpace: diskSpace[index]),
                ),
                if((diskSpace?.length ?? 0) != 0 && (rootFolders?.length ?? 0) != 0) LunaDivider(), 
                if((rootFolders?.length ?? 0) != 0) ...List.generate(
                    rootFolders.length,
                    (index) => RadarrDiskSpaceTile(rootFolder: rootFolders[index]),
                ),
            ],
        );
    }
}
