import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
    RadarrDialogs._();
    
    static Future<List> deleteMovieFile(BuildContext context) async {
        bool _flag = false;
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Movie File'),
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
                        LSDialog.textContent(text: 'Are you sure you want to delete this movie file?'),
                    ]
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> deleteMovie(BuildContext context) async {
        bool _flag = false;
        bool _files = false;
        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Remove Movie'),
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
                        LSDialog.textContent(text: 'Are you sure you want to remove the movie from Radarr?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
                );
            }
        );
        return [_flag, _files];
    }

    static Future<List> searchAllMissing(BuildContext context) async {
        bool _flag = false;
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
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
                        LSDialog.textContent(text: 'Are you sure you want to search for all missing movies?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> editMovie(BuildContext context, RadarrCatalogueData entry) async {
        bool _flag = false;
        String _value = '';
        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }
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
                            text: 'Edit Movie',
                            onTap: () => _setValues(true, 'edit_movie'),
                        ),
                        LSDialog.tile(
                            icon: Icons.refresh,
                            iconColor: LSColors.accent,
                            text: 'Refresh Movie',
                            onTap: () => _setValues(true, 'refresh_movie'),
                        ),
                        LSDialog.tile(
                            icon: Icons.delete,
                            iconColor: LSColors.red,
                            text: 'Remove Movie',
                            onTap: () => _setValues(true, 'remove_movie'),
                        ),
                    ],
                ),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> editMinimumAvailability(BuildContext context, List<RadarrAvailability> availability) async {
        bool _flag = false;
        RadarrAvailability _entry;
        void _setValues(bool flag, RadarrAvailability entry) {
            _flag = flag;
            _entry = entry;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Minimum Availability'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        availability.length,
                        (index) => LSDialog.tile(
                            text: availability[index].name,
                            icon: Icons.folder,
                            iconColor: LSColors.list(index),
                            onTap: () => _setValues(true, availability[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _entry];
    }

    static Future<List> editRootFolder(BuildContext context, List<RadarrRootFolder> folders) async {
        bool _flag = false;
        RadarrRootFolder _folder;
        void _setValues(bool flag, RadarrRootFolder folder) {
            _flag = flag;
            _folder = folder;
            Navigator.of(context).pop();
        }
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

    static Future<List> editQualityProfile(BuildContext context, List<RadarrQualityProfile> qualities) async {
        bool _flag = false;
        RadarrQualityProfile _quality;
        void _setValues(bool flag, RadarrQualityProfile quality) {
            _flag = flag;
            _quality = quality;
            Navigator.of(context).pop();
        }
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

    static Future<List> downloadWarning(BuildContext context) async {
        bool _flag = false;
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
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
                            LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Radarr.')
                        ],
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> globalSettings(BuildContext context) async {
        bool _flag = false;
        String _value = '';
        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Radarr Settings'),
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
}
