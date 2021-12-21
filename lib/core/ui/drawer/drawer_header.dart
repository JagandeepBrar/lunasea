import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaDrawerHeader extends StatelessWidget {
  const LunaDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: LunaFirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) => LunaText.title(
                      text: LunaFirebaseAuth().email ?? 'LunaSea'),
                ),
                _profileSwitcher(),
              ],
            ),
            padding: LunaUI.MARGIN_DEFAULT,
          ),
        ),
      ),
    );
  }

  Widget _profileSwitcher() {
    return LunaDatabaseValue.ENABLED_PROFILE.listen(
      builder: (context, lunaBox, widget) => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, profilesBox, widget) => LunaPopupMenuButton<String>(
          tooltip: 'lunasea.ChangeProfiles'.tr(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LunaText.subtitle(
                text: LunaDatabaseValue.ENABLED_PROFILE.data,
                color: LunaColours.white70,
              ),
              const Icon(
                LunaIcons.ARROW_DROPDOWN,
                color: LunaColours.white70,
                size: LunaUI.FONT_SIZE_HEADER,
              ),
            ],
          ),
          onSelected: (result) {
            HapticFeedback.selectionClick();
            LunaProfile().safelyChangeProfiles(result);
          },
          itemBuilder: (context) {
            String _profile = LunaDatabaseValue.ENABLED_PROFILE.data;
            return <PopupMenuEntry<String>>[
              for (String profile in (profilesBox as Box).keys)
                PopupMenuItem<String>(
                  value: profile,
                  child: Text(
                    profile,
                    style: TextStyle(
                      fontSize: LunaUI.FONT_SIZE_H3,
                      color: _profile == profile
                          ? LunaColours.accent
                          : LunaColours.white,
                    ),
                  ),
                )
            ];
          },
        ),
      ),
    );
  }
}
