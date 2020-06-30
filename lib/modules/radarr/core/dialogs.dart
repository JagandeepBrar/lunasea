import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
    RadarrDialogs._();
    
    static Future<List<dynamic>> deleteMovieFile(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Movie File',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this movie file?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteMovie(BuildContext context) async {
        bool _flag = false;
        bool _files = false;

        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Remove Movie',
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
                LSDialog.textContent(text: 'Are you sure you want to remove the movie from Radarr?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag, _files];
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
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    textColor: LSColors.accent,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing movies?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> editMovie(BuildContext context, RadarrCatalogueData entry) async {
        List<List<dynamic>> _options = [
            ['Edit Movie', Icons.edit, 'edit_movie'],
            ['Refresh Movie', Icons.refresh, 'refresh_movie'],
            ['Remove Movie', Icons.delete, 'remove_movie'],
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

    static Future<List<dynamic>> editMinimumAvailability(BuildContext context, List<RadarrAvailability> availability) async {
        bool _flag = false;
        RadarrAvailability _entry;

        void _setValues(bool flag, RadarrAvailability entry) {
            _flag = flag;
            _entry = entry;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Minimum Availability',
            content: List.generate(
                availability.length,
                (index) => LSDialog.tile(
                    text: availability[index].name,
                    icon: Icons.folder,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, availability[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _entry];
    }

    static Future<List<dynamic>> editRootFolder(BuildContext context, List<RadarrRootFolder> folders) async {
        bool _flag = false;
        RadarrRootFolder _folder;

        void _setValues(bool flag, RadarrRootFolder folder) {
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

    static Future<List<dynamic>> editQualityProfile(BuildContext context, List<RadarrQualityProfile> qualities) async {
        bool _flag = false;
        RadarrQualityProfile _quality;
        
        void _setValues(bool flag, RadarrQualityProfile quality) {
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
                    text: qualities[index].name,
                    icon: Icons.portrait,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, qualities[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _quality];
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
            buttons: [
                LSDialog.button(
                    text: 'Download',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Radarr.')
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
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
            title: 'Radarr Settings',
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
                RadarrNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: RadarrNavigationBar.titles[index],
                    icon: RadarrNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }
}
