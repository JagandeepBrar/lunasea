import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchDialogs {
  Future<Tuple2<bool, SearchDownloadType>> downloadResult(
      BuildContext context) async {
    bool _flag = false;
    SearchDownloadType _type;

    void _setValues(bool flag, SearchDownloadType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'search.Download'.tr(),
      customContent: LunaDatabaseValue.ENABLED_PROFILE.listen(
        builder: (context, lunaBox, widget) => LunaDialog.content(
          children: [
            Padding(
              child: LunaPopupMenuButton<String>(
                tooltip: 'lunasea.ChangeProfiles'.tr(),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          LunaDatabaseValue.ENABLED_PROFILE.data,
                          style: const TextStyle(
                            fontSize: LunaUI.FONT_SIZE_H3,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: LunaColours.accent,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(bottom: 2.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: LunaColours.accent,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onSelected: (result) {
                  HapticFeedback.selectionClick();
                  LunaProfile().safelyChangeProfiles(result);
                },
                itemBuilder: (context) {
                  return <PopupMenuEntry<String>>[
                    for (String profile in Database.profilesBox.keys)
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
              padding: LunaDialog.tileContentPadding()
                  .add(const EdgeInsets.only(bottom: 16.0)),
            ),
            if (Database.currentProfileObject.sabnzbdEnabled)
              LunaDialog.tile(
                icon: SearchDownloadType.SABNZBD.icon,
                iconColor: LunaColours().byListIndex(0),
                text: SearchDownloadType.SABNZBD.name,
                onTap: () => _setValues(true, SearchDownloadType.SABNZBD),
              ),
            if (Database.currentProfileObject.nzbgetEnabled)
              LunaDialog.tile(
                icon: SearchDownloadType.NZBGET.icon,
                iconColor: LunaColours().byListIndex(1),
                text: SearchDownloadType.NZBGET.name,
                onTap: () => _setValues(true, SearchDownloadType.NZBGET),
              ),
            LunaDialog.tile(
              icon: SearchDownloadType.FILESYSTEM.icon,
              iconColor: LunaColours().byListIndex(2),
              text: SearchDownloadType.FILESYSTEM.name,
              onTap: () => _setValues(true, SearchDownloadType.FILESYSTEM),
            ),
          ],
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _type);
  }
}
