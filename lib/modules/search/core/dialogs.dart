import 'package:flutter/material.dart';
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
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: ValueListenableBuilder(
                    valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
                    builder: (context, lunaBox, widget) => ValueListenableBuilder(
                        valueListenable: Database.profilesBox.listenable(),
                        builder: (context, profilesBox, widget) => LSDialog.content(
                            children: <Widget>[
                                Padding(
                                    child: PopupMenuButton<String>(
                                        shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                                            ? LSRoundedShapeWithBorder()
                                            : LSRoundedShape(),
                                        child: Container(
                                            child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                    Expanded(
                                                        child: Text(
                                                            LunaSeaDatabaseValue.ENABLED_PROFILE.data,
                                                            style: TextStyle(
                                                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                            ),
                                                        ),
                                                    ),
                                                    LSIcon(
                                                        icon: Icons.arrow_drop_down,
                                                        color: LSColors.accent,
                                                    ),
                                                ],
                                            ),
                                            padding: EdgeInsets.only(bottom: 2.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: LSColors.accent,
                                                        width: 2.0,
                                                    ),
                                                ),
                                            ),
                                        ),
                                        onSelected: (result) => LunaSeaDatabaseValue.ENABLED_PROFILE.put(result),
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
                                    padding: EdgeInsets.fromLTRB(36.0, 0.0, 12.0, 16.0),
                                ),
                                if(Database.currentProfileObject.sabnzbdEnabled) LSDialog.tile(
                                    icon: CustomIcons.sabnzbd,
                                    iconColor: LSColors.list(0),
                                    text: 'SABnzbd',
                                    onTap: () => _setValues(true, 'sabnzbd'),
                                ),
                                if(Database.currentProfileObject.nzbgetEnabled) LSDialog.tile(
                                    icon: CustomIcons.nzbget,
                                    iconColor: LSColors.list(1),
                                    text: 'NZBGet',
                                    onTap: () => _setValues(true, 'nzbget'),
                                ),
                                LSDialog.tile(
                                    icon: Icons.file_download,
                                    iconColor: LSColors.list(2),
                                    text: 'Download to Device',
                                    onTap: () => _setValues(true, 'filesystem'),
                                ),
                            ],
                        ),
                    ),
                ),
                contentPadding: EdgeInsets.fromLTRB(0.0, 26.0, 24.0, 0.0),
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
            ),
        );
        return [_flag, _service];
    }
}
