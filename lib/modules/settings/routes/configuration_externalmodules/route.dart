import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationExternalModulesRouter extends SettingsPageRouter {
  SettingsConfigurationExternalModulesRouter()
      : super('/settings/configuration/externalmodules');

  @override
  _Widget widget() => _Widget();

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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: LunaModule.EXTERNAL_MODULES.title,
    );
  }

  Widget _bottomNavigationBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'settings.AddModule'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => SettingsConfigurationExternalModulesAddRouter()
              .navigateTo(context),
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.externalModules.watch(
      builder: (context, _) => LunaListView(
        controller: scrollController,
        children: [
          LunaModule.EXTERNAL_MODULES.informationBanner(),
          ..._moduleSection(),
        ],
      ),
    );
  }

  List<Widget> _moduleSection() => [
        if (LunaBox.externalModules.isEmpty)
          LunaMessage(text: 'settings.NoExternalModulesFound'.tr()),
        ..._modules,
      ];

  List<Widget> get _modules {
    final modules = LunaBox.externalModules.data.values.toList();
    modules.sort((a, b) =>
        a.displayName!.toLowerCase().compareTo(b.displayName!.toLowerCase()));
    List<LunaBlock> list = List.generate(
      modules.length,
      (index) => _moduleTile(modules[index], modules[index].key) as LunaBlock,
    );
    return list;
  }

  Widget _moduleTile(ExternalModuleHiveObject module, int index) {
    return LunaBlock(
      title: module.displayName,
      body: [TextSpan(text: module.host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        return SettingsConfigurationExternalModulesEditRouter().navigateTo(
          context,
          index,
        );
      },
    );
  }
}
