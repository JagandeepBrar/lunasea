import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class SearchDialogs {
    SearchDialogs._();
    
    static Future<List<dynamic>> downloadResult(BuildContext context) async {
        bool _flag = false;
        String _service = '';

        void _setValues(bool flag, String service) {
            _flag = flag;
            _service = service;
            Navigator.of(context).pop();
        }

        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Download'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LunaColours.accent),
                ],
                content: ValueListenableBuilder(
                    valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
                    builder: (context, lunaBox, widget) => ValueListenableBuilder(
                        valueListenable: Database.profilesBox.listenable(),
                        builder: (context, profilesBox, widget) => LSDialog.content(
                            children: <Widget>[
                                Padding(
                                    child: LunaPopupMenuButton<String>(
                                        tooltip: 'Change Profiles',
                                        child: Container(
                                            child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                    Expanded(
                                                        child: Text(
                                                            LunaDatabaseValue.ENABLED_PROFILE.data,
                                                            style: TextStyle(
                                                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                            ),
                                                        ),
                                                    ),
                                                    LSIcon(
                                                        icon: Icons.arrow_drop_down,
                                                        color: LunaColours.accent,
                                                    ),
                                                ],
                                            ),
                                            padding: EdgeInsets.only(bottom: 2.0),
                                            decoration: BoxDecoration(
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
                                            return <PopupMenuEntry<String>>[for(String profile in (profilesBox as Box).keys) PopupMenuItem<String>(
                                                value: profile,
                                                child: Text(
                                                    profile,
                                                    style: TextStyle(
                                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                    ),
                                                ),
                                            )];
                                        },
                                    ),
                                    padding: EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 16.0),
                                ),
                                if(Database.currentProfileObject.sabnzbdEnabled) LSDialog.tile(
                                    icon: CustomIcons.sabnzbd,
                                    iconColor: LunaColours.list(0),
                                    text: 'SABnzbd',
                                    onTap: () => _setValues(true, 'sabnzbd'),
                                ),
                                if(Database.currentProfileObject.nzbgetEnabled) LSDialog.tile(
                                    icon: CustomIcons.nzbget,
                                    iconColor: LunaColours.list(1),
                                    text: 'NZBGet',
                                    onTap: () => _setValues(true, 'nzbget'),
                                ),
                                LSDialog.tile(
                                    icon: Icons.file_download,
                                    iconColor: LunaColours.list(2),
                                    text: 'Download to Device',
                                    onTap: () => _setValues(true, 'filesystem'),
                                ),
                            ],
                        ),
                    ),
                ),
                contentPadding: EdgeInsets.fromLTRB(0.0, 26.0, 0.0, 0.0),
                shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
            ),
        );
        return [_flag, _service];
    }
}
