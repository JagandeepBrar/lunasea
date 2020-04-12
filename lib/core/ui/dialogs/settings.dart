import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDialogSettings {
    LSDialogSettings._();

    static Future<List> deleteIndexer(BuildContext context) async {
        //Returns
        bool _flag = false;
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Indexer'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Delete',
                        onPressed: () {
                            _flag = true;
                            Navigator.of(context).pop();
                        },
                        textColor: Colors.red,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(
                            text: 'Are you sure you want to delete this indexer?'
                        ),
                    ],
                ),
            ),
        );
        return [_flag];
    }

    static Future<void> showChangelog(BuildContext context, List changes) async {
        const _headerStyle = TextStyle(
            color: Color(Constants.ACCENT_COLOR),
            fontWeight: FontWeight.bold,
        );
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Changelog'),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Close',
                        textColor: LSColors.accent,
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        changes.length,
                        (index) => ListTile(
                            title: LSTitle(
                                text: '${changes[index]['version']}',
                                maxLines: 2,
                            ),
                            subtitle: Padding(
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.white70,
                                            letterSpacing: Constants.UI_LETTER_SPACING,
                                        ),
                                        children: <TextSpan>[
                                            TextSpan(text: 'New\n', style: _headerStyle),
                                            LSDialog.textSpanContent(text: changes[index]['new'].length == 0 ? 'No Changes' : '- ${changes[index]['new'].join('\n- ')}'),
                                            TextSpan(text: '\n\nFixes\n', style: _headerStyle),
                                            LSDialog.textSpanContent(text: changes[index]['fixes'].length == 0 ? 'No Changes' : '- ${changes[index]['fixes'].join('\n- ')}'),
                                            TextSpan(text: '\n\nTweaks\n', style: _headerStyle),
                                            LSDialog.textSpanContent(text: changes[index]['tweaks'].length == 0 ? 'No Changes' : '- ${changes[index]['tweaks'].join('\n- ')}'),
                                        ]
                                    ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                            ),
                        ),
                    ).toList(),
                ),
            ),
        );
    }

    static Future<List> exportLogs(BuildContext context) async {
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
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Export Logs'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Export',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.accent,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to export all recorded logs to the filesystem?\n'),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                children: [
                                    LSDialog.textSpanContent(text: 'The exported logs can be found in '),
                                    LSDialog.bolded(title: '<On My Device>/LunaSea/FLogs', fontSize: 16.0),
                                    LSDialog.textSpanContent(text: '.'),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
        return [_flag];
    }

    static Future<List> clearLogs(BuildContext context) async {
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
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Clear Logs'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Clear',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.red,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to clear all recorded logs?\n\nLogs can be useful for bug reports and debugging.'),
                    ],
                ),
            ),
        );
        return [_flag];
    }

    static Future<List> toggleStrictTLS(BuildContext context) async {
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
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Disable Strict SSL/TLS Validation'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Disable',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.red,
                    ),
                ],
                content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                            LSDialog.bolded(
                                title: 'Please do not disable this setting unless you know what you are doing.\n\n',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                            LSDialog.textSpanContent(text: 'Are you sure you want to disable strict SSL/TLS validation?\n\n'),
                            LSDialog.textSpanContent(text: 'Disabling strict SSL/TLS validation means that LunaSea will not validate the host machine\'s SSL certificate against a certificate authority.\n\n'),
                            LSDialog.textSpanContent(text: 'LunaSea will still connect to your host machine securely when using SSL/TLS whether strict SSL/TLS validation is enabled or disabled.\n\n'),
                            LSDialog.bolded(
                                title: 'Note: Disabling strict SSL/TLS for an invalid or self-signed certificate will prevent a large amount of images from loading within LunaSea.',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                        ],
                    ),
                ),
            ),
        );
        return [_flag];
    }

    static Future<List> addProfile(BuildContext context) async {
        //Returns
        TextEditingController _controller = TextEditingController();
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Add Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Save',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.accent,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textInput(
                            controller: _controller,
                            onSubmitted: (_) => _setValues(true),
                            title: 'Profile Name',
                        ),
                    ],
                ),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<List> renameProfile(BuildContext context, List<String> profiles) async {
        //Returns
        bool _flag = false;
        String _profile = '';
        //Setter
        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Add Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        profiles.length,
                        (index) => ListTile(
                            leading: LSIcon(
                                icon: Icons.settings,
                                color: LSColors.list(index),
                            ),
                            title: Text(
                                profiles[index],
                                style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => _setValues(true, profiles[index]),
                            contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                        ),
                    ),
                ),
                contentPadding: EdgeInsets.only(left: 24.0, top: 20.0, right: 24.0),
            ),
        );
        return [_flag, _profile];
    }

    static Future<List> renameProfileSelected(BuildContext context) async {
        //Returns
        final _controller = TextEditingController();
        bool _flag = false;
        //Setters
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Rename Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(text: 'Rename', onPressed: () => _setValues(true), textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textInput(
                            controller: _controller,
                            onSubmitted: (_) => _setValues(true),
                            title: 'New Profile Name',
                        ),
                    ],
                ),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<List> deleteProfile(BuildContext context, List<String> profiles) async {
        //Returns
        bool _flag = false;
        String _profile = '';
        //Setter
        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        profiles.length,
                        (index) => ListTile(
                            leading: LSIcon(
                                icon: Icons.settings,
                                color: LSColors.list(index),
                            ),
                            title: Text(
                                profiles[index],
                                style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => _setValues(true, profiles[index]),
                            contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                        ),
                    ),
                ),
                contentPadding: EdgeInsets.only(left: 24.0, top: 20.0, right: 24.0),
            ),
        );
        return [_flag, _profile];
    }

    static Future<List> changeProfile(BuildContext context, List<String> profiles) async {
        //Returns
        bool _flag = false;
        String _profile = '';
        //Setter
        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Enabled Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        profiles.length,
                        (index) => ListTile(
                            leading: LSIcon(
                                icon: Icons.settings,
                                color: LSColors.list(index),
                            ),
                            title: Text(
                                profiles[index],
                                style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => _setValues(true, profiles[index]),
                            contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                        ),
                    ),
                ),
                contentPadding: EdgeInsets.only(left: 24.0, top: 20.0, right: 24.0),
            ),
        );
        return [_flag, _profile];
    }
}
