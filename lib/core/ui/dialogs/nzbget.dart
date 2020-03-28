import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetDialogs {
    NZBGetDialogs._();

    static Future<List<dynamic>> showSettingsPrompt(BuildContext context) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'NZBGet Settings',
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
                                        Icons.add,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Add NZB',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'add_nzb';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.sort,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Sort Queue',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'sort';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.info_outline,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Status & Statistics',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'server_details';
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

    static Future<List<dynamic>> showQueueSettingsPrompt(BuildContext context, String title, bool isPaused) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
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
                                        isPaused ? Icons.play_arrow : Icons.pause,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        isPaused ? 'Resume Job' : 'Pause Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'status';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.category,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Change Category',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'category';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Change Priority',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'priority';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.vpn_key,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Set Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'password';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.text_format,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'Rename Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'rename';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.delete,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        'Delete Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'delete';
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

    static Future<List<dynamic>> showDeleteJobPrompt(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Delete Job',
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
                            'Are you sure you want to delete this job?',
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

    static Future<List<dynamic>> showRenameJobPrompt(BuildContext context, String originalName) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        textController.text = originalName;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Rename Job',
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
                                'Rename',
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
                                    'Please enter a new name for this job.',
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
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'Name',
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
                                            if(value.length < 1) {
                                                return 'Please enter a valid name';
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

    static Future<List<dynamic>> showChangePriorityPrompt(BuildContext context) async {
        bool flag = false;
        NZBGetPriority priority;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Change Priority',
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
                            children: NZBGetPriority.values.expand((entry) => {
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Constants.LIST_COLOR_ICONS[entry.index % Constants.LIST_COLOR_ICONS.length],
                                    ),
                                    title: Text(
                                        entry.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = entry;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                )
                            }).toList(),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, priority];
    }

    static Future<List<dynamic>> showCategoryPrompt(BuildContext context, List<NZBGetCategoryData> categories) async {
        bool flag = false;
        NZBGetCategoryData entry;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Change Category',
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
                            children: List.generate(
                                categories.length,
                                (index) => ListTile(
                                    leading: Icon(
                                        Icons.category,
                                        color: Constants.LIST_COLOR_ICONS[index%Constants.LIST_COLOR_ICONS.length],
                                    ),
                                    title: Text(
                                        categories[index].name == '' ? 'No Category' : categories[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        entry = categories[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                )
                            ),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, entry];
    }

    static Future<List<dynamic>> showSetPasswordPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Set Password',
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
                                'Set',
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
                                    'Please enter a password for this job.',
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
                                            labelText: 'Password',
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
                                            if(value.length < 1) {
                                                return 'Please enter a valid password';
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

    static Future<List<dynamic>> showDeleteHistoryPrompt(BuildContext context) async {
        bool flag = false;
        bool hide = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Remove History',
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
                                'Hide',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                flag = true;
                                hide = true;
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
                                hide = false;
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: Text(
                            'Are you sure you want to remove the history for this job?',
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
        return [flag, hide];
    }

    static Future<List<dynamic>> showSortPrompt(BuildContext context) async {
        bool flag = false;
        NZBGetSort sort;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Sort Queue',
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
                            children: List.generate(
                                NZBGetSort.values.length,
                                (index) => ListTile(
                                    leading: Icon(
                                        NZBGetSort.values[index].icon,
                                        color: Constants.LIST_COLOR_ICONS[index%Constants.LIST_COLOR_ICONS.length],
                                    ),
                                    title: Text(
                                        NZBGetSort.values[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        sort = NZBGetSort.values[index];
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ),
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, sort];
    }

    static Future<List<dynamic>> showAddNZBPrompt(BuildContext context) async {
        bool flag = false;
        String type = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Add NZB',
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
                                        Icons.link,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Add by URL',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        type = 'link';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.sd_card,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Add by File',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        type = 'file';
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
        return [flag, type];
    }

    static Future<List<dynamic>> showaddURLPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Add NZB by URL',
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
                                'Add',
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
                                    'Please enter the URL of the NZB file you want to add.',
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
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'NZB URL',
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
                                            if(!value.startsWith('http://') && !value.startsWith('https://')) {
                                                return 'Please enter a valid URL';
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

    static Future<List<dynamic>> showSpeedPrompt(BuildContext context, String currentSpeed) async {
        bool flag = false;
        int limit = 0;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        currentSpeed == 'Unlimited' ? 'Speed Limit (Unlimited)' : 'Speed Limit ($currentSpeed/s)',
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
                                        Icons.timeline,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Unlimited',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 0;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        '125 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 128000;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        '100 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 102400;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        '75 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 76800;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        '50 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 51200;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        '25 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 25600;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        '10 MB/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 10240;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.timeline,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Custom',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = -1;
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
        return [flag, limit];
    }

    static Future<List<dynamic>> showCustomSpeedPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Custom Speed Limit',
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
                                'Set',
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
                                    'Please enter a speed limit in KB/s.',
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
                                        keyboardType: TextInputType.number,
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'Speed Limit',
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
                                            int _value = int.tryParse(value);
                                            if(_value == null || _value < 1) {
                                                return 'Must be a number greater than 1';
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
        return [flag, int.tryParse(textController.text)];
    }

    static Future<List<dynamic>> showHistorySettingsPrompt(BuildContext context, String title) async {
        bool flag = false;
        String value = '';
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
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
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
                                        Icons.autorenew,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Retry Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'retry';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.visibility_off,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Hide History',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'hide';
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
                                        'Delete History',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'delete';
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

    static Future<List<dynamic>> showPauseForPrompt(BuildContext context) async {
        bool flag = false;
        int duration = 0;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Pause Queue For...',
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
                                        Icons.access_time,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        '5 Minutes',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 5;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        '15 Minutes',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 15;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        '30 Minutes',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 30;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        '1 Hour',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 60;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        '3 Hours',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 180;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        '6 Hours',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = 360;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.access_time,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Custom',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        duration = -1;
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
        return [flag, duration];
    }

    static Future<List<dynamic>> showCustomPauseForPrompt(BuildContext context) async {
        bool flag = false;
        final formKey = GlobalKey<FormState>();
        final textController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Custom Pause Duration',
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
                                'Pause',
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
                                    'Please enter how long in minutes you want to pause the queue for.',
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
                                        controller: textController,
                                        decoration: InputDecoration(
                                            labelText: 'Pause Duration',
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
                                            int _value = int.tryParse(value);
                                            if(_value == null || _value < 1) {
                                                return 'Must be at least 1';
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
        return [flag, int.tryParse(textController.text)];
    }
}
