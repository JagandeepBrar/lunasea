import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class SystemDialogs {
    static Future<List<dynamic>> showSignoutPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Sign Out of LunaSea',
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
                                'Sign Out',
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
                            'Are you sure you want to sign out?\n\nSigning out may disable functionality within LunaSea.',
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

    static Future<void> showChangelogPrompt(BuildContext context, List changes) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Changelog',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Close',
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
                            itemCount: changes.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: Elements.getTitle('${changes[index]['version']}', maxLines: 2),
                                    subtitle: Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    letterSpacing: Constants.LETTER_SPACING,
                                                ),
                                                children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'New\n',
                                                        style: TextStyle(
                                                            color: Color(Constants.ACCENT_COLOR),
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: changes[index]['new'].length == 0 ? 'No Changes' : '- ${changes[index]['new'].join('\n- ')}',
                                                    ),
                                                    TextSpan(
                                                        text: '\n\nFixes\n',
                                                        style: TextStyle(
                                                            color: Color(Constants.ACCENT_COLOR),
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: changes[index]['fixes'].length == 0 ? 'No Changes' : '- ${changes[index]['fixes'].join('\n- ')}',
                                                    ),
                                                    TextSpan(
                                                        text: '\n\nTweaks\n',
                                                        style: TextStyle(
                                                            color: Color(Constants.ACCENT_COLOR),
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: changes[index]['tweaks'].length == 0 ? 'No Changes' : '- ${changes[index]['tweaks'].join('\n- ')}',
                                                    )
                                                ]
                                            ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                    ),
                                );
                            },
                        ),
                        width: 400,
                    ),
                );
            }
        );
    }

    static Future<List<dynamic>> showEditTextPrompt(BuildContext context, String title, {String prefill = '', bool showHostHint = false}) async {
        bool flag = false;
        String value = prefill;
        final textController = TextEditingController();
        textController.text = value;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
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
                                'Save',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                if(textController.text.length > 0 && textController.text.substring(textController.text.length-1, textController.text.length) == '/') {
                                    value = textController.text.substring(0, textController.text.length-1);
                                } else {
                                    value = textController.text;
                                }
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                if(showHostHint) RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.white70,
                                            letterSpacing: Constants.LETTER_SPACING,
                                        ),
                                        children: <TextSpan>[
                                            TextSpan(
                                                text: '•\tYou must include either http:// or https://\n',
                                            ),
                                            TextSpan(
                                                text: '•\tTo add authentication, use the format http(s)://user:pass@hostname\n',
                                            ),
                                        ]
                                    ),
                                ),
                                TextField(
                                    autofocus: true,
                                    autocorrect: false,
                                    controller: textController,
                                    decoration: InputDecoration(
                                        labelText: title,
                                        labelStyle: TextStyle(
                                            color: Colors.white54,
                                            decoration: TextDecoration.none,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(Constants.ACCENT_COLOR),
                                            ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(Constants.ACCENT_COLOR),
                                            ),
                                        ),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    cursorColor: Color(Constants.ACCENT_COLOR),
                                ),
                            ],
                        ),
                    ),
                );
            }
        );
        return [flag, value];
    }

    static Future<List<dynamic>> showBackupConfigurationPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Backup Configuration',
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
                                'Backup',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                if(formKey.currentState.validate()) {
                                    flag = true;
                                    Navigator.of(context).pop();
                                }
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                Text(
                                    'Are you sure you want to backup your current configuration?\n',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                                Text(
                                    'All backups are encrypted before being exported to the filesystem, please enter an encryption key for the backup.',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                                Form(
                                    key: formKey,
                                    child: TextFormField(
                                        autofocus: true,
                                        autocorrect: false,
                                        obscureText: true,
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'Encryption Key',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                decoration: TextDecoration.none,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(Constants.ACCENT_COLOR),
                                                ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(Constants.ACCENT_COLOR),
                                                ),
                                            ),
                                        ),
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                        cursorColor: Color(Constants.ACCENT_COLOR),
                                        validator: (value) {
                                            if(value.length < 8) {
                                                return 'Minimum of 8 characters';
                                            }
                                            return null;
                                        },
                                    ),
                                ),
                            ],
                        ),
                        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    ),
                );
            }
        );
        return [flag, textController.text];
    }

    static Future<List<dynamic>> showRestoreConfigurationPrompt(BuildContext context, List<String> paths) async {
        bool flag = false;
        String path = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Restore Configuration',
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
                            itemCount: paths.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    leading: Icon(
                                        Icons.cloud_download,
                                        color: Constants.LIST_COLOUR_ICONS[index%Constants.LIST_COLOUR_ICONS.length],
                                    ),
                                    title: Text(
                                        paths[(paths.length-index-1)].substring(
                                            paths[(paths.length-index-1)].indexOf('/configurations/')+16,
                                            paths[(paths.length-index-1)].indexOf('.json')
                                        ).replaceAll('%', '\n'),
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () async {
                                        path = paths[paths.length-index-1];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, path];
    }

    static Future<List<dynamic>> showDeleteConfigurationPrompt(BuildContext context, List<String> paths) async {
        bool flag = false;
        String path = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Delete Configuration',
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
                            itemCount: paths.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    leading: Icon(
                                        Icons.delete,
                                        color: Constants.LIST_COLOUR_ICONS[index%Constants.LIST_COLOUR_ICONS.length],
                                    ),
                                    title: Text(
                                        paths[(paths.length-index-1)].substring(
                                            paths[(paths.length-index-1)].indexOf('/configurations/')+16,
                                            paths[(paths.length-index-1)].indexOf('.json')
                                        ).replaceAll('%', '\n'),
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () async {
                                        path = paths[paths.length-index-1];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, path];
    }

    static Future<List<dynamic>> showChangeProfilePrompt(BuildContext context, List<String> profiles) async {
        bool flag = false;
        String profile = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Enabled Profile',
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
                            itemCount: profiles.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    leading: Icon(
                                        Icons.settings,
                                        color: Constants.LIST_COLOUR_ICONS[index%Constants.LIST_COLOUR_ICONS.length],
                                    ),
                                    title: Text(
                                        profiles[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () async {
                                        profile = profiles[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, profile];
    }

    static Future<List<dynamic>> showDeleteProfilePrompt(BuildContext context, List<String> profiles) async {
        bool flag = false;
        String profile = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Delete Profile',
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
                            }
                        ),
                    ],
                    content: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: profiles.length,
                            itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    leading: Icon(
                                        Icons.settings,
                                        color: Constants.LIST_COLOUR_ICONS[index%Constants.LIST_COLOUR_ICONS.length],
                                    ),
                                    title: Text(
                                        profiles[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () async {
                                        profile = profiles[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                );
                            },
                        ),
                        width: 400,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, profile];
    }

    static Future<List<dynamic>> showAddProfilePrompt(BuildContext context) async {
        final profileController = TextEditingController();
        bool flag = false;
        String profile = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Add Profile',
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
                                'Save',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () async {
                                flag = true;
                                profile = profileController.text;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                TextField(
                                    autofocus: true,
                                    autocorrect: false,
                                    controller: profileController,
                                    decoration: InputDecoration(
                                        labelText: 'Profile Name',
                                        labelStyle: TextStyle(
                                            color: Colors.white54,
                                            decoration: TextDecoration.none,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(Constants.ACCENT_COLOR),
                                            ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(Constants.ACCENT_COLOR),
                                            ),
                                        )
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    cursorColor: Color(Constants.ACCENT_COLOR),
                                ),
                            ],
                        ),
                    ),
                );
            }
        );
        return [flag, profile];
    }

    static Future<List<dynamic>> showPurchaseProPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Purchase LunaSea Pro',
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
                                'Enable Pro',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () async {
                                flag = true;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: Text(
                            'For the period that LunaSea is in pre-release/beta, all Pro features are free. Please tap "Enable Pro" below to fetch your license from the database.\n\nIf the the license is not fetched, please wait a few minutes and try again.',
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

    static Future<List<dynamic>> showEncryptionKeyPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Decrypt Backup',
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
                                'Restore',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                if(formKey.currentState.validate()) {
                                    flag = true;
                                    Navigator.of(context).pop();
                                }
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                Text(
                                    'Please enter the encryption key used for this backup.',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                                Form(
                                    key: formKey,
                                    child: TextFormField(
                                        autofocus: true,
                                        autocorrect: false,
                                        obscureText: true,
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'Encryption Key',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                decoration: TextDecoration.none,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(Constants.ACCENT_COLOR),
                                                ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(Constants.ACCENT_COLOR),
                                                ),
                                            ),
                                        ),
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                        cursorColor: Color(Constants.ACCENT_COLOR),
                                        validator: (value) {
                                            if(value.length < 8) {
                                                return 'Minimum of 8 characters';
                                            }
                                            return null;
                                        },
                                    ),
                                ),
                            ],
                        ),
                    ),
                );
            }
        );
        return [flag, textController.text];
    }

    static Future<void> showTextPreviewPrompt(BuildContext context, String title, String text) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Close',
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
                                Text(
                                    text,
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
    }

    static Future<List<dynamic>> showClearLogsPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Clear Logs',
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
                                'Clear',
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
                            'Are you sure you want to clear all recorded logs?\n\nLogs can be useful for bug reports and debugging.',
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

    static Future<List<dynamic>> showExportLogsPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Export Logs',
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
                                'Export',
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
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: Constants.LETTER_SPACING,
                                    fontSize: 16.0,
                                ),
                                children: <TextSpan>[
                                    TextSpan(
                                        text: 'Are you sure you want to export all recorded logs to the filesystem?\n\nThe exported logs can be found in\n',
                                    ),
                                    TextSpan(
                                        text: 'On My <Device>/LunaSea/FLogs',
                                        style: TextStyle(
                                            color: Color(Constants.ACCENT_COLOR),
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                    TextSpan(
                                        text: '.',
                                    ),
                                ]
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
