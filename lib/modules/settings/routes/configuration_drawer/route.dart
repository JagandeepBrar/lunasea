import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class ConfigurationDrawerRoute extends StatefulWidget {
  const ConfigurationDrawerRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationDrawerRoute> createState() => _State();
}

class _State extends State<ConfigurationDrawerRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<LunaModule>? _modules;

  @override
  void initState() {
    super.initState();
    _modules = LunaDrawer.moduleOrderedList();
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
        SizedBox(height: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom),
        LunaBlock(
          title: 'settings.AutomaticallyManageOrder'.tr(),
          body: [
            TextSpan(text: 'settings.AutomaticallyManageOrderDescription'.tr()),
          ],
          trailing: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
            builder: (context, _) => LunaSwitch(
              value: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.read(),
              onChanged: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.update,
            ),
          ),
        ),
        LunaDivider(),
        Expanded(
          child: LunaReorderableListViewBuilder(
            padding: MediaQuery.of(context).padding.copyWith(top: 0).add(
                EdgeInsets.only(bottom: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom)),
            controller: scrollController,
            itemCount: _modules!.length,
            itemBuilder: (context, index) => _reorderableModuleTile(index),
            onReorder: (oIndex, nIndex) {
              if (oIndex > _modules!.length) oIndex = _modules!.length;
              if (oIndex < nIndex) nIndex--;
              LunaModule module = _modules![oIndex];
              _modules!.remove(module);
              _modules!.insert(nIndex, module);
              LunaSeaDatabase.DRAWER_MANUAL_ORDER.update(_modules!);
            },
          ),
        ),
      ],
    );
  }

  Widget _reorderableModuleTile(int index) {
    return LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
      key: ObjectKey(_modules![index]),
      builder: (context, _) => LunaBlock(
        disabled: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.read(),
        title: _modules![index].title,
        body: [TextSpan(text: _modules![index].description)],
        leading: LunaIconButton(icon: _modules![index].icon),
        trailing: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.read()
            ? null
            : LunaReorderableListViewDragger(index: index),
      ),
    );
  }
}
