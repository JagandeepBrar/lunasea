import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaDrawerHeader extends StatelessWidget {
  final String page;

  const LunaDrawerHeader({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaSeaDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => Container(
        child: LunaAppBar.dropdown(
          backgroundColor: Colors.transparent,
          hideLeading: true,
          useDrawer: false,
          title: LunaBox.profiles.keys.length == 1
              ? 'LunaSea'
              : LunaSeaDatabase.ENABLED_PROFILE.read(),
          profiles: LunaBox.profiles.keys.cast<String>().toList(),
          actions: [
            LunaIconButton(
              icon: LunaIcons.SETTINGS,
              onPressed: page == LunaModule.SETTINGS.key
                  ? Navigator.of(context).pop
                  : LunaModule.SETTINGS.launch,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: LunaColours.accent,
          image: DecorationImage(
            image: const AssetImage(LunaAssets.brandingLogo),
            colorFilter: ColorFilter.mode(
              LunaColours.primary.withOpacity(0.15),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
