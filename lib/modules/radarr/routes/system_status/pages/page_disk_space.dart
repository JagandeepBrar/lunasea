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

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: () async => context.read<RadarrSystemStatusState>().fetchDiskSpace(context),
            child: FutureBuilder(
                future: context.watch<RadarrSystemStatusState>().diskSpace,
                builder: (context, AsyncSnapshot<List<RadarrDiskSpace>> snapshot) {
                    if(snapshot.hasError) {
                        LunaLogger().error('Unable to fetch Radarr disk space', snapshot.error, snapshot.stackTrace);
                        return LunaMessage.error(onTap: _refreshKey.currentState.show);
                    }
                    if(snapshot.hasData) return _list(snapshot.data);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _list(List<RadarrDiskSpace> diskSpace) {
        if((diskSpace?.length ?? 0) == 0) return LunaMessage(
            text: 'No Disks Found',
            buttonText: 'Try Again',
            onTap: _refreshKey.currentState.show,
        );
        return LunaListViewBuilder(
            controller: RadarrSystemStatusNavigationBar.scrollControllers[1],
            itemCount: diskSpace.length,
            itemBuilder: (context, index) => RadarrDiskSpaceTile(diskSpace: diskSpace[index]),
        );
    }
}
