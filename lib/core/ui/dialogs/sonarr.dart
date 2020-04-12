import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/modules/sonarr.dart';

class LSDialogSonarr {
    LSDialogSonarr._();
    
    static Future<List<dynamic>> showDownloadWarningPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Download Release',
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
                                'Download',
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
                        child: ListBody(
                            children: <Widget>[
                                Text(
                                    'Are you sure you want to download this release? It has been marked as a rejected release by Sonarr.',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                            ],
                        ),
                        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    ),
                );
            }
        );
        return [flag];
    }

    static Future<List<dynamic>> showDeleteSeriesPrompt(BuildContext context) async {
        bool flag = false;
        bool files = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Remove Series',
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
                                'Remove + Files',
                                style: TextStyle(
                                    color: Colors.red,
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                files = true;
                                Navigator.of(context).pop();
                            },
                        ),
                        FlatButton(
                            child: Text(
                                'Remove',
                                style: TextStyle(
                                    color: Colors.red,
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                files = false;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: Text(
                            'Are you sure you want to remove the series from Sonarr?',
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
        return [flag, files];
    }

    static Future<List<dynamic>> showSearchMissingPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Search All Missing',
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
                            'Are you sure you want to search for all missing episodes?',
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

    static Future<List<dynamic>> showSettingsPrompt(BuildContext context) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
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
                                ListTile(
                                    leading: Icon(
                                        Icons.language,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'View Web GUI',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'web_gui';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.autorenew,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Update Library',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'update_library';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.rss_feed,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Run RSS Sync',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'rss_sync';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.search,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Search All Missing',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'missing_search';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.save,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'Backup Database',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'backup';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ],
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, value];
    }

    static Future<List<dynamic>> showEpisodeEditingPrompt(BuildContext context, String title, bool monitored, bool canDelete) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
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
                                ListTile(
                                    leading: Icon(
                                        monitored ? Icons.turned_in_not : Icons.turned_in,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        monitored ? 'Unmonitor Episode' : 'Monitor Episode',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'monitor_status';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.search,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Automatic Search',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'search_automatic';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.youtube_searched_for,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Manual Search',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'search_manual';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                if(canDelete) ListTile(
                                    leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Delete File',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'delete_file';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ],
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, value];
    }

    static Future<List<dynamic>> showEditSeriesPrompt(BuildContext context, SonarrCatalogueData entry) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        entry.title,
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
                                ListTile(
                                    leading: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Edit Series',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'edit_series';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.refresh,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Refresh Series',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'refresh_series';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Remove Series',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'remove_series';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ],
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, value];
    }

    static Future<List<dynamic>> showEditRootFolderPrompt(BuildContext context, List<SonarrRootFolder> folders) async {
        bool flag = false;
        SonarrRootFolder folder;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Root Folder',
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
                            itemCount: folders.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: Text(
                                        folders[index].path,
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
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
                                                color: Constants.LIST_COLOR_ICONS[index%Constants.LIST_COLOR_ICONS.length],
                                            ),
                                        ],
                                    ),
                                    onTap: () {
                                        folder = folders[index];
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
        return [flag, folder];
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
