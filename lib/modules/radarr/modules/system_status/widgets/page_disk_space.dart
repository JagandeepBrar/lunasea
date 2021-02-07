import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusDiskSpacePage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrSystemStatusDiskSpacePage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<RadarrDiskSpace>> _diskSpace;

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        if(context.read<RadarrState>().enabled && mounted) setState(() {
            _diskSpace = context.read<RadarrState>().api.diskSpace.getAll();
        });
        await _diskSpace;
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
            future: _diskSpace,
            builder: (context, AsyncSnapshot<List<RadarrDiskSpace>> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr disk space', snapshot.error, StackTrace.current);
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _space(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _space(List<RadarrDiskSpace> diskSpace) {
        if((diskSpace?.length ?? 0) == 0) return LSGenericMessage(
            text: 'No Disks Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () async => _refreshKey.currentState.show(),
        );
        
        return LunaListViewBuilder(
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
                return LSCardTile(
                    title: LunaText.title(text: diskSpace[index].path),
                    subtitle: LSSubtitle(
                        text: [
                            diskSpace[index].freeSpace?.lunaBytesToString() ?? Constants.TEXT_EMDASH,
                            diskSpace[index].totalSpace?.lunaBytesToString() ?? Constants.TEXT_EMDASH,
                        ].join(' / '),
                    ),
                    trailing: LSIconButton(
                        text: _percent == null ? Constants.TEXT_EMDASH : '$_percent%',
                        color: percentColor,
                        textSize: 10.0,
                    ),
                );
            },
        );
    }
}
