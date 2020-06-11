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
                title: Text(
                    'Sonarr Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                    ),
                ),
                actions: <Widget>[
                    FlatButton(
                        child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Color(Constants.ACCENT_COLOR),
                            ),
                        ),
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                    ),
                ],
                content: SingleChildScrollView(
                    child: ListBody(
                        children: <Widget>[
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

    static Future<List<dynamic>> showEditQualityProfilePrompt(BuildContext context, List<SonarrQualityProfile> qualities) async {
        bool flag = false;
        SonarrQualityProfile quality;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Quality Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: qualities.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: Text(
                                        qualities[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    leading: Icon(
                                        Icons.portrait,
                                        color: Constants.LIST_COLOR_ICONS[index%Constants.LIST_COLOR_ICONS.length],
                                    ),
                                    onTap: () {
                                        quality = qualities[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 32.0, 0.0),
                );
            }
        );
        return [flag, quality];
    }

    static Future<List<dynamic>> showEditSeriesTypePrompt(BuildContext context) async {
        bool flag = false;
        SonarrSeriesType type;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Series Type',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: SonarrConstants.SERIES_TYPES.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: Text(
                                        toBeginningOfSentenceCase(SonarrConstants.SERIES_TYPES[index].type),
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    leading: Icon(
                                        Icons.tab,
                                        color: Constants.LIST_COLOR_ICONS[index%Constants.LIST_COLOR_ICONS.length],
                                    ),
                                    onTap: () {
                                        type = SonarrConstants.SERIES_TYPES[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 32.0, 0.0),
                );
            }
        );
        return [flag, type];
    }

    static Future<List<dynamic>> showSearchSeasonPrompt(BuildContext context, int seasonNumber) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Episode Search',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                        FlatButton(
                            child: Text(
                                'Search',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: Text(
                            seasonNumber == 0 ? 'Search for all episodes in specials?' : 'Search for all episodes in season $seasonNumber?',
                            style: TextStyle(
                                color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    ),
                );
            }
        );
        return [flag];
    }

    static Future<List<dynamic>> showDeleteFilePrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Delete Episode File',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                        FlatButton(
                            child: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.red,
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: Text(
                            'Are you sure you want to delete this episode file?',
                            style: TextStyle(
                                color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    ),
                );
            }
        );
        return [flag];
    }
}
