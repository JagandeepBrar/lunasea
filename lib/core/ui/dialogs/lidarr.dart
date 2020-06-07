import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LSDialogLidarr {
    LSDialogLidarr._();
    
    static Future<List> editQualityProfile(BuildContext context, List<LidarrQualityProfile> qualities) async {
        //Returns
        bool _flag = false;
        LidarrQualityProfile _quality;
        //Setter
        void _setValues(bool flag, LidarrQualityProfile quality) {
            _flag = flag;
            _quality = quality;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Quality Profile'),
                    actions: <Widget>[
                        LSDialog.cancel(context, textColor: LSColors.accent),
                    ],
                    content: LSDialog.content(
                        children: List.generate(
                            qualities.length,
                            (index) => ListTile(
                                title: Text(
                                    qualities[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                ),
                                leading: LSIcon(
                                    icon: Icons.portrait,
                                    color: LSColors.list(index),
                                ),
                                onTap: () => _setValues(true, qualities[index]),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0),
                );
            }
        );
        return [_flag, _quality];
    }

    static Future<List> editMetadataProfile(BuildContext context, List<LidarrMetadataProfile> metadatas) async {
        //Returns
        bool _flag = false;
        LidarrMetadataProfile _metadata;
        //Setter
        void _setValues(bool flag, LidarrMetadataProfile metadata) {
            _flag = flag;
            _metadata = metadata;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Metadata Profile'),
                    actions: <Widget>[
                        LSDialog.cancel(context, textColor: LSColors.accent),
                    ],
                    content: LSDialog.content(
                        children: List.generate(
                            metadatas.length,
                            (index) => ListTile(
                                title: Text(
                                    metadatas[index].name,
                                    style: TextStyle(color: Colors.white),
                                ),
                                leading: LSIcon(
                                    icon: Icons.portrait,
                                    color: LSColors.list(index),
                                ),
                                onTap: () => _setValues(true, metadatas[index]),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0),
                );
            }
        );
        return [_flag, _metadata];
    }

    static Future<List> deleteArtist(BuildContext context) async {
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
            builder: (BuildContext context) {
                return AlertDialog(
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
                    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
                );
            }
        );
        return [_flag, _files];
    }

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
            builder: (BuildContext context) {
                return AlertDialog(
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
                    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
                );
            }
        );
        return [_flag];
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
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Search All Missing'),
                    actions: <Widget>[
                        LSDialog.cancel(context),
                        LSDialog.button(
                            text: 'Search',
                            textColor: LSColors.accent,
                            onPressed: () => _setValues(true),
                        ),
                    ],
                    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
                    content: LSDialog.content(
                        children: [
                            LSDialog.textContent(text: 'Are you sure you want to search for all missing albums?'),
                        ],
                    ),
                );
            }
        );
        return [_flag];
    }

    static Future<List> editArtist(BuildContext context, LidarrCatalogueData entry) async {
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
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: entry.title),
                    actions: <Widget>[
                        LSDialog.cancel(
                            context,
                            textColor: LSColors.accent,
                        ),
                    ],
                    contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0),
                    content: LSDialog.content(
                        children: [
                            ListTile(
                                leading: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                ),
                                title: Text('Edit Artist'),
                                onTap: () => _setValues(true, 'edit_artist'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.refresh,
                                    color: LSColors.accent,
                                ),
                                title: Text('Refresh Artist'),
                                onTap: () => _setValues(true, 'refresh_artist'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.delete,
                                    color: LSColors.red,
                                ),
                                title: Text('Remove Artist'),
                                onTap: () => _setValues(true, 'remove_artist'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                        ],
                    ),
                );
            },
        );
        return [_flag, _value];
    }

    static Future<List> editRootFolder(BuildContext context, List<LidarrRootFolder> folders) async {
        //Returns
        bool _flag = false;
        LidarrRootFolder _folder;
        //Setter
        void _setValues(bool flag, LidarrRootFolder folder) {
            _flag = flag;
            _folder = folder;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
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
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0),
                );
            }
        );
        return [_flag, _folder];
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
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Lidarr Settings'),
                    actions: <Widget>[
                        LSDialog.cancel(context, textColor: LSColors.accent),
                    ],
                    content: LSDialog.content(
                        children: [
                            ListTile(
                                leading: Icon(
                                    Icons.language,
                                    color: LSColors.list(0),
                                ),
                                title: Text('View Web GUI'),
                                onTap: () => _setValues(true, 'web_gui'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.autorenew,
                                    color: LSColors.list(1),
                                ),
                                title: Text('Update Library'),
                                onTap: () => _setValues(true, 'update_library'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.rss_feed,
                                    color: LSColors.list(2),
                                ),
                                title: Text('Run RSS Sync'),
                                onTap: () => _setValues(true, 'rss_sync'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.search,
                                    color: LSColors.list(3),
                                ),
                                title: Text('Search All Missing'),
                                onTap: () => _setValues(true, 'missing_search'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.save,
                                    color: LSColors.list(4),
                                ),
                                title: Text('Backup Database'),
                                onTap: () => _setValues(true, 'backup'),
                                contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                            ),
                        ],
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0),
                );
            },
        );
        return [_flag, _value];
    }
}
