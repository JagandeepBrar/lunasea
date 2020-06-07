import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDialogSearch {
    static Future<List> downloadResult(BuildContext context) async {
        bool flag = false;
        String service = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                title: LSDialog.title(text: 'Download'),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Cancel',
                        textColor: LSColors.accent,
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
                content: ValueListenableBuilder(
                    valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
                    builder: (context, lunaBox, widget) => ValueListenableBuilder(
                        valueListenable: Database.profilesBox.listenable(),
                        builder: (context, profilesBox, widget) => LSDialog.content(
                            children: <Widget>[
                                Padding(
                                    child: DropdownButton(
                                        icon: LSIcon(
                                            icon: Icons.arrow_drop_down,
                                            color: LSColors.accent,
                                        ),
                                        underline: Container(
                                            height: 2,
                                            color: LSColors.accent,
                                        ),
                                        value: lunaBox.get(LunaSeaDatabaseValue.ENABLED_PROFILE.key),
                                        items: (profilesBox as Box).keys.map<DropdownMenuItem<String>>((dynamic value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                        )).toList(),
                                        onChanged: (value) {
                                            lunaBox.put(LunaSeaDatabaseValue.ENABLED_PROFILE.key, value);
                                        },
                                        isExpanded: true,
                                    ),
                                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                                ),
                                if(Database.currentProfileObject.sabnzbdEnabled) LSDialog.tile(
                                    icon: true,
                                    iconData: CustomIcons.sabnzbd,
                                    iconColor: LSColors.list(0),
                                    text: 'SABnzbd',
                                    onTap: () {
                                        flag = true;
                                        service = 'sabnzbd';
                                        Navigator.of(context).pop();
                                    }
                                ),
                                if(Database.currentProfileObject.nzbgetEnabled) LSDialog.tile(
                                    icon: true,
                                    iconData: CustomIcons.nzbget,
                                    iconColor: LSColors.list(1),
                                    text: 'NZBGet',
                                    onTap: () {
                                        flag = true;
                                        service = 'nzbget';
                                        Navigator.of(context).pop();
                                    }
                                ),
                                LSDialog.tile(
                                    icon: true,
                                    iconData: Icons.file_download,
                                    iconColor: LSColors.list(2),
                                    text: 'Download to Device',
                                    onTap: () {
                                        flag = true;
                                        service = 'filesystem';
                                        Navigator.of(context).pop();
                                    }
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
        return [flag, service];
    }
}
