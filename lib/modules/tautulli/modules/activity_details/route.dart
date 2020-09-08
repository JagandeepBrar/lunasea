import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/activity/details/:sessionid/:profile';
    final String sessionId;

    TautulliActivityDetailsRoute({
        Key key,
        @required this.sessionId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();

    static String route({ String profile, @required String sessionId }) {
        if(profile == null) return '/tautulli/activity/details/$sessionId/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/activity/details/$sessionId/$profile';
    }
}

class _State extends State<TautulliActivityDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.resetActivity();
        await _state.activity;
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Activity Details');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliState, Future<TautulliActivity>>(
            selector: (_, state) => state.activity,
            builder: (context, future, _) => FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<TautulliActivity> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                'TautulliActivityDetailsRoute',
                                '_body',
                                'Unable to pull Tautulli activity session',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () => _refresh());
                    }
                    if(snapshot.hasData) {
                        TautulliSession session = snapshot.data.sessions.firstWhere((element) => element.sessionId == widget.sessionId, orElse: () => null);
                        return session == null
                            ? _deadSession()
                            : _activeSession(session);
                    }       
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _activeSession(TautulliSession session) => TautulliActivityDetailsInformation(session: session);

    Widget _deadSession() => LSGenericMessage(
        text: 'Session Ended',
        showButton: true,
        buttonText: 'Back',
        onTapHandler: () async => TautulliRouter.router.pop(context),
    );
}
