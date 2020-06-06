import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDialogSystem {
    LSDialogSystem._();

    static Future<List> editText(BuildContext context, String title, {String prefill = '', bool showHostHint = false}) async {
        //Returns
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        TextEditingController _controller = TextEditingController()..text = prefill;
        //Setter
        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Save',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true)),
                ],
                content: LSDialog.content(
                    children: [
                        if(showHostHint) RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.white70),
                                children: [
                                    TextSpan(text: '•\tThis is the URL in which you access the web GUI for the service\n'),
                                    TextSpan(text: '•\tYou must include either '),
                                    LSDialog.bolded(title: 'http://'),
                                    TextSpan(text: ' or '),
                                    LSDialog.bolded(title: 'https://\n'),
                                    TextSpan(text: '•\tWhen not using a reverse proxy, please include the port: '),
                                    LSDialog.bolded(title: 'url:port\n'),
                                    TextSpan(text: '•\tTo add layered authentication (Nginx, Apache, etc), use the following format: '),
                                    LSDialog.bolded(title: 'http(s)://user:pass@hostname\n'),
                                ],
                            ),
                        ),
                        Form(
                            key: _formKey,
                            child: LSDialog.textFormInput(
                                controller: _controller,
                                title: title,
                                onSubmitted: (_) => _setValues(true),
                                validator: (_) => null,
                            ),
                        ),
                    ],
                ),
                contentPadding: EdgeInsets.only(bottom: 12.0, left: 24.0, top: 20.0, right: 24.0),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<void> textPreview(BuildContext context, String title, String text, {bool alignLeft = false}) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Close',
                        onPressed: () => Navigator.of(context).pop(),
                        textColor: LSColors.accent,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(
                            text: text,
                            textAlign: alignLeft
                                ? TextAlign.left
                                : TextAlign.center,
                        ),
                    ],
                ),
                contentPadding: EdgeInsets.only(left: 24.0, top: 20.0, right: 24.0),
            ),
        );
    }

    static Future<List<dynamic>> deleteCatalogueWithFiles(BuildContext context, String title) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: title),
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
                            LSDialog.textContent(text: 'Are you sure you want to delete all the files and folders for $title?'),
                        ],
                    ),
                );
            }
        );
        return [_flag];
    }

    static Future<List<dynamic>> showBackupConfigurationPrompt(BuildContext context) async {
        //Returns
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();
        //Setter
        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: LSDialog.title(text: 'Backup Configuration'),
                    actions: <Widget>[
                        LSDialog.cancel(context),
                        LSDialog.button(
                            text: 'Backup',
                            textColor: LSColors.accent,
                            onPressed: () => _setValues(true),

                        ),
                    ],
                    content: LSDialog.content(
                        children: [
                            LSDialog.textContent(text: 'Are you sure you want to backup your current configuration?\n'),
                            LSDialog.textContent(text: 'All backups are encrypted before being exported to the filesystem, please enter an encryption key for the backup.\n'),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    children: [
                                        if(Platform.isIOS || Platform.isAndroid) LSDialog.textSpanContent(text: 'The backups can be found in '),
                                        if(Platform.isIOS) LSDialog.bolded(title: '<On My Device>/LunaSea/configurations', fontSize: 16.0),
                                        if(Platform.isAndroid) LSDialog.bolded(title: '<Storage>/Android/data/app.lunasea.lunasea/files/configurations', fontSize: 16.0),
                                        LSDialog.textSpanContent(text: '.'),
                                    ],
                                ),
                            ),
                            Form(
                                key: _formKey,
                                child: LSDialog.textFormInput(
                                    obscureText: true,
                                    controller: _textController,
                                    title: 'Encryption Key',
                                    validator: (value) {
                                        if(value.length < 8) {
                                            return 'Minimum of 8 characters';
                                        }
                                        return null;
                                    },
                                    onSubmitted: (_) => _setValues(true),
                                ),
                            ),
                        ],
                    ),
                    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 12.0),
                );
            }
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> showClearConfigurationPrompt(BuildContext context) async {
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
                    title: LSDialog.title(text: 'Reset LunaSea'),
                    actions: <Widget>[
                        LSDialog.cancel(context),
                        LSDialog.button(
                            text: 'Reset',
                            textColor: LSColors.red,
                            onPressed: () => _setValues(true),
                        ),
                    ],
                    content: LSDialog.content(
                        children: [
                            LSDialog.textContent(text: 'Are you sure you want to reset LunaSea and clear your configuration?\n'),
                            LSDialog.textContent(text: 'You will be starting from a clean slate, please ensure you backup your current configuration first!'),
                        ],
                    ),
                    contentPadding: EdgeInsets.only(left: 24.0, top: 20.0, right: 24.0),
                );
            }
        );
        return [_flag];
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
}
