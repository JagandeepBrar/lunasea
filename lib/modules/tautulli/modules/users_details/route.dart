import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUserDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/users/details/:userid';

    static Future<void> navigateTo(BuildContext context, {
        @required int userId,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(userId: userId),
    );

    static String route({ @required int userId }) => ROUTE_NAME.replaceFirst(':userid', userId.toString());

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliUserDetailsRoute(
                userId: int.tryParse(params['userid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliUserDetailsRouter._();
}

class _TautulliUserDetailsRoute extends StatefulWidget {
    final int userId;

    _TautulliUserDetailsRoute({
        Key key,
        @required this.userId,
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
        context.read<TautulliState>().resetUsers();
        await context.read<TautulliState>().users;
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

    Widget get _appBar => LunaAppBar(title: 'User Details');

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
                        LunaLogger().error('Unable to pull Tautulli user table', snapshot.error, StackTrace.current);
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
