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
    return LunaDatabaseValue.ENABLED_PROFILE.listen(
      builder: (context, box, _) => Container(
        child: LunaAppBar.dropdown(
          backgroundColor: Colors.transparent,
          hideLeading: true,
          useDrawer: false,
          title: Database.profiles.box.keys.length == 1
              ? 'LunaSea'
              : LunaDatabaseValue.ENABLED_PROFILE.data,
          profiles: Database.profiles.box.keys.cast<String>().toList(),
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
