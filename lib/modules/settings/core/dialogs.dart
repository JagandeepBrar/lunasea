import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:tuple/tuple.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class SettingsDialogs {
    Future<bool> confirmAccountSignOut(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Sign Out',
            buttons: [
                LunaDialog.button(
                    text: 'Sign Out',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(
                    text: 'Are you sure you want to sign out of your LunaSea account?'
                ),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    static Future<List<dynamic>> getBackupFromCloud(BuildContext context, List<LunaFirebaseBackupDocument> backups) async {
        bool _flag = false;
        LunaFirebaseBackupDocument _document;

        void _setValues(bool flag, LunaFirebaseBackupDocument document) {
            _flag = flag;
            _document = document;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Backup List',
            content: backups.length > 0
                ? List.generate(
                    backups.length,
                    (index) => LunaDialog.tile(
                        icon: Icons.file_copy,
                        iconColor: LunaColours.list(index),
                        text: backups[index].title.toString(),
                        onTap: () => _setValues(true, backups[index]),
                    ),
                )
                : [LunaDialog.textContent(text: 'No Backups Found')],
            contentPadding: backups.length > 0 ? LunaDialog.listDialogContentPadding() : LunaDialog.textDialogContentPadding(),
        );
        return [_flag, _document];
    }

    static Future<List<dynamic>> editHost(BuildContext context, String title, { String prefill = '' }) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = prefill;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: title,
            buttons: [
                LunaDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tThis is the URL in which you access the web GUI for the service\n'),
                        LunaDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tYou must include either '),
                        LunaDialog.bolded(text: 'http://'),
                        LunaDialog.textSpanContent(text: ' or '),
                        LunaDialog.bolded(text: 'https://\n'),
                        LunaDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tDo not use '),
                        LunaDialog.bolded(text: 'localhost'),
                        LunaDialog.textSpanContent(text: ' or '),
                        LunaDialog.bolded(text: '127.0.0.1\n'),
                        LunaDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tWhen not using a reverse proxy, please include the port: '),
                        LunaDialog.bolded(text: 'url:port\n'),
                        LunaDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tTo add basic authentication, please set a custom header in the advanced section'),
                    ],
                ),
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
                        controller: _textController,
                        title: title,
                        keyboardType: TextInputType.url,
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            // Allow empty value
                            if(value == '') return null;
                            // Test for https:// or http://
                            RegExp exp = RegExp(r"^(http|https)://", caseSensitive: false);
                            if(exp.hasMatch(value)) return null;
                            return 'Host must include http:// or https://';
                        },
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> deleteIndexer(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Delete Indexer',
            buttons: [
                LunaDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(
                    text: 'Are you sure you want to delete this indexer?'
                ),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteHeader(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Delete Header',
            buttons: [
                LunaDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(
                    text: 'Are you sure you want to delete this header?'
                ),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    Future<Tuple2<bool, HeaderType>> addHeader(BuildContext context) async {
        bool _flag = false;
        HeaderType _type;

        void _setValues(bool flag, HeaderType type) {
            _flag = flag;
            _type = type;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Add Header',
                content: List.generate(
                    HeaderType.values.length,
                    (index) => LunaDialog.tile(
                        text: HeaderType.values[index].name,
                        icon: HeaderType.values[index].icon,
                        iconColor: LunaColours.list(index),
                        onTap: () => _setValues(true, HeaderType.values[index]),
                    ),
                ),
                contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _type);
    }

    static Future<List<dynamic>> addCustomHeader(BuildContext context) async {
        bool _flag = false;
        final formKey = GlobalKey<FormState>();
        TextEditingController _key = TextEditingController();
        TextEditingController _value = TextEditingController();

        void _setValues(bool flag) {
            if(formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Custom Header',
            buttons: [
                LunaDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: formKey,
                    child: Column(
                        children: [
                            LunaDialog.textFormInput(
                                controller: _key,
                                validator: (key) => key.length > 0 ? null : 'Key Required',
                                onSubmitted: (_) => _setValues(true),
                                title: 'Header Key',
                            ),
                            LunaDialog.textFormInput(
                                controller: _value,
                                validator: (value) => value.length > 0 ? null : 'Value Required',
                                onSubmitted: (_) => _setValues(true),
                                title: 'Header Value',
                            ),
                        ],
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputDialogContentPadding(),
        );
        return [_flag, _key.text, _value.text];
    }

    static Future<List<dynamic>> addBasicAuthenticationHeader(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _username = TextEditingController();
        final _password = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Basic Authentication',
            buttons: [
                LunaDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.textSpanContent(text: '•\tThe username '),
                        LunaDialog.bolded(text: 'cannot'),
                        LunaDialog.textSpanContent(text: ' contain a colon\n'),
                        LunaDialog.textSpanContent(text: '•\tThe password '),
                        LunaDialog.bolded(text: 'can'),
                        LunaDialog.textSpanContent(text: ' contain a colon\n'),
                        LunaDialog.textSpanContent(text: '•\tThe username and password are automatically converted to base64 encoding\n'),
                    ]
                ),
                Form(
                    key: _formKey,
                    child: Column(
                        children: [
                            LunaDialog.textFormInput(
                                controller: _username,
                                validator: (username) => username.length > 0 ? null : 'Username Required',
                                onSubmitted: (_) => _setValues(true),
                                title: 'Username',
                            ),
                            LunaDialog.textFormInput(
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
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _username.text, _password.text];
    }

    Future<bool> clearLogs(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Clear Logs',
            buttons: [
                LunaDialog.button(
                    text: 'Clear',
                    onPressed: () => _setValues(true),
                    textColor: LunaColours.red,
                ),
            ],
            content: [
                LunaDialog.textContent(text: 'Are you sure you want to clear all recorded logs?\n'),
                LunaDialog.textContent(text: 'Logs can be useful for bug reports and debugging.'),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    Future<Tuple2<bool, String>> addProfile(BuildContext context, List<String> profiles) async {
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController();
        bool _flag = false;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Add Profile',
            buttons: [
                LunaDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
                        controller: _controller,
                        validator: (value) {
                            if(profiles.contains(value)) return 'Profile Already Exists';
                            if(value.length == 0) return 'Profile Name Required';
                            return null;
                        },
                        onSubmitted: (_) => _setValues(true),
                        title: 'Profile Name',
                    ),
                ),
            ],    
            contentPadding: LunaDialog.inputDialogContentPadding(),
        );
        return Tuple2(_flag, _controller.text);
    }

    Future<Tuple2<bool, String>> renameProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Rename Profile',
            content: List.generate(
                profiles.length,
                (index) => LunaDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _profile);
    }

    Future<Tuple2<bool, String>> renameProfileSelected(BuildContext context, List<String> profiles) async {
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController();
        bool _flag = false;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Rename Profile',
            buttons: [
                LunaDialog.button(text: 'Rename', onPressed: () => _setValues(true), textColor: LunaColours.accent),
            ],
            content: [
                Form(
                    key: _formKey,
                    child:LunaDialog.textFormInput(
                        controller: _controller,
                        validator: (value) {
                            if(profiles.contains(value)) return 'Profile Already Exists';
                            if(value.length == 0) return 'Profile Name Required';
                            return null;
                        },
                        onSubmitted: (_) => _setValues(true),
                        title: 'New Profile Name',
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputDialogContentPadding(),
        );
        return Tuple2(_flag, _controller.text);
    }

    Future<Tuple2<bool, String>> deleteProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Delete Profile',
            content: List.generate(
                profiles.length,
                (index) => LunaDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _profile);
    }

    static Future<List<dynamic>> enabledProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Enabled Profile',
            content: List.generate(
                profiles.length,
                (index) => LunaDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return [_flag, _profile];
    }

    Future<Tuple2<bool, LunaBrowser>> changeBrowser(BuildContext context) async {
        bool _flag = false;
        LunaBrowser _browser;

        void _setValues(bool flag, LunaBrowser browser) {
            _flag = flag;
            _browser = browser;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Open Links In...',
            content: List.generate(
                LunaBrowser.values.length,
                (index) => LunaDialog.tile(
                    icon: LunaBrowser.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: LunaBrowser.values[index].name,
                    onTap: () => _setValues(true, LunaBrowser.values[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _browser);
    }

    Future<Tuple2<bool, LunaLanguage>> changeLanguage(BuildContext context) async {
        List<LunaLanguage> languages = LunaLocalization().supportedLanguages;
        bool _flag = false;
        LunaLanguage _language;

        void _setValues(bool flag, LunaLanguage language) {
            _flag = flag;
            _language = language;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Language',
            content: List.generate(
                languages.length,
                (index) => LunaDialog.tile(
                    icon: Icons.language_rounded,
                    iconColor: LunaColours.list(index),
                    text: languages[index].name,
                    onTap: () => _setValues(true, languages[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _language);
    }

    static Future<List<dynamic>> editCalendarStartingDay(BuildContext context) async {
        bool _flag = false;
        CalendarStartingDay _startingDate;

        void _setValues(bool flag, CalendarStartingDay startingDate) {
            _flag = flag;
            _startingDate = startingDate;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Starting Day',
            content: List.generate(
                CalendarStartingDay.values.length,
                (index) => LunaDialog.tile(
                    icon: LunaIcons.calendar,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingDay.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingDay.values[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return [_flag, _startingDate];
    }

    static Future<List<dynamic>> editCalendarStartingSize(BuildContext context) async {
        bool _flag = false;
        CalendarStartingSize _startingSize;

        void _setValues(bool flag, CalendarStartingSize startingSize) {
            _flag = flag;
            _startingSize = startingSize;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Starting Size',
            content: List.generate(
                CalendarStartingSize.values.length,
                (index) => LunaDialog.tile(
                    icon: CalendarStartingSize.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingSize.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingSize.values[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return [_flag, _startingSize];
    }

    static Future<List<dynamic>> editCalendarStartingType(BuildContext context) async {
        bool _flag = false;
        CalendarStartingType _startingType;

        void _setValues(bool flag, CalendarStartingType startingType) {
            _flag = flag;
            _startingType = startingType;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Starting Type',
            content: List.generate(
                CalendarStartingType.values.length,
                (index) => LunaDialog.tile(
                    icon: CalendarStartingType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingType.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingType.values[index]),
                ),
            ),
            contentPadding: LunaDialog.listDialogContentPadding(),
        );
        return [_flag, _startingType];
    }

    static Future<List<dynamic>> editBroadcastAddress(BuildContext context, String prefill) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController()..text = prefill;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Broadcast Address',
            buttons: [
                LunaDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.textSpanContent(text: '•\tThis is the broadcast address of your local network\n'),
                        LunaDialog.textSpanContent(text: '•\tTypically this is the IP address of your machine with the last octet set to 255\n'),
                        LunaDialog.textSpanContent(text: '•\tGiven an example machine IP address of 192.168.1.111, the resulting broadcast IP address is '),
                        LunaDialog.bolded(text: '192.168.1.255'),
                    ],
                ),
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
                        controller: _controller,
                        validator: (address) {
                            if(address.isEmpty) return null;
                            return IPv4Address.validate(address) ? null : 'Invalid Broadcast Address';
                        },
                        onSubmitted: (_) => _setValues(true),
                        title: 'Broadcast Address',
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _controller.text];
    }

    static Future<List<dynamic>> editMACAddress(BuildContext context, String prefill) async {
        bool _flag = false;
        final formKey = GlobalKey<FormState>();
        final _controller = TextEditingController()..text = prefill;

        void _setValues(bool flag) {
            if(formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'MAC Address',
            buttons: [
                LunaDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.textSpanContent(text: '•\tThis is the MAC address of the machine that you want to wake up\n'),
                        LunaDialog.textSpanContent(text: '•\tMAC addresses contain six two-digit hexidecimal nibbles (an octet)\n'),
                        LunaDialog.textSpanContent(text: '•\tHexidecimal digits range from 0-9 and A-F\n'),
                        LunaDialog.textSpanContent(text: '•\tEach hexidecimal octet should be separated by a colon\n'),
                        LunaDialog.textSpanContent(text: '•\tExample: '),
                        LunaDialog.bolded(text: 'A4:83:E7:0D:7F:4F'),
                    ],
                ),
                Form(
                    key: formKey,
                    child: LunaDialog.textFormInput(
                        controller: _controller,
                        validator: (address) {
                            if(address.isEmpty) return null;
                            return MACAddress.validate(address) ? null : 'Invalid MAC Address';
                        },
                        onSubmitted: (_) => _setValues(true),
                        title: 'MAC Address',
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _controller.text];
    }

    Future<bool> clearConfiguration(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();   
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Reset Configuration',
            buttons: [
                LunaDialog.button(
                    text: 'Reset',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(text: 'Are you sure you want to clear your configuration?\n'),
                LunaDialog.textContent(text: 'You will be starting from a clean slate, please ensure you backup your current configuration first!\n'),
                LunaDialog.textContent(text: 'If you are signed into a LunaSea account, you will be signed out.'),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    static Future<List<dynamic>> enterEncryptionKey(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Decrypt Backup',
            buttons: [
                LunaDialog.button(
                    text: 'Restore',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(text: 'Please enter the encryption key for this backup.'),
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
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
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> backupConfiguration(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Backup Configuration',
            buttons: [
                LunaDialog.button(
                    text: 'Backup',
                    textColor: LunaColours.accent,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.textSpanContent(text: '•\tAll backups are encrypted before being exported\n'),
                        LunaDialog.textSpanContent(text: '•\tThe encryption key must be at least 8 characters'),
                    ],
                ),
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
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
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    Future<bool> disableCrashlyticsWarning(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Firebase Crashlytics',
            buttons: [
                LunaDialog.button(
                    text: 'Website',
                    onPressed: LunaLinks.CRASHLYTICS.launch,
                    textColor: LunaColours.accent,
                ),
                LunaDialog.button(
                    text: 'Disable',
                    onPressed: () => _setValues(true),
                    textColor: LunaColours.red,
                ),
            ],
            content: [
                LunaDialog.richText(
                    children: [
                        LunaDialog.bolded(
                            text: 'Errors and stacktraces contain absolutely no identifying information on any users.\n\n',
                            color: LunaColours.red,
                            fontSize: LunaDialog.SUBBODY_SIZE,
                        ),
                        LunaDialog.textSpanContent(text: 'Firebase Crashlytics is a tool used for capturing crashes and errors.\n\n'),
                        LunaDialog.textSpanContent(text: 'To reserve your right to privacy, you have the option to disable error and crash tracking, but please know that these errors and stacktraces are incredibly useful for catching and pinpointing bugs!\n\n'),
                        LunaDialog.textSpanContent(text: 'A link to the Firebase website is available below for more information to help make an informed decision.\n\n'),
                        LunaDialog.bolded(
                            text: 'A restart of LunaSea is required for the changes to take effect.',
                            color: LunaColours.accent,
                            fontSize: LunaDialog.SUBBODY_SIZE,
                        ),
                    ],
                    alignment: TextAlign.center,
                ),
            ],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    Future<Tuple2<bool, int>> changeBackgroundImageOpacity(BuildContext context) async {
        bool _flag = false;
        int _opacity = 0;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data.toString();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _opacity = int.tryParse(_textController.text);
                if(_opacity != null) {
                    _flag = flag;
                    Navigator.of(context, rootNavigator: true).pop();
                } else {
                    LunaLogger().warning(
                        'SettingsDialogs',
                        'changeBackgroundImageOpacity',
                        'Opacity passed validation but failed int.tryParse: ${_textController.text}',
                    );
                }
            }
        }

        await LunaDialog.dialog(
            context: context,
            title: 'Image Background Opacity',
            buttons: [
                LunaDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LunaDialog.textContent(text: 'Set the opacity of background images.\n\nTo completely disable fetching background images, set the value to 0.'),
                Form(
                    key: _formKey,
                    child: LunaDialog.textFormInput(
                        controller: _textController,
                        title: 'Background Image Opacity',
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            int _opacity = int.tryParse(value);
                            if(_opacity == null || _opacity < 0 || _opacity > 100)
                                return 'Must be a value between 0 and 100';
                            return null;
                        },
                    ),
                ),
            ],
            contentPadding: LunaDialog.inputTextDialogContentPadding(),
        );
        return Tuple2(_flag, _opacity);
    }

    Future<void> moduleInformation(BuildContext context, LunaModule module) async {
        List<Widget> _buttons = [
            if(module.github?.isNotEmpty ?? false) LunaDialog.button(
                text: 'GitHub',
                onPressed: () async => module.github.lunaOpenGenericLink(),
            ),
            if(module.website?.isNotEmpty ?? false) LunaDialog.button(
                text: 'Website',
                textColor: LunaColours.orange,
                onPressed: () async => module.website.lunaOpenGenericLink(),
            ),
        ];
        await LunaDialog.dialog(
            context: context,
            title: module.name ?? LunaUI.TEXT_EMDASH,
            buttons: _buttons.length == 0 ? null : _buttons,
            content: [LunaDialog.textContent(text: module.information ?? LunaUI.TEXT_EMDASH)],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
    }

    static Future<void> helpMessage(BuildContext context, { @required String title, @required String message, String website, String github }) async {
        await LunaDialog.dialog(
            context: context,
            title: title ?? LunaUI.TEXT_EMDASH,
            buttons: ((github?.isNotEmpty ?? false) || (website?.isNotEmpty ?? false))
                ? [
                    if(github?.isNotEmpty ?? false) LunaDialog.button(text: 'GitHub', onPressed: () async => github.lunaOpenGenericLink()),
                    if(website?.isNotEmpty ?? false) LunaDialog.button(text: 'Website', textColor: LunaColours.orange, onPressed: () async => website.lunaOpenGenericLink()),
                ] : null,
            content: [LunaDialog.textContent(text: message)],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
    }

    Future<void> accountHelpMessage(BuildContext context) async {
        await LunaDialog.dialog(
            context: context,
            title: 'LunaSea Account',
            buttons: [
                if(LunaFirebaseAuth().isSignedIn) LunaDialog.button(
                    text: 'User ID',
                    onPressed: () async {
                        if(!LunaFirebaseAuth().isSignedIn) return;
                        String userId = LunaFirebaseAuth().uid;
                        await Clipboard.setData(ClipboardData(text: userId));
                        showLunaInfoSnackBar(
                            title: 'Copied User ID',
                            message: 'Copied your user ID to the clipboard',
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                    },
                ),
                LunaDialog.button(
                    text: 'Device ID',
                    onPressed: () async {
                        String deviceId = await LunaFirebaseMessaging().token;
                        await Clipboard.setData(ClipboardData(text: deviceId));
                        showLunaInfoSnackBar(
                            title: 'Copied Device ID',
                            message: 'Copied your device ID to the clipboard',
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                    },
                ),
            ],
            content: [LunaDialog.textContent(text: 'LunaSea offers a free account to backup your configuration to the cloud, with additional features coming in the future!')],
            contentPadding: LunaDialog.textDialogContentPadding(),
        );
    }
}
