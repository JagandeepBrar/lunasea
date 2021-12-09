import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaDrawerHeader extends UserAccountsDrawerHeader {
  LunaDrawerHeader({
    Key key,
  }) : super(
          key: key,
          accountName: StreamBuilder(
            stream: LunaFirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) =>
                LunaText.title(text: LunaFirebaseAuth().email ?? 'LunaSea'),
          ),
          accountEmail: LunaDatabaseValue.ENABLED_PROFILE.listen(
            builder: (context, lunaBox, widget) => ValueListenableBuilder(
              valueListenable: Database.profilesBox.listenable(),
              builder: (context, profilesBox, widget) => Padding(
                child: LunaPopupMenuButton<String>(
                  tooltip: 'Change Profiles',
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      LunaText.subtitle(
                        text: LunaDatabaseValue.ENABLED_PROFILE.data,
                      ),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.white70,
                        size: LunaUI.FONT_SIZE_HEADER,
                      ),
                    ],
                  ),
                  onSelected: (result) {
                    HapticFeedback.selectionClick();
                    LunaProfile().safelyChangeProfiles(result);
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      for (String profile in (profilesBox as Box).keys)
                        PopupMenuItem<String>(
                          value: profile,
                          child: Text(
                            profile,
                            style: TextStyle(
                              fontSize: LunaUI.FONT_SIZE_H3,
                              color: (LunaDatabaseValue.ENABLED_PROFILE.data ??
                                          'default') ==
                                      profile
                                  ? LunaColours.accent
                                  : Colors.white,
                            ),
                          ),
                        )
                    ];
                  },
                ),
                padding: const EdgeInsets.only(right: 12.0),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: LunaColours.accent,
            image: DecorationImage(
              image: const AssetImage(LunaAssets.brandingLogo),
              colorFilter: ColorFilter.mode(
                  LunaColours.primary.withOpacity(0.15), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
        );
}
