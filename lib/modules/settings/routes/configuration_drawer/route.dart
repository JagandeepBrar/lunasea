import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDrawerRouter extends SettingsPageRouter {
  SettingsConfigurationDrawerRouter() : super('/settings/configuration/drawer');

  @override
  Widget widget() => _Widget();

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
  List<LunaModule> _modules;

  @override
  void initState() {
    super.initState();
    _modules = LunaDrawer.moduleOrderedList();
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'Drawer',
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          LunaListTile(
            context: context,
            margin: LunaUI.MARGIN_DEFAULT.subtract(
              EdgeInsets.only(bottom: LunaUI.MARGIN_CARD.bottom),
            ),
            title: LunaText.title(text: 'Automatically Manage'),
            subtitle: LunaText.subtitle(
              text: 'List Modules Alphabetically',
            ),
            trailing: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
              builder: (context, _, __) => LunaSwitch(
                value: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
                onChanged: (value) {
                  LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.put(value);
                },
              ),
            ),
          ),
          Expanded(
            child: LunaReorderableListViewBuilder(
              padding: MediaQuery.of(context)
                  .padding
                  .copyWith(top: 0, bottom: LunaUI.MARGIN_CARD.bottom),
              controller: scrollController,
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                return LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
                  key: ObjectKey(_modules[index]),
                  builder: (context, _, __) => LunaListTile(
                    context: context,
                    title: LunaText.title(
                      text: _modules[index].name,
                      darken: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
                    ),
                    subtitle: LunaText.subtitle(
                      text: _modules[index].description,
                      darken: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
                    ),
                    leading: LunaIconButton(
                      icon: _modules[index].icon,
                      color: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
                          ? Colors.white30
                          : Colors.white,
                    ),
                    trailing: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
                        ? null
                        : LunaReorderableListDragger(index: index),
                  ),
                );
              },
              onReorder: (oIndex, nIndex) {
                if (oIndex > _modules.length) oIndex = _modules.length;
                if (oIndex < nIndex) nIndex--;
                LunaModule module = _modules[oIndex];
                _modules.remove(module);
                _modules.insert(nIndex, module);
                LunaDatabaseValue.DRAWER_MANUAL_ORDER.put(_modules);
              },
            ),
          ),
        ],
      ),
    );
  }
}
