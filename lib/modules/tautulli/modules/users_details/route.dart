import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUserDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/users/details/:userid';

    static Future<void> navigateTo(BuildContext context, {
        @required int userId,
    }) async => TautulliRouter.router.navigateTo(
        context,
        route(userId: userId),
    );

    static String route({
        String profile,
        @required int userId,
    }) => [
        ROUTE_NAME.replaceFirst(':userid', userId.toString()),
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliUserDetailsRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
                userId: int.tryParse(params['userid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliUserDetailsRoute(
                profile: null,
                userId: int.tryParse(params['userid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliUserDetailsRouter._();
}

class _TautulliUserDetailsRoute extends StatefulWidget {
    final int userId;
    final String profile;

    _TautulliUserDetailsRoute({
        Key key,
        @required this.userId,
        @required this.profile,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliUserDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data);
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        _global.resetUsers();
        await _global.users;
    }

    TautulliTableUser _findUser(TautulliUsersTable users) {
        return users.users.firstWhere(
            (user) => user.userId == widget.userId,
            orElse: () => null,
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'User Details');

    Widget get _bottomNavigationBar => TautulliUserDetailsNavigationBar(pageController: _pageController);

    List<Widget> _tabs(TautulliTableUser user) => [
        TautulliUserDetailsProfile(user: user),
        TautulliUserDetailsHistory(user: user),
        TautulliUserDetailsSyncedItems(user: user),
        TautulliUserDetailsIPAddresses(user: user),
    ];

    Widget get _body => Selector<TautulliState, Future<TautulliUsersTable>>(
        selector: (_, state) => state.users,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliUsersTable> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_TautulliUserDetailsRoute',
                            '_body',
                            'Unable to pull Tautulli user table',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () => _refresh());
                }
                if(snapshot.hasData) {
                    TautulliTableUser user = _findUser(snapshot.data);
                    return user == null
                        ? _unknown
                        : PageView(
                            controller: _pageController,
                            children: _tabs(user),
                        );
                }
                return LSLoader();
            },
        ),
    );

    Widget get _unknown => LSGenericMessage(text: 'User Record Not Found');
}
