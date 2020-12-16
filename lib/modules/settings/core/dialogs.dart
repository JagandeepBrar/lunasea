import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home/core.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class SettingsDialogs {
    SettingsDialogs._();

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

        await LSDialog.dialog(
            context: context,
            title: title,
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tThis is the URL in which you access the web GUI for the service\n'),
                        LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tYou must include either '),
                        LSDialog.bolded(text: 'http://'),
                        LSDialog.textSpanContent(text: ' or '),
                        LSDialog.bolded(text: 'https://\n'),
                        LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tDo not use '),
                        LSDialog.bolded(text: 'localhost'),
                        LSDialog.textSpanContent(text: ' or '),
                        LSDialog.bolded(text: '127.0.0.1\n'),
                        LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tWhen not using a reverse proxy, please include the port: '),
                        LSDialog.bolded(text: 'url:port\n'),
                        LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tTo add basic authentication, please set a custom header in the advanced section'),
                    ],
                ),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> deleteIndexer(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Indexer',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: Colors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(
                    text: 'Are you sure you want to delete this indexer?'
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteHeader(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Header',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: Colors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(
                    text: 'Are you sure you want to delete this header?'
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> addHeader(BuildContext context) async {
        List<List<dynamic>> _options = [
            ['Basic Authentication', Icons.verified_user, 1],
            ['Custom...', Icons.device_hub, 100],
        ];
        bool _flag = false;
        int _type = -1;

        void _setValues(bool flag, int type) {
            _flag = flag;
            _type = type;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Add Header',
                content: List.generate(
                    _options.length,
                    (index) => LSDialog.tile(
                        text: _options[index][0],
                        icon: _options[index][1],
                        iconColor: LunaColours.list(index),
                        onTap: () => _setValues(true, _options[index][2]),
                    ),
                ),
                contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _type];
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

        await LSDialog.dialog(
            context: context,
            title: 'Custom Header',
            buttons: [
                LSDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
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
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _key.text, _value.text];
    }

    static Future<List<dynamic>> addAuthenticationHeader(BuildContext context) async {
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

        await LSDialog.dialog(
            context: context,
            title: 'Basic Authentication',
            buttons: [
                LSDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: '•\tThe username '),
                        LSDialog.bolded(text: 'cannot'),
                        LSDialog.textSpanContent(text: ' contain a colon\n'),
                        LSDialog.textSpanContent(text: '•\tThe password '),
                        LSDialog.bolded(text: 'can'),
                        LSDialog.textSpanContent(text: ' contain a colon\n'),
                        LSDialog.textSpanContent(text: '•\tThe username and password are automatically converted to base64 encoding\n'),
                    ]
                ),
                Form(
                    key: _formKey,
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _username.text, _password.text];
    }

    static Future<List<dynamic>> clearLogs(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Clear Logs',
            buttons: [
                LSDialog.button(
                    text: 'Clear',
                    onPressed: () => _setValues(true),
                    textColor: LunaColours.red,
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to clear all recorded logs?\n'),
                LSDialog.textContent(text: 'Logs can be useful for bug reports and debugging.'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> addProfile(BuildContext context) async {
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController();
        bool _flag = false;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Add Profile',
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
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
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _controller.text];
    }

    static Future<List<dynamic>> renameProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Rename Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _profile];
    }

    static Future<List<dynamic>> renameProfileSelected(BuildContext context) async {
        final _formKey = GlobalKey<FormState>();
        final _controller = TextEditingController();
        bool _flag = false;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Rename Profile',
            buttons: [
                LSDialog.button(text: 'Rename', onPressed: () => _setValues(true), textColor: LunaColours.accent),
            ],
            content: [
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
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _controller.text];
    }

    static Future<List<dynamic>> deleteProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _profile];
    }

    static Future<List<dynamic>> enabledProfile(BuildContext context, List<String> profiles) async {
        bool _flag = false;
        String _profile = '';

        void _setValues(bool flag, String profile) {
            _flag = flag;
            _profile = profile;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Enabled Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    icon: Icons.settings,
                    iconColor: LunaColours.list(index),
                    text: profiles[index],
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _profile];
    }

    static Future<List<dynamic>> changeBrowser(BuildContext context) async {
        bool _flag = false;
        LSBrowsers _browser;

        void _setValues(bool flag, LSBrowsers browser) {
            _flag = flag;
            _browser = browser;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Open Links In...',
            content: List.generate(
                LSBrowsers.values.length,
                (index) => LSDialog.tile(
                    icon: LSBrowsers.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: LSBrowsers.values[index].name,
                    onTap: () => _setValues(true, LSBrowsers.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _browser];
    }

    static Future<List<dynamic>> editCalendarStartingDay(BuildContext context) async {
        bool _flag = false;
        CalendarStartingDay _startingDate;

        void _setValues(bool flag, CalendarStartingDay startingDate) {
            _flag = flag;
            _startingDate = startingDate;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Starting Day',
            content: List.generate(
                CalendarStartingDay.values.length,
                (index) => LSDialog.tile(
                    icon: CustomIcons.calendar,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingDay.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingDay.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
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

        await LSDialog.dialog(
            context: context,
            title: 'Starting Size',
            content: List.generate(
                CalendarStartingSize.values.length,
                (index) => LSDialog.tile(
                    icon: CalendarStartingSize.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingSize.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingSize.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
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

        await LSDialog.dialog(
            context: context,
            title: 'Starting Type',
            content: List.generate(
                CalendarStartingType.values.length,
                (index) => LSDialog.tile(
                    icon: CalendarStartingType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    text: CalendarStartingType.values[index].name,
                    onTap: () => _setValues(true, CalendarStartingType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
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

        await LSDialog.dialog(
            context: context,
            title: 'Broadcast Address',
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: '•\tThis is the broadcast address of your local network\n'),
                        LSDialog.textSpanContent(text: '•\tTypically this is the IP address of your machine with the last octet set to 255\n'),
                        LSDialog.textSpanContent(text: '•\tGiven an example machine IP address of 192.168.1.111, the resulting broadcast IP address is '),
                        LSDialog.bolded(text: '192.168.1.255'),
                    ],
                ),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _controller,
                        validator: (address) => IPv4Address.validate(address)
                            ? null
                            : 'Invalid Broadcast Address',
                        onSubmitted: (_) => _setValues(true),
                        title: 'Broadcast Address',
                    ),
                ),
            ],
            contentPadding: LSDialog.inputTextDialogContentPadding(),
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

        await LSDialog.dialog(
            context: context,
            title: 'MAC Address',
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: '•\tThis is the MAC address of the machine that you want to wake up\n'),
                        LSDialog.textSpanContent(text: '•\tMAC addresses contain six two-digit hexidecimal nibbles (an octet)\n'),
                        LSDialog.textSpanContent(text: '•\tHexidecimal digits range from 0-9 and A-F\n'),
                        LSDialog.textSpanContent(text: '•\tEach hexidecimal octet should be separated by a colon\n'),
                        LSDialog.textSpanContent(text: '•\tExample: '),
                        LSDialog.bolded(text: 'A4:83:E7:0D:7F:4F'),
                    ],
                ),
                Form(
                    key: formKey,
                    child: LSDialog.textFormInput(
                        controller: _controller,
                        validator: (address) => MACAddress.validate(address)
                            ? null
                            : 'Invalid MAC Address',
                        onSubmitted: (_) => _setValues(true),
                        title: 'MAC Address',
                    ),
                ),
            ],
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _controller.text];
    }

    static Future<List<dynamic>> clearConfiguration(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();   
        }

        await LSDialog.dialog(
            context: context,
            title: 'Reset Configuration',
            buttons: [
                LSDialog.button(
                    text: 'Reset',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to clear your configuration?\n'),
                LSDialog.textContent(text: 'You will be starting from a clean slate, please ensure you backup your current configuration first!'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
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

        await LSDialog.dialog(
            context: context,
            title: 'Decrypt Backup',
            buttons: [
                LSDialog.button(
                    text: 'Restore',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
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

        await LSDialog.dialog(
            context: context,
            title: 'Backup Configuration',
            buttons: [
                LSDialog.button(
                    text: 'Backup',
                    textColor: LunaColours.accent,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: '•\tAll backups are encrypted before being exported to the filesystem\n'),
                        LSDialog.textSpanContent(text: '•\tThe encryption key must be at least 8 characters'),
                    ],
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> disableSentryWarning(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Sentry',
            buttons: [
                LSDialog.button(
                    text: 'Website',
                    onPressed: () => Constants.URL_SENTRY.lsLinks_OpenLink(),
                    textColor: LunaColours.accent,
                ),
                LSDialog.button(
                    text: 'Disable',
                    onPressed: () => _setValues(true),
                    textColor: LunaColours.red,
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.bolded(
                            text: 'Errors and stacktraces contain absolutely no identifying information on any users.\n\n',
                            color: LunaColours.red,
                            fontSize: LSDialog.SUBBODY_SIZE,
                        ),
                        LSDialog.textSpanContent(text: 'Sentry is an open-source platform used for capturing crashes and errors.\n\n'),
                        LSDialog.textSpanContent(text: 'To reserve your right to privacy, I have added the option to disable Sentry error tracking, but please know that these errors and stacktraces are incredibly useful for catching and pinpointing bugs!\n\n'),
                        LSDialog.bolded(
                            text: 'A link to their website is available below for more information to help make an informed decision.',
                            color: LunaColours.accent,
                            fontSize: LSDialog.SUBBODY_SIZE,
                        ),
                    ],
                    alignment: TextAlign.center,
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> changeBackgroundImageOpacity(BuildContext context) async {
        bool _flag = false;
        int _opacity = 0;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data.toString();

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

        await LSDialog.dialog(
            context: context,
            title: 'Image Background Opacity',
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Set the opacity of background images.\n\nTo completely disable fetching background images, set the value to 0.'),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _opacity];
    }

    static Future<void> helpMessage(BuildContext context, { @required String title, @required String message, String website, String github }) async {
        await LSDialog.dialog(
            context: context,
            title: title ?? Constants.TEXT_EMDASH,
            buttons: ((github?.isNotEmpty ?? false) || (website?.isNotEmpty ?? false))
                ? [
                    if(github?.isNotEmpty ?? false) LSDialog.button(text: 'GitHub', onPressed: () async => github.lsLinks_OpenLink()),
                    if(website?.isNotEmpty ?? false) LSDialog.button(text: 'Website', textColor: LunaColours.orange, onPressed: () async => website.lsLinks_OpenLink()),
                ] : null,
            content: [LSDialog.textContent(text: message)],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
    }
}
