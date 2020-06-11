import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

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
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> deleteHeader(BuildContext context) async {
        //Returns
        bool _flag = false;
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Header'),
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
                            text: 'Are you sure you want to delete this header?'
                        ),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> addHeader(BuildContext context) async {
        //Returns
        bool _flag = false;
        int _type = -1;
        //Setter
        void _setValues(bool flag, int type) {
            _flag = flag;
            _type = type;
            Navigator.of(context).pop();
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Add Header'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.tile(
                            icon: Icons.verified_user,
                            iconColor: LSColors.list(0),
                            text: 'Basic Authentication',
                            onTap: () => _setValues(true, 1),
                        ),
                        LSDialog.tile(
                            icon: Icons.device_hub,
                            iconColor: LSColors.list(1),
                            text: 'Custom...',
                            onTap: () => _setValues(true, 100),
                        ),
                    ],
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _type];
    }

    static Future<List> addCustomHeader(BuildContext context) async {
        //Returns
        bool _flag = false;
        final formKey = GlobalKey<FormState>();
        TextEditingController _key = TextEditingController();
        TextEditingController _value = TextEditingController();
        //Setter
        void _setValues(bool flag) {
            if(formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Custom Header'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Add',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.accent,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        Form(
                            key: formKey,
                            child: Column(
                                children: [
                                    LSDialog.textFormInput(
                                        controller: _key,
                                        validator: (key) => key.length > 0 ? null : 'Key Required',
                                        onSubmitted: (_) => _setValues(true),
                                        title: 'Header Key',
                                    ),
                                    LSDialog.textFormInput(
                                        controller: _value,
                                        validator: (value) => value.length > 0 ? null : 'Value Required',
                                        onSubmitted: (_) => _setValues(true),
                                        title: 'Header Value',
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _key.text, _value.text];
    }

    static Future<List> addAuthenticationHeader(BuildContext context) async {
        //Returns
        bool _flag = false;
        final formKey = GlobalKey<FormState>();
        TextEditingController _username = TextEditingController();
        TextEditingController _password = TextEditingController();
        //Setter
        void _setValues(bool flag) {
            if(formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Basic Authentication'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Add',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.accent,
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.white70),
                                children: [
                                    TextSpan(text: '•\tThe username and/or password cannot contain a colon\n'),
                                    TextSpan(text: '•\tThe username and password are automatically converted to base64 encoding\n'),
                                ],
                            ),
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                                children: [
                                    LSDialog.textFormInput(
                                        controller: _username,
                                        validator: (username) => username.length > 0 ? null : 'Username Required',
                                        onSubmitted: (_) => _setValues(true),
                                        title: 'Username',
                                    ),
                                    LSDialog.textFormInput(
                                        controller: _password,
                                        validator: (password) => password.length > 0 ? null : 'Password Required',
                                        onSubmitted: (_) => _setValues(true),
                                        obscureText: true,
                                        title: 'Password',
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _username.text, _password.text];
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
                                    if(Platform.isIOS || Platform.isAndroid) LSDialog.textSpanContent(text: 'The exported logs can be found in '),
                                    if(Platform.isIOS) LSDialog.bolded(title: '<On My Device>/LunaSea/FLogs', fontSize: 16.0),
                                    if(Platform.isAndroid) LSDialog.bolded(title: '<Storage>/Android/data/app.lunasea.lunasea/files/FLogs', fontSize: 16.0),
                                    LSDialog.textSpanContent(text: '.'),
                                ],
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
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
                contentPadding: LSDialog.textDialogContentPadding(),
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
                                title: 'Please do not modify this setting unless you know what you are doing.\n\n',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                            LSDialog.textSpanContent(text: 'Are you sure you want to disable strict SSL/TLS validation?\n\n'),
                            LSDialog.textSpanContent(text: 'Disabling strict SSL/TLS validation means that LunaSea will not validate the host machine\'s SSL certificate against a certificate authority.\n\n'),
                            LSDialog.textSpanContent(text: 'LunaSea will still connect to your host machine securely when using SSL/TLS whether strict SSL/TLS validation is enabled or disabled.\n\n'),
                            LSDialog.bolded(
                                title: 'Warning: Disabling strict SSL/TLS for an invalid or self-signed certificate will prevent a large amount of images from loading within LunaSea.',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                        ],
                    ),
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> nzbgetBasicAuthentication(BuildContext context) async {
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
                title: LSDialog.title(text: 'Use Basic Authentication'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Use',
                        onPressed: () => _setValues(true),
                        textColor: LSColors.red,
                    ),
                ],
                content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                            LSDialog.bolded(
                                title: 'Please do not modify this setting unless you know what you are doing.\n\n',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                            LSDialog.textSpanContent(text: 'Are you sure you want to use basic authentication?\n\n'),
                            LSDialog.textSpanContent(text: 'Basic authentication will add your username and password as a header in the request instead of in the URL.\n\n'),
                            LSDialog.bolded(
                                title: 'Warning: This will allow you to have more complex passwords, but interfere with layered authentication methods.',
                                color: LSColors.red,
                                fontSize: 12.0,
                            ),
                        ],
                    ),
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> addProfile(BuildContext context) async {
        //Returns
        final _formKey = GlobalKey<FormState>();
        TextEditingController _controller = TextEditingController();
        bool _flag = false;
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
                        Form(
                            key: _formKey,
                            child: LSDialog.textFormInput(
                                controller: _controller,
                                validator: (value) => value.length > 0 ? null : 'Name Required',
                                onSubmitted: (_) => _setValues(true),
                                title: 'Profile Name',
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
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
                title: LSDialog.title(text: 'Rename Profile'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        profiles.length,
                        (index) => LSDialog.tile(
                            icon: Icons.settings,
                            iconColor: LSColors.list(index),
                            text: profiles[index],
                            onTap: () => _setValues(true, profiles[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _profile];
    }

    static Future<List> renameProfileSelected(BuildContext context) async {
        //Returns
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController();
        bool _flag = false;
        //Setters
        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
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
                        Form(
                            key: _formKey,
                            child:LSDialog.textFormInput(
                                controller: _controller,
                                validator: (value) => value.length > 0 ? null : 'Name Required',
                                onSubmitted: (_) => _setValues(true),
                                title: 'New Profile Name',
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
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
                        (index) => LSDialog.tile(
                            icon: Icons.settings,
                            iconColor: LSColors.list(index),
                            text: profiles[index],
                            onTap: () => _setValues(true, profiles[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _profile];
    }

    static Future<List> enabledProfile(BuildContext context, List<String> profiles) async {
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
                        (index) => LSDialog.tile(
                            icon: Icons.settings,
                            iconColor: LSColors.list(index),
                            text: profiles[index],
                            onTap: () => _setValues(true, profiles[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _profile];
    }

    static Future<List> changeBrowser(BuildContext context) async {
        //Returns
        bool _flag = false;
        LSBrowsers _browser;
        //Setter
        void _setValues(bool flag, LSBrowsers browser) {
            _flag = flag;
            _browser = browser;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Open Links In...'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        LSBrowsers.values.length,
                        (index) => LSDialog.tile(
                            icon: LSBrowsers.values[index].icon,
                            iconColor: LSColors.list(index),
                            text: LSBrowsers.values[index].name,
                            onTap: () => _setValues(true, LSBrowsers.values[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _browser];
    }

    static Future<List> editCalendarStartingDay(BuildContext context) async {
        //Returns
        bool _flag = false;
        CalendarStartingDay _startingDate;
        //Setter
        void _setValues(bool flag, CalendarStartingDay startingDate) {
            _flag = flag;
            _startingDate = startingDate;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Starting Day of Week'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        CalendarStartingDay.values.length,
                        (index) => LSDialog.tile(
                            icon: CustomIcons.calendar,
                            iconColor: LSColors.list(index),
                            text: CalendarStartingDay.values[index].name,
                            onTap: () => _setValues(true, CalendarStartingDay.values[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _startingDate];
    }

    static Future<List> editCalendarStartingSize(BuildContext context) async {
        //Returns
        bool _flag = false;
        CalendarStartingSize _startingSize;
        //Setter
        void _setValues(bool flag, CalendarStartingSize startingSize) {
            _flag = flag;
            _startingSize = startingSize;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'Starting Size'),
                actions: <Widget>[
                    LSDialog.cancel(context, textColor: LSColors.accent),
                ],
                content: LSDialog.content(
                    children: List.generate(
                        CalendarStartingSize.values.length,
                        (index) => LSDialog.tile(
                            icon: CalendarStartingSize.values[index].icon,
                            iconColor: LSColors.list(index),
                            text: CalendarStartingSize.values[index].name,
                            onTap: () => _setValues(true, CalendarStartingSize.values[index]),
                        ),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
            ),
        );
        return [_flag, _startingSize];
    }

    static Future<List> editBroadcastAddress(BuildContext context, String prefill) async {
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
                title: LSDialog.title(text: 'Broadcast Address'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Save',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.white70),
                                children: [
                                    TextSpan(text: '•\tThis is the broadcast address of your local network\n'),
                                    TextSpan(text: '•\tTypically this is the IP address of your machine with the last octet set to 255\n'),
                                    TextSpan(text: '•\tGiven an example machine IP address of 192.168.1.111, the resulting broadcast IP address is '),
                                    LSDialog.bolded(title: '192.168.1.255'),
                                ],
                            ),
                        ),
                        Form(
                            key: _formKey,
                            child: LSDialog.textFormInput(
                                controller: _controller,
                                validator: (value) => null,
                                onSubmitted: (_) => _setValues(true),
                                title: 'Broadcast Address',
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<List> editMACAddress(BuildContext context, String prefill) async {
        //Returns
        bool _flag = false;
        final formKey = GlobalKey<FormState>();
        TextEditingController _controller = TextEditingController()..text = prefill;
        //Setter
        void _setValues(bool flag) {
            if(formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: 'MAC Address'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Save',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.white70),
                                children: [
                                    TextSpan(text: '•\tThis is the MAC address of the machine that you want to wake up\n'),
                                    TextSpan(text: '•\tMAC addresses contain six two-digit hexidecimal nibbles (an octet)\n'),
                                    TextSpan(text: '•\tHexidecimal digits range from 0-9 and A-F\n'),
                                    TextSpan(text: '•\tEach hexidecimal octet should be separated by a colon\n'),
                                    TextSpan(text: '•\tExample: '),
                                    LSDialog.bolded(title: 'A4:83:E7:0D:7F:4F'),
                                ],
                            ),
                        ),
                        Form(
                            key: formKey,
                            child: LSDialog.textFormInput(
                                controller: _controller,
                                validator: (address) => MacAddress.validate(address)
                                    ? null
                                    : 'Invalid MAC Address',
                                onSubmitted: (_) => _setValues(true),
                                title: 'MAC Address',
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<List> clearLunaSeaConfiguration(BuildContext context) async {
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
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }

    static Future<List> enterEncryptionKey(BuildContext context) async {
        //Returns
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();
        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Alert
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Decrypt Backup'),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Restore',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Please enter the encryption key for this backup.'),
                        Form(
                            key: _formKey,
                            child: LSDialog.textFormInput(
                                controller: _textController,
                                title: 'Encryption Key',
                                obscureText: true,
                                onSubmitted: (_) => _setValues(true),
                                validator: (value) => value.length < 8
                                    ? 'Minimum of 8 characters'
                                    : null,
                            ),
                        ),
                    ],
                ),
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _textController.text];
    }

    static Future<List> backupConfiguration(BuildContext context) async {
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
            builder: (BuildContext context) => AlertDialog(
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
                contentPadding: LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _textController.text];
    }
}
