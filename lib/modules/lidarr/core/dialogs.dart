import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDialogs {
    LidarrDialogs._();
    
    static Future<List<dynamic>> editQualityProfile(BuildContext context, List<LidarrQualityProfile> qualities) async {
        bool _flag = false;
        LidarrQualityProfile _quality;

        void _setValues(bool flag, LidarrQualityProfile quality) {
            _flag = flag;
            _quality = quality;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Quality Profile',
            content: List.generate(
                    qualities.length,
                    (index) => LSDialog.tile(
                        icon: Icons.portrait,
                        iconColor: LSColors.list(index),
                        text: qualities[index].name,
                        onTap: () => _setValues(true, qualities[index]),
                    ),
                ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _quality];
    }

    static Future<List<dynamic>> editMetadataProfile(BuildContext context, List<LidarrMetadataProfile> metadatas) async {
        bool _flag = false;
        LidarrMetadataProfile _metadata;

        void _setValues(bool flag, LidarrMetadataProfile metadata) {
            _flag = flag;
            _metadata = metadata;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Metadata Profile',
            content: List.generate(
                    metadatas.length,
                    (index) => LSDialog.tile(
                        icon: Icons.portrait,
                        iconColor: LSColors.list(index),
                        text: metadatas[index].name,
                        onTap: () => _setValues(true, metadatas[index]),
                    ),
                ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _metadata];
    }

    static Future<List<dynamic>> deleteArtist(BuildContext context) async {
        bool _flag = false;
        bool _files = false;

        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Remove Artist',
            buttons: [
                LSDialog.button(
                    text: 'Remove + Files',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true, true),
                ),
                LSDialog.button(
                    text: 'Remove',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true, false),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to remove the artist from Lidarr?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag, _files];
    }

    static Future<List<dynamic>> downloadWarning(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Download Release',
            buttons: <Widget>[
                LSDialog.button(
                    text: 'Download',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Lidarr.'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> searchAllMissing(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Search All Missing',
            buttons: <Widget>[
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing albums?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> editArtist(BuildContext context, LidarrCatalogueData entry) async {
        List<List<dynamic>> _options = [
            ['Edit Artist', Icons.edit, 'edit_artist'],
            ['Refresh Artist', Icons.refresh, 'refresh_artist'],
            ['Remove Artist', Icons.delete, 'remove_artist'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: entry.title,
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    text: _options[index][0],
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> editRootFolder(BuildContext context, List<LidarrRootFolder> folders) async {
        bool _flag = false;
        LidarrRootFolder _folder;

        void _setValues(bool flag, LidarrRootFolder folder) {
            _flag = flag;
            _folder = folder;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Root Folder',
            content: List.generate(
                folders.length,
                (index) => LSDialog.tile(
                    text: folders[index].path,
                    subtitle: LSDialog.richText(
                        children: [
                            LSDialog.bolded(text: folders[index].freeSpace.lsBytes_BytesToString()),
                        ],
                    ),
                    icon: Icons.folder,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, folders[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _folder];
    }

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        List<List<dynamic>> _options = [
            ['View Web GUI', Icons.language, 'web_gui'],
            ['Update Library', Icons.autorenew, 'update_library'],
            ['Run RSS Sync', Icons.rss_feed, 'rss_sync'],
            ['Search All Missing', Icons.search, 'missing_search'],
            ['Backup Database', Icons.save, 'backup'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Lidarr Settings',
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> defaultPage(BuildContext context) async {
        bool _flag = false;
        int _index = 0;

        void _setValues(bool flag, int index) {
            _flag = flag;
            _index = index;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Default Page',
            content: List.generate(
                LidarrNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: LidarrNavigationBar.titles[index],
                    icon: LidarrNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }
}
