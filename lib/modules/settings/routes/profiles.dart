import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfilesRouter extends LunaPageRouter {
    SettingsProfilesRouter() : super('/settings/profiles');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsProfilesRoute());
}

class _SettingsProfilesRoute extends StatefulWidget {
    @override
    State<_SettingsProfilesRoute> createState() => _State();
}

class _State extends State<_SettingsProfilesRoute> with LunaScrollControllerMixin {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
                    icon: Icons.help_outline,
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
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Add'),
                    subtitle: LunaText.subtitle(text: 'Add a New Profile'),
                    trailing: LunaIconButton(icon: Icons.add),
                    onTap: () async => LunaProfile().addProfile(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Rename'),
                    subtitle: LunaText.subtitle(text: 'Rename an Existing Profile'),
                    trailing: LunaIconButton(icon: Icons.text_format),
                    onTap: () async => LunaProfile().renameProfile(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Delete'),
                    subtitle: LunaText.subtitle(text: 'Delete an Existing Profile'),
                    trailing: LunaIconButton(icon: Icons.delete),
                    onTap: () async => LunaProfile().deleteProfile(),
                ),
            ],
        );
    }

    Widget _enabledProfile() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Enabled Profile'),
            subtitle: LunaDatabaseValue.ENABLED_PROFILE.listen(
                builder: (context, _, __) => LunaText.subtitle(text: LunaDatabaseValue.ENABLED_PROFILE.data),
            ),
            trailing: LunaIconButton(icon: Icons.person),
            onTap: () async {
                List<dynamic> values = await SettingsDialogs.enabledProfile(LunaState.navigatorKey.currentContext, LunaProfile().profilesList());
                if(values[0] && values[1] != LunaDatabaseValue.ENABLED_PROFILE.data) LunaProfile().safelyChangeProfiles(values[1]);
            },
        );
    }
}
