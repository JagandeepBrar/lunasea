import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDrawerRouter extends SettingsPageRouter {
  SettingsConfigurationDrawerRouter() : super('/settings/configuration/drawer');

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
      title: 'settings.Drawer'.tr(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SizedBox(height: LunaUI.MARGIN_CARD.bottom),
        LunaBlock(
          title: 'settings.AutomaticallyManageOrder'.tr(),
          body: [
            TextSpan(text: 'settings.AutomaticallyManageOrderDescription'.tr()),
          ],
          trailing: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
            builder: (context, _, __) => LunaSwitch(
              value: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
              onChanged: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.put,
            ),
          ),
        ),
        const LunaDivider(),
        Expanded(
          child: LunaReorderableListViewBuilder(
            padding: MediaQuery.of(context)
                .padding
                .copyWith(top: 0)
                .add(EdgeInsets.only(bottom: LunaUI.MARGIN_CARD.bottom)),
            controller: scrollController,
            itemCount: _modules.length,
            itemBuilder: (context, index) => _reorderableModuleTile(index),
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
    );
  }

  Widget _reorderableModuleTile(int index) {
    return LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
      key: ObjectKey(_modules[index]),
      builder: (context, _, __) => LunaBlock(
        disabled: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
        title: _modules[index].name,
        body: [TextSpan(text: _modules[index].description)],
        leading: LunaIconButton(icon: _modules[index].icon),
        trailing: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
            ? null
            : LunaReorderableListViewDragger(index: index),
      ),
    );
  }
}
