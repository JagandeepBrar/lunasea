import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationExternalModulesEditRouter
    extends SettingsPageRouter {
  SettingsConfigurationExternalModulesEditRouter()
      : super('/settings/configuration/externalmodules/edit/:moduleid');

  @override
  _Widget widget({
    @required int moduleId,
  }) =>
      _Widget(moduleId: moduleId);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int moduleId,
  }) async =>
      LunaRouter.router.navigateTo(context, route(moduleId: moduleId));

  @override
  String route({
    @required int moduleId,
  }) =>
      super.fullRoute.replaceFirst(':moduleid', moduleId?.toString() ?? -1);

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int moduleId = (params['moduleid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['moduleid'][0]) ?? -1)
            : -1;
        return _Widget(moduleId: moduleId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int moduleId;

  const _Widget({
    Key key,
    @required this.moduleId,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ExternalModuleHiveObject _module;

  @override
  Widget build(BuildContext context) {
    if (widget.moduleId < 0 ||
        !Database.externalModulesBox.containsKey(widget.moduleId)) {
      return LunaInvalidRoute(
        title: 'settings.EditModule'.tr(),
        message: 'settings.ModuleNotFound'.tr(),
      );
    }
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'settings.EditModule'.tr(),
    );
  }

  Widget _bottomNavigationBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'settings.DeleteModule'.tr(),
          icon: Icons.delete_rounded,
          color: LunaColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteExternalModule(context);
            if (result) {
              showLunaSuccessSnackBar(
                  title: 'settings.DeleteModuleSuccess'.tr(),
                  message: _module.displayName);
              _module.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: Database.externalModulesBox.listenable(
        keys: [widget.moduleId],
      ),
      builder: (context, _, __) {
        if (!Database.externalModulesBox.containsKey(widget.moduleId))
          return Container();
        _module = Database.externalModulesBox.get(widget.moduleId);
        return LunaListView(
          controller: scrollController,
          children: [
            _displayNameTile(),
            _hostTile(),
          ],
        );
      },
    );
  }

  Widget _displayNameTile() {
    String _displayName = _module.displayName ?? '';
    return LunaBlock(
      title: 'settings.DisplayName'.tr(),
      body: [
        TextSpan(
          text: _displayName.isEmpty ? 'lunasea.NotSet'.tr() : _displayName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'settings.DisplayName'.tr(),
          prefill: _displayName,
        );
        if (values.item1) _module.displayName = values.item2;
        _module.save();
      },
    );
  }

  Widget _hostTile() {
    String _host = _module.host ?? '';
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [
        TextSpan(text: _host.isEmpty ? 'lunasea.NotSet'.tr() : _host),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values =
            await SettingsDialogs().editExternalModuleHost(
          context,
          prefill: _host,
        );
        if (values.item1) _module.host = values.item2;
        _module.save();
      },
    );
  }
}
