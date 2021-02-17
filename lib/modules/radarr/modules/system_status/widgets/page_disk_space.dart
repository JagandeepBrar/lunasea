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
        return Scaffold(
            key: _scaffoldKey,
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
            scrollController: widget.scrollController,
            itemCount: diskSpace.length,
            itemBuilder: (context, index) {
                int _percentNumerator = diskSpace[index].freeSpace;
                int _percentDenominator = diskSpace[index].totalSpace;
                int _percent;
                Color percentColor = LunaColours.accent;
                if(_percentNumerator != null && _percentDenominator != null || _percentDenominator != 0) {
                    int _val = ((_percentNumerator/_percentDenominator)*100).round();
                    _percent = (_val-100).abs();
                    if(_percent >= 70) percentColor = LunaColours.orange;
                    if(_percent >= 90) percentColor = LunaColours.red;
                }
                return LunaListTile(
                    context: context,
                    title: LunaText.title(text: diskSpace[index].path),
                    subtitle: LunaText.subtitle(
                        text: [
                            diskSpace[index].freeSpace?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
                            diskSpace[index].totalSpace?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
                        ].join(' / '),
                    ),
                    trailing: LunaIconButton(
                        text: _percent == null ? LunaUI.TEXT_EMDASH : '$_percent%',
                        color: percentColor,
                        textSize: 11.0,
                    ),
                );
            },
        );
    }
}
