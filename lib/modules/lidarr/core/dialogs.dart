import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDialogs {
    LidarrDialogs._();
    
    static Future<List> editQualityProfile(BuildContext context, List<LidarrQualityProfile> qualities) async {
        bool _flag = false;
        LidarrQualityProfile _quality;
        void _setValues(bool flag, LidarrQualityProfile quality) {
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
                            icon: Icons.portrait,
                            iconColor: LSColors.list(index),
                            text: qualities[index].name,
                            onTap: () => _setValues(true, qualities[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _quality];
    }

    static Future<List> editMetadataProfile(BuildContext context, List<LidarrMetadataProfile> metadatas) async {
        bool _flag = false;
        LidarrMetadataProfile _metadata;
        void _setValues(bool flag, LidarrMetadataProfile metadata) {
            _flag = flag;
            _metadata = metadata;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Metadata Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        metadatas.length,
                        (index) => LSDialog.tile(
                            icon: Icons.portrait,
                            iconColor: LSColors.list(index),
                            text: metadatas[index].name,
                            onTap: () => _setValues(true, metadatas[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _metadata];
    }

    static Future<List> deleteArtist(BuildContext context) async {
        bool _flag = false;
        bool _files = false;
        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Remove Artist'),
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
                        LSDialog.textContent(text: 'Are you sure you want to remove the artist from Lidarr?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag, _files];
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
                        LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Lidarr.'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
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
                contentPadding: LSDialog.textDialogContentPadding(),
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to search for all missing albums?'),
                    ],
                ),
            ),
        );
        return [_flag];
    }

    static Future<List> editArtist(BuildContext context, LidarrCatalogueData entry) async {
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
                            text: 'Edit Artist',
                            onTap: () => _setValues(true, 'edit_artist'),
                        ),
                        LSDialog.tile(
                            icon: Icons.refresh,
                            iconColor: LSColors.accent,
                            text: 'Refresh Artist',
                            onTap: () => _setValues(true, 'refresh_artist'),
                        ),
                        LSDialog.tile(
                            icon: Icons.delete,
                            iconColor: LSColors.red,
                            text: 'Remove Artist',
                            onTap: () => _setValues(true, 'remove_artist'),
                        ),
                    ],
                ),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> editRootFolder(BuildContext context, List<LidarrRootFolder> folders) async {
        bool _flag = false;
        LidarrRootFolder _folder;
        void _setValues(bool flag, LidarrRootFolder folder) {
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
                            leading:  Column(
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
                title: LSDialog.title(text: 'Lidarr Settings'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            icon: Icons.language,
                            iconColor: LSColors.list(0),
                            text: 'View Web GUI',
                            onTap: () => _setValues(true, 'web_gui'),
                        ),
                        LSDialog.tile(
                            icon: Icons.autorenew,
                            iconColor: LSColors.list(1),
                            text: 'Update Library',
                            onTap: () => _setValues(true, 'update_library'),
                        ),
                        LSDialog.tile(
                            icon: Icons.rss_feed,
                            iconColor: LSColors.list(2),
                            text: 'Run RSS Sync',
                            onTap: () => _setValues(true, 'rss_sync'),
                        ),
                        LSDialog.tile(
                            icon: Icons.search,
                            iconColor: LSColors.list(3),
                            text: 'Search All Missing',
                            onTap: () => _setValues(true, 'missing_search'),
                        ),
                        LSDialog.tile(
                            icon: Icons.save,
                            iconColor: LSColors.list(4),
                            text: 'Backup Database',
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
