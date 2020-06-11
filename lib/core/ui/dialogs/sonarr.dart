import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/modules/sonarr.dart';

class LSDialogSonarr {
    LSDialogSonarr._();
    
    static Future<List> downloadWarning(BuildContext context) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: LSDialog.title(text: 'Download Release'),
                    actions: <Widget>[
                        LSDialog.cancel(context),
                        LSDialog.button(
                            text: 'Download',
                            textColor: LSColors.accent,
                            onPressed: () => _setValues(true),
                        ),
                    ],
                    content: LSDialog.content(
                        children: [
                            LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Sonarr.')
                        ],
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> deleteSeries(BuildContext context) async {
        //Returns
        bool _flag = false;
        bool _files = false;
        //Setter
        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Remove Series'),
                actions: <Widget>[
                    LSDialog.cancel(context),
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
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to remove the series from Sonarr?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag, _files];
    }

    static Future<List> searchAllMissing(BuildContext context) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Search All Missing'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Search',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to search for all missing episodes?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> globalSettings(BuildContext context) async {
        //Returns
        bool _flag = false;
        String _value = '';
        //Setter
        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Sonarr Settings'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            text: 'View Web GUI',
                            iconColor: LSColors.list(0),
                            icon: Icons.language,
                            onTap: () => _setValues(true, 'web_gui'),
                        ),
                        LSDialog.tile(
                            text: 'Update Library',
                            iconColor: LSColors.list(1),
                            icon: Icons.autorenew,
                            onTap: () => _setValues(true, 'update_library'),
                        ),
                        LSDialog.tile(
                            text: 'Run RSS Sync',
                            iconColor: LSColors.list(2),
                            icon: Icons.language,
                            onTap: () => _setValues(true, 'rss_sync'),
                        ),
                        LSDialog.tile(
                            text: 'Search All Missing',
                            iconColor: LSColors.list(3),
                            icon: Icons.search,
                            onTap: () => _setValues(true, 'missing_search'),
                        ),
                        LSDialog.tile(
                            text: 'Backup Database',
                            iconColor: LSColors.list(4),
                            icon: Icons.save,
                            onTap: () => _setValues(true, 'backup'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> editEpisode(BuildContext context, String title, bool monitored, bool canDelete) async {
        //Returns
        bool _flag = false;
        String _value = '';
        //Setter
        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            icon: monitored ? Icons.turned_in_not : Icons.turned_in,
                            iconColor: LSColors.list(0),
                            text: monitored ? 'Unmonitor Episode' : 'Monitor Episode',
                            onTap: () => _setValues(true, 'monitor_status'),
                        ),
                        LSDialog.tile(
                            icon: Icons.search,
                            iconColor: LSColors.list(1),
                            text: 'Automatic Search',
                            onTap: () => _setValues(true, 'search_automatic'),
                        ),
                        LSDialog.tile(
                            icon: Icons.youtube_searched_for,
                            iconColor: LSColors.list(2),
                            text: 'Manual Search',
                            onTap: () => _setValues(true, 'search_manual'),
                        ),
                        if(canDelete) LSDialog.tile(
                            icon: Icons.delete,
                            iconColor: LSColors.list(3),
                            text: 'Delete File',
                            onTap: () => _setValues(true, 'delete_file'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> editSeries(BuildContext context, SonarrCatalogueData entry) async {
        //Returns
        bool _flag = false;
        String _value = '';
        //Setter
        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: entry.title),
                actions: <Widget>[
                    LSDialog.cancel(
                        context,
                        textColor: LSColors.accent,
                    ),
                ],
                contentPadding: LSDialog.listDialogContentPadding(),
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            icon: Icons.edit,
                            iconColor: LSColors.blue,
                            text: 'Edit Series',
                            onTap: () => _setValues(true, 'edit_series'),
                        ),
                        LSDialog.tile(
                            icon: Icons.refresh,
                            iconColor: LSColors.accent,
                            text: 'Refresh Series',
                            onTap: () => _setValues(true, 'refresh_series'),
                        ),
                        LSDialog.tile(
                            icon: Icons.delete,
                            iconColor: LSColors.red,
                            text: 'Remove Series',
                            onTap: () => _setValues(true, 'remove_series'),
                        ),
                    ],
                ),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> editRootFolder(BuildContext context, List<SonarrRootFolder> folders) async {
        //Returns
        bool _flag = false;
        SonarrRootFolder _folder;
        //Setter
        void _setValues(bool flag, SonarrRootFolder folder) {
            _flag = flag;
            _folder = folder;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Root Folder'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        folders.length,
                        (index) => ListTile(
                            title: Text(folders[index].path),
                            subtitle: Text(
                                folders[index].freeSpace.lsBytes_BytesToString(),
                                style: TextStyle(
                                    color: LSColors.accent,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    LSIcon(
                                        icon: Icons.folder,
                                        color: LSColors.list(index),
                                    ),
                                ],
                            ),
                            onTap: () => _setValues(true, folders[index]),
                            contentPadding: LSDialog.listContentPadding(),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _folder];
    }

    static Future<List> editQualityProfile(BuildContext context, List<SonarrQualityProfile> qualities) async {
        //Returns
        bool _flag = false;
        SonarrQualityProfile _quality;
        //Setter
        void _setValues(bool flag, SonarrQualityProfile quality) {
            _flag = flag;
            _quality = quality;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Quality Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        qualities.length,
                        (index) => LSDialog.tile(
                            text: qualities[index].name,
                            icon: Icons.portrait,
                            iconColor: LSColors.list(index),
                            onTap: () => _setValues(true, qualities[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _quality];
    }

    static Future<List> editSeriesType(BuildContext context) async {
        //Returns
        bool _flag = false;
        SonarrSeriesType _type;
        //Setter
        void _setValues(bool flag, SonarrSeriesType type) {
            _flag = flag;
            _type = type;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Series Type'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        SonarrConstants.SERIES_TYPES.length,
                        (index) => LSDialog.tile(
                            text: toBeginningOfSentenceCase(SonarrConstants.SERIES_TYPES[index].type),
                            icon: Icons.tab,
                            iconColor: LSColors.list(index),
                            onTap: () => _setValues(true, SonarrConstants.SERIES_TYPES[index])
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _type];
    }

    static Future<List> searchEntireSeason(BuildContext context, int seasonNumber) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Episode Search'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Search',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(
                            text: seasonNumber == 0
                                ? 'Search for all episodes in specials?'
                                : 'Search for all episodes in season $seasonNumber?',
                        ),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> deleteEpisodeFile(BuildContext context) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Episode File'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Delete',
                        textColor: LSColors.red,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to delete this episode file?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }
}
