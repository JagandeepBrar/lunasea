import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/lidarr.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrMissing extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/missing';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    LidarrMissing({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrMissing> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<LidarrMissingEntry>> _future;
    List<LidarrMissingEntry> _results = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = [];
        final _api = LidarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() => {
            _future = _api.getMissing()
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                        _results = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Missing Albums',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => widget.refreshIndicatorKey?.currentState?.show(),
        )
        : LSListViewBuilder(
            itemCount: _results.length,
            itemBuilder: (context, index) => LidarrMissingTile(
                scaffoldKey: _scaffoldKey,
                entry: _results[index],
            ),
        );
}
