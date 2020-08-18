import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/activity';

    TautulliActivityRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliActivityRoute> createState() => _State();
}

class _State extends State<TautulliActivityRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
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

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.activity = _state.api?.activity?.getActivity();
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Provider.of<TautulliState>(context).activity,
            builder: (context, snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        bool _sentry = snapshot.error is DioError ? false : true;
                        Logger.error(
                            'TautulliActivityRoute',
                            '_body',
                            'Unable to fetch Tautulli activity',
                            snapshot.error,
                            null,
                            uploadToSentry: _sentry,
                        );
                    }
                    return LSErrorMessage(onTapHandler: _refresh);
                }
                if(snapshot.hasData) return _list((snapshot.data as TautulliActivity));
                return LSLoading();
            },
        ),
    );

    Widget _list(TautulliActivity activity) => LSListView(
        children: [
            if(activity.streamCount > 0) TautulliActivityStatus(activity: activity),
            if(activity.streamCount > 0) ...List.generate(
                activity.sessions.length,
                (index) => TautulliActivityTile(session: activity.sessions[index]),
            ),
            if(activity.streamCount == 0) LSGenericMessage(text: 'No Active Streams'),
        ],
    );
}