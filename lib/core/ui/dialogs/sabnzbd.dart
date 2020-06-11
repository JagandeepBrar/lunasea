import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class LSDialogSABnzbd {
    LSDialogSABnzbd._();
    
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
                title: LSDialog.title(text: 'SABnzbd Settings'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            text: 'View Web GUI',
                            icon: Icons.language,
                            iconColor: LSColors.list(0),
                            onTap: () => _setValues(true, 'web_gui'),
                        ),
                        LSDialog.tile(
                            text: 'Add NZB',
                            icon: Icons.add,
                            iconColor: LSColors.list(1),
                            onTap: () => _setValues(true, 'add_nzb'),
                        ),
                        LSDialog.tile(
                            text: 'Sort Queue',
                            icon: Icons.sort,
                            iconColor: LSColors.list(2),
                            onTap: () => _setValues(true, 'sort'),
                        ),
                        LSDialog.tile(
                            text: 'Clear History',
                            icon: Icons.clear_all,
                            iconColor: LSColors.list(3),
                            onTap: () => _setValues(true, 'clear_history'),
                        ),
                        LSDialog.tile(
                            text: 'On Complete Action',
                            icon: Icons.settings_power,
                            iconColor: LSColors.list(4),
                            onTap: () => _setValues(true, 'complete_action'),
                        ),
                        LSDialog.tile(
                            text: 'Status & Statistics',
                            icon: Icons.info_outline,
                            iconColor: LSColors.list(5),
                            onTap: () => _setValues(true, 'server_details'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> queueSettings(BuildContext context, String title, bool isPaused) async {
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
                            text: isPaused ? 'Resume Job' : 'Pause Job',
                            icon: isPaused ? Icons.play_arrow : Icons.pause,
                            iconColor: LSColors.list(0),
                            onTap: () => _setValues(true, 'status'),
                        ),
                        LSDialog.tile(
                            text: 'Change Category',
                            icon: Icons.category,
                            iconColor: LSColors.list(1),
                            onTap: () => _setValues(true, 'category'),
                        ),
                        LSDialog.tile(
                            text: 'Change Priority',
                            icon: Icons.low_priority,
                            iconColor: LSColors.list(2),
                            onTap: () => _setValues(true, 'priority'),
                        ),
                        LSDialog.tile(
                            text: 'Set Password',
                            icon: Icons.vpn_key,
                            iconColor: LSColors.list(3),
                            onTap: () => _setValues(true, 'password'),
                        ),
                        LSDialog.tile(
                            text: 'Rename Job',
                            icon: Icons.text_format,
                            iconColor: LSColors.list(4),
                            onTap: () => _setValues(true, 'rename'),
                        ),
                        LSDialog.tile(
                            text: 'Delete Job',
                            icon: Icons.delete,
                            iconColor: LSColors.list(5),
                            onTap: () => _setValues(true, 'delete'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> historySettings(BuildContext context, String title, bool failed) async {
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
                        if(failed) LSDialog.tile(
                            text: 'Retry Job',
                            icon: Icons.autorenew,
                            iconColor: LSColors.list(0),
                            onTap: () => _setValues(true, 'retry'),
                        ),
                        if(failed) LSDialog.tile(
                            text: 'Set Password',
                            icon: Icons.vpn_key,
                            iconColor: LSColors.list(1),
                            onTap: () => _setValues(true, 'password'),
                        ),
                        LSDialog.tile(
                            text: 'Delete History',
                            icon: Icons.delete,
                            iconColor: LSColors.red,
                            onTap: () => _setValues(true, 'delete'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> changeCategory(BuildContext context, List<SABnzbdCategoryData> categories) async {
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
                title: LSDialog.title(text: 'Change Category'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        categories.length,
                        (index) => LSDialog.tile(
                            text: categories[index].category,
                            icon: Icons.category,
                            iconColor: LSColors.list(index),
                            onTap: () => _setValues(true, categories[index].category),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _value];
    }

    static Future<List> sortQueue(BuildContext context) async {
        //Returns
        bool _flag = false;
        String _sort = '';
        String _dir = '';
        String _name = '';
        //Setter
        void _setValues(bool flag, String sort, String dir, String name) {
            _flag = flag;
            _sort = sort;
            _dir = dir;
            _name = name;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Sort Queue'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            text: 'Age (Ascending)',
                            icon: Icons.access_time,
                            iconColor: LSColors.list(0),
                            onTap: () => _setValues(true, 'avg_age', 'asc', 'Age (Ascending)'),
                        ),
                        LSDialog.tile(
                            text: 'Age (Descending)',
                            icon: Icons.access_time,
                            iconColor: LSColors.list(1),
                            onTap: () => _setValues(true, 'avg_age', 'desc', 'Age (Descending)'),
                        ),
                        LSDialog.tile(
                            text: 'Name (Ascending)',
                            icon: Icons.text_rotate_vertical,
                            iconColor: LSColors.list(2),
                            onTap: () => _setValues(true, 'name', 'asc', 'Name (Ascending)'),
                        ),
                        LSDialog.tile(
                            text: 'Name (Descending)',
                            icon: Icons.text_rotate_vertical,
                            iconColor: LSColors.list(3),
                            onTap: () => _setValues(true, 'name', 'desc', 'Name (Descending)'),
                        ),
                        LSDialog.tile(
                            text: 'Size (Ascending)',
                            icon: Icons.sd_card,
                            iconColor: LSColors.list(4),
                            onTap: () => _setValues(true, 'size', 'asc', 'Size (Ascending)'),
                        ),
                        LSDialog.tile(
                            text: 'Size (Descending)',
                            icon: Icons.sd_card,
                            iconColor: LSColors.list(5),
                            onTap: () => _setValues(true, 'size', 'desc', 'Size (Descending)'),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _sort, _dir, _name];
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

    static Future<List<dynamic>> showSpeedPrompt(BuildContext context, int currentSpeed) async {
        bool flag = false;
        int limit = 0;
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Speed Limit ($currentSpeed%)',
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
                                        '20%',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 20;
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
                                        '40%',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 40;
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
                                        '60%',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 60;
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
                                        '80%',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 80;
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
                                        '100%',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        limit = 100;
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

    static Future<List<dynamic>> showChangePriorityPrompt(BuildContext context) async {
        bool flag = false;
        int priority = 0;
        String name = '';
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
                            children: <Widget>[
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Category Default',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = -100;
                                        name = 'Category Default';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Force',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = 2;
                                        name = 'Force';
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
                                        'High',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = 1;
                                        name = 'High';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Normal',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = 0;
                                        name = 'Normal';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'Low',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = -1;
                                        name = 'Low';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        'Stop',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        priority = -4;
                                        name = 'Stop';
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
        return [flag, priority, name];
    }

    static Future<List<dynamic>> showOnCompletePrompt(BuildContext context) async {
        bool flag = false;
        String action = '';
        String name = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'On Complete Action',
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
                                        Icons.settings_power,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Shutdown SABnzbd',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        name = 'Shutdown SABnzbd';
                                        action = 'shutdown_program';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.settings_power,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Shutdown PC',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        name = 'Shutdown PC';
                                        action = 'shutdown_pc';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.settings_power,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Hibernate PC',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        name = 'Hibernate PC';
                                        action = 'hibernate_pc';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.settings_power,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Standby PC',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        name = 'Standby PC';
                                        action = 'standby_pc';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.settings_power,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'Nothing',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        name = 'Nothing';
                                        action = 'none';
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
        return [flag, action, name];
    }

    static Future<List<dynamic>> showClearHistoryPrompt(BuildContext context) async {
        bool flag = false;
        bool delete = false;
        String action = '';
        String name = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'Clear History',
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
                                        Icons.clear_all,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'Clear All',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        action = 'all';
                                        name = 'Clear All';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.clear_all,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Clear Completed',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        action = 'completed';
                                        name = 'Clear Completed';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.clear_all,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Clear Failed',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        action = 'failed';
                                        name = 'Clear Failed';
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.clear_all,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Clear & Delete Failed',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        flag = true;
                                        delete = true;
                                        action = 'failed';
                                        name = 'Clear & Delete Failed';
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
        return [flag, action, delete, name];
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
                                    'Please enter a percentage between 1 and 100.',
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
                                            if(_value == null || _value < 1 || _value > 100) {
                                                return 'Must be between 1 and 100';
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

    static Future<List> deleteHistoryEntry(BuildContext context) async {
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
                title: LSDialog.title(text: 'Delete History'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Delete',
                        textColor: LSColors.red,
                        onPressed: () => _setValues(true),
                    )
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to delete the history for this job?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }
}
