import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDialogs {
    SonarrDialogs._();
    
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
                LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Sonarr.')
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteSeries(BuildContext context) async {
        bool _flag = false;
        bool _files = false;

        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Remove Series',
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
                LSDialog.textContent(text: 'Are you sure you want to remove the series from Sonarr?'),
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
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing episodes?'),
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
            title: 'Sonarr Settings',
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

    static Future<List<dynamic>> editEpisode(BuildContext context, String title, bool monitored, bool canDelete) async {
        List<List<dynamic>> _options = [
            monitored
                ? ['Unmonitor Episode', Icons.turned_in_not, 'monitor_status']
                : ['Monitor Episode', Icons.turned_in, 'monitor_status'],
            ['Automatic Search', Icons.search, 'search_automatic'],
            ['Interactive Search', Icons.youtube_searched_for, 'search_manual'],
            if(canDelete) ['Delete File', Icons.delete, 'delete_file'],
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
            title: title,
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

    static Future<List<dynamic>> editSeries(BuildContext context, SonarrCatalogueData entry) async {
        List<List<dynamic>> _options = [
            ['Edit Series', Icons.edit, 'edit_series'],
            ['Refresh Series', Icons.refresh, 'refresh_series'],
            ['Remove Series', Icons.delete, 'remove_series'],
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

    static Future<List<dynamic>> editRootFolder(BuildContext context, List<SonarrRootFolder> folders) async {
        bool _flag = false;
        SonarrRootFolder _folder;

        void _setValues(bool flag, SonarrRootFolder folder) {
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

    static Future<List<dynamic>> editMonitoringStatus(BuildContext context) async {
        bool _flag = false;
        SonarrMonitorStatus _status;

        void _setValues(bool flag, SonarrMonitorStatus status) {
            _flag = flag;
            _status = status;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Monitoring Status',
            content: List.generate(
                SonarrMonitorStatus.values.length,
                (index) => LSDialog.tile(
                    text: SonarrMonitorStatus.values[index].name,
                    icon: Icons.view_list,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, SonarrMonitorStatus.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _status];
    }

    static Future<List<dynamic>> editQualityProfile(BuildContext context, List<SonarrQualityProfile> qualities) async {
        bool _flag = false;
        SonarrQualityProfile _quality;

        void _setValues(bool flag, SonarrQualityProfile quality) {
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

    static Future<List<dynamic>> editSeriesType(BuildContext context) async {
        bool _flag = false;
        SonarrSeriesType _type;

        void _setValues(bool flag, SonarrSeriesType type) {
            _flag = flag;
            _type = type;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Series Type',
            content: List.generate(
                SonarrConstants.SERIES_TYPES.length,
                (index) => LSDialog.tile(
                    text: toBeginningOfSentenceCase(SonarrConstants.SERIES_TYPES[index].type),
                    icon: Icons.tab,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, SonarrConstants.SERIES_TYPES[index])
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _type];
    }

    static Future<List<dynamic>> searchEntireSeason(BuildContext context, int seasonNumber) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Episode Search',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(
                    text: seasonNumber == 0
                        ? 'Search for all episodes in specials?'
                        : 'Search for all episodes in season $seasonNumber?',
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteEpisodeFile(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Episode File',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this episode file?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
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
                SonarrNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: SonarrNavigationBar.titles[index],
                    icon: SonarrNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }
}
