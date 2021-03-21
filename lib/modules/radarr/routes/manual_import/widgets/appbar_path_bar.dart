import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportPathBar extends StatefulWidget implements PreferredSizeWidget {
    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<RadarrManualImportPathBar> createState() => _State();
}

class _State extends State<RadarrManualImportPathBar> {
    @override
    Widget build(BuildContext context) {
        return Padding(
            child: Row(
                children: [
                    Expanded(
                        child: LunaTextInputBar(
                            labelIcon: Icons.sd_storage_rounded,
                            labelText: 'radarr.FileBrowser'.tr(),
                            controller: context.watch<RadarrManualImportState>().currentPathTextController,
                            autofocus: false,
                            onChanged: (value) {
                                if(value.endsWith('/') || value.isEmpty) {
                                    context.read<RadarrManualImportState>().fetchDirectories(context, value);
                                }
                            },
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
        );
    }
}
