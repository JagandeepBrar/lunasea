import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfilesRouter extends SettingsPageRouter {
  SettingsProfilesRouter() : super('/settings/profiles');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
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
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Profiles',
      scrollControllers: [scrollController],
      actions: [
        LunaIconButton(
          icon: Icons.help_outline_rounded,
          onPressed: () async => LunaDialogs().textPreview(
            context,
            'Profiles',
            [
              'Profiles allow you to add multiple instances of modules into LunaSea.',
              'Newznab indexer searching is enabled and shared across all profiles.',
              'You can switch between profiles in the main navigation drawer of LunaSea.',
            ].join('\n\n'),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _enabledProfile(),
        LunaBlock(
          title: 'settings.AddProfile'.tr(),
          body: [TextSpan(text: 'settings.AddProfileDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaIcons.ADD),
          onTap: () async => LunaProfile().addProfile(),
        ),
        LunaBlock(
          title: 'settings.RenameProfile'.tr(),
          body: [TextSpan(text: 'settings.RenameProfileDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaIcons.RENAME),
          onTap: () async => LunaProfile().renameProfile(),
        ),
        LunaBlock(
          title: 'settings.DeleteProfile'.tr(),
          body: [TextSpan(text: 'settings.DeleteProfileDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaIcons.DELETE),
          onTap: () async => LunaProfile().deleteProfile(),
        ),
      ],
    );
  }

  Widget _enabledProfile() {
    return LunaDatabaseValue.ENABLED_PROFILE.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Enabled Profile',
        body: [TextSpan(text: LunaDatabaseValue.ENABLED_PROFILE.data)],
        trailing: const LunaIconButton(icon: Icons.switch_account_rounded),
        onTap: () async {
          Tuple2<bool, String> results = await SettingsDialogs().enabledProfile(
            LunaState.navigatorKey.currentContext,
            LunaProfile().profilesList(),
          );
          if (results.item1 &&
              results.item2 != LunaDatabaseValue.ENABLED_PROFILE.data)
            LunaProfile().safelyChangeProfiles(results.item2);
        },
      ),
    );
  }
}
