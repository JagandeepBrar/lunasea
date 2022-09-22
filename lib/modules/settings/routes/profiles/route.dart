import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/utils/profile_tools.dart';

class ProfilesRoute extends StatefulWidget {
  const ProfilesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilesRoute> createState() => _State();
}

class _State extends State<ProfilesRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      title: 'settings.Profiles'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        SettingsBanners.PROFILES_SUPPORT.banner(),
        _enabledProfile(),
        _addProfile(),
        _renameProfile(),
        _deleteProfile(),
      ],
    );
  }

  Widget _addProfile() {
    return LunaBlock(
      title: 'settings.AddProfile'.tr(),
      body: [TextSpan(text: 'settings.AddProfileDescription'.tr())],
      trailing: const LunaIconButton(icon: LunaIcons.ADD),
      onTap: () async {
        final dialogs = SettingsDialogs();
        final context = LunaState.context;
        final profiles = LunaProfile.list;

        final selected = await dialogs.addProfile(context, profiles);
        if (selected.item1) {
          LunaProfileTools().create(selected.item2);
        }
      },
    );
  }

  Widget _renameProfile() {
    return LunaBlock(
      title: 'settings.RenameProfile'.tr(),
      body: [TextSpan(text: 'settings.RenameProfileDescription'.tr())],
      trailing: const LunaIconButton(icon: LunaIcons.RENAME),
      onTap: () async {
        final dialogs = SettingsDialogs();
        final context = LunaState.context;
        final profiles = LunaProfile.list;

        final selected = await dialogs.renameProfile(context, profiles);
        if (selected.item1) {
          final name = await dialogs.renameProfileSelected(context, profiles);
          if (name.item1) {
            LunaProfileTools().rename(selected.item2, name.item2);
          }
        }
      },
    );
  }

  Widget _deleteProfile() {
    return LunaBlock(
        title: 'settings.DeleteProfile'.tr(),
        body: [TextSpan(text: 'settings.DeleteProfileDescription'.tr())],
        trailing: const LunaIconButton(icon: LunaIcons.DELETE),
        onTap: () async {
          final dialogs = SettingsDialogs();
          final enabledProfile = LunaSeaDatabase.ENABLED_PROFILE.read();
          final context = LunaState.context;
          final profiles = LunaProfile.list;
          profiles.removeWhere((p) => p == enabledProfile);

          if (profiles.isEmpty) {
            showLunaInfoSnackBar(
              title: 'settings.NoProfilesFound'.tr(),
              message: 'settings.NoAdditionalProfilesAdded'.tr(),
            );
            return;
          }

          final selected = await dialogs.deleteProfile(context, profiles);
          if (selected.item1) {
            LunaProfileTools().remove(selected.item2);
          }
        });
  }

  Widget _enabledProfile() {
    const db = LunaSeaDatabase.ENABLED_PROFILE;
    return db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.EnabledProfile'.tr(),
        body: [TextSpan(text: db.read())],
        trailing: const LunaIconButton(icon: LunaIcons.USER),
        onTap: () async {
          final dialogs = SettingsDialogs();
          final enabledProfile = LunaSeaDatabase.ENABLED_PROFILE.read();
          final context = LunaState.context;
          final profiles = LunaProfile.list;
          profiles.removeWhere((p) => p == enabledProfile);

          if (profiles.isEmpty) {
            showLunaInfoSnackBar(
              title: 'settings.NoProfilesFound'.tr(),
              message: 'settings.NoAdditionalProfilesAdded'.tr(),
            );
            return;
          }

          final selected = await dialogs.enabledProfile(context, profiles);
          if (selected.item1) {
            LunaProfileTools().changeTo(selected.item2);
          }
        },
      ),
    );
  }
}
