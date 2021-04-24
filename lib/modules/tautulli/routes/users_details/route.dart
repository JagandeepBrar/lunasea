import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsRouter extends TautulliPageRouter {
  TautulliUserDetailsRouter() : super('/tautulli/user/:userid');

  @override
  _Widget widget({
    @required int userId,
  }) =>
      _Widget(userId: userId);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int userId,
  }) async =>
      LunaRouter.router.navigateTo(context, route(userId: userId));

  @override
  String route({
    @required int userId,
  }) =>
      fullRoute.replaceFirst(':userid', userId.toString());

  @override
  void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(
        router,
        (context, params) {
          int userId = (params['userid']?.isNotEmpty ?? false)
              ? int.tryParse(params['userid'][0]) ?? -1
              : -1;
          return _Widget(userId: userId);
        },
      );
}

class _Widget extends StatefulWidget {
  final int userId;

  _Widget({
    Key key,
    @required this.userId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
      initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data,
    );
  }

  Future<void> loadCallback() async {
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
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body,
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'User Details',
      pageController: _pageController,
      scrollControllers: TautulliUserDetailsNavigationBar.scrollControllers,
    );
  }

  Widget _bottomNavigationBar() =>
      TautulliUserDetailsNavigationBar(pageController: _pageController);

  Widget get _body => Selector<TautulliState, Future<TautulliUsersTable>>(
        selector: (_, state) => state.users,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<TautulliUsersTable> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to pull Tautulli user table',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage.error(onTap: loadCallback);
            }
            if (snapshot.hasData) {
              TautulliTableUser user = _findUser(snapshot.data);
              if (user == null)
                return LunaMessage.goBack(
                  context: context,
                  text: 'User Not Found',
                );
              return _page(user);
            }
            return LunaLoader();
          },
        ),
      );

  Widget _page(TautulliTableUser user) {
    return PageView(
      controller: _pageController,
      children: [
        TautulliUserDetailsProfile(user: user),
        TautulliUserDetailsHistory(user: user),
        TautulliUserDetailsSyncedItems(user: user),
        TautulliUserDetailsIPAddresses(user: user),
      ],
    );
  }
}
