import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class _ReadarrAddSeriesArguments {
  final String query;

  _ReadarrAddSeriesArguments(this.query);
}

class ReadarrAddSeriesRouter extends ReadarrPageRouter {
  ReadarrAddSeriesRouter() : super('/readarr/addseries');

  @override
  _Widget widget() => _Widget();

  @override
  Future<void> navigateTo(
    BuildContext context, [
    String query = '',
  ]) async {
    LunaRouter.router.navigateTo(
      context,
      route(),
      routeSettings: RouteSettings(arguments: _ReadarrAddSeriesArguments(query)),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _ReadarrAddSeriesArguments? _arguments;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context)!.settings.arguments
        as _ReadarrAddSeriesArguments?;
    return ChangeNotifierProvider(
      create: (context) => ReadarrAddSeriesState(
        context,
        _arguments?.query ?? '',
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(),
      ),
    );
  }

  Widget _appBar() {
    return ReadarrAuthorAddAppBar(
      scrollController: scrollController,
      query: _arguments?.query,
      autofocus: (_arguments?.query ?? '').isEmpty,
    );
  }

  Widget _body() {
    return ReadarrAddSeriesSearchPage(scrollController: scrollController);
  }
}
