import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/external_modules.dart';

class ExternalModulesHomeRouter extends ExternalModulesPageRouter {
  ExternalModulesHomeRouter() : super('/externalmodules');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      useDrawer: true,
      title: LunaModule.EXTERNAL_MODULES.name,
      scrollControllers: [scrollController],
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.EXTERNAL_MODULES.key);

  Widget _body() {
    if ((Database.externalModulesBox.length ?? 0) == 0) {
      return LunaMessage.moduleNotEnabled(
        context: context,
        module: LunaModule.EXTERNAL_MODULES.name,
      );
    }
    return LunaListView(
      controller: scrollController,
      itemExtent: LunaBlock.calculateItemExtent(1),
      children: _list,
    );
  }

  List get _list {
    List<ExternalModulesModuleTile> list = List.generate(
      Database.externalModulesBox.length,
      (index) => ExternalModulesModuleTile(
        module: Database.externalModulesBox.getAt(index),
      ),
    );
    list.sort(
      (a, b) => a.module.displayName
          .toLowerCase()
          .compareTo(b.module.displayName.toLowerCase()),
    );
    return list;
  }
}
