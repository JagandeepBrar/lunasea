import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/external_module.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ConfigurationExternalModulesEditRoute extends StatefulWidget {
  final int moduleId;

  const ConfigurationExternalModulesEditRoute({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  State<ConfigurationExternalModulesEditRoute> createState() => _State();
}

class _State extends State<ConfigurationExternalModulesEditRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaExternalModule? _module;

  @override
  Widget build(BuildContext context) {
    if (widget.moduleId < 0 ||
        !LunaBox.externalModules.contains(widget.moduleId)) {
      return InvalidRoutePage(
        title: 'settings.EditModule'.tr(),
        message: 'settings.ModuleNotFound'.tr(),
      );
    }
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
                  message: _module!.displayName);
              _module!.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.externalModules.listenableBuilder(
      selectKeys: [widget.moduleId],
      builder: (context, dynamic _) {
        if (!LunaBox.externalModules.contains(widget.moduleId))
          return Container();
        _module = LunaBox.externalModules.read(widget.moduleId);
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
    String _displayName = _module!.displayName;
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
        if (values.item1) _module!.displayName = values.item2;
        _module!.save();
      },
    );
  }

  Widget _hostTile() {
    String _host = _module!.host;
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
        if (values.item1) _module!.host = values.item2;
        _module!.save();
      },
    );
  }
}
