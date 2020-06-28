import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetDialogs {
    NZBGetDialogs._();

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        List<List<dynamic>> _options = [
            ['View Web GUI', Icons.language, 'web_gui'],
            ['Add NZB', Icons.add, 'add_nzb'],
            ['Sort Queue', Icons.sort, 'sort'],
            ['Status & Statistics', Icons.info_outline, 'server_details'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'NZBGet Settings',
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> queueSettings(BuildContext context, String title, bool isPaused) async {
        List<List<dynamic>> _options = [
            isPaused
                ? ['Resume Job', Icons.play_arrow, 'status']
                : ['Pause Job', Icons.pause, 'status'],
            ['Change Category', Icons.category, 'category'],
            ['Change Priority', Icons.low_priority, 'priority'],
            ['Set Password', Icons.vpn_key, 'password'],
            ['Rename Job', Icons.text_format, 'rename'],
            ['Delete Job', Icons.delete, 'delete'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: title,
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> deleteJob(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Job',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this job?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> renameJob(BuildContext context, String originalName) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = originalName;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Rename Job',
            buttons: [
                LSDialog.button(
                    text: 'Rename',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Job Name',
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) => value.length < 1
                            ? 'Please enter a valid name'
                            : null,
                    ),
                ),
            ],
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> changePriority(BuildContext context) async {
        bool _flag = false;
        NZBGetPriority _priority;

        void _setValues(bool flag, NZBGetPriority priority) {
            _flag = flag;
            _priority = priority;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Change Priority',
            content: List.generate(
                NZBGetPriority.values.length,
                (index) => LSDialog.tile(
                    text: NZBGetPriority.values[index].name,
                    icon: Icons.low_priority,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, NZBGetPriority.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _priority];
    }

    static Future<List<dynamic>> changeCategory(BuildContext context, List<NZBGetCategoryData> categories) async {
        bool _flag = false;
        NZBGetCategoryData _category;

        void _setValues(bool flag, NZBGetCategoryData category) {
            _flag = flag;
            _category = category;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Change Category',
            content: List.generate(
                categories.length,
                (index) => LSDialog.tile(
                    text: categories[index].name,
                    icon: Icons.category,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, categories[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _category];
    }

    static Future<List<dynamic>> setPassword(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Set Password',
            buttons: [
                LSDialog.button(
                    text: 'Set',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Job Password',
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) => value.length < 1
                            ? 'Please enter a valid password'
                            : null,
                        obscureText: true,
                    ),
                ),
            ],
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> deleteHistory(BuildContext context) async {
        bool _flag = false;
        bool _hide = false;

        void _setValues(bool flag, bool hide) {
            _flag = flag;
            _hide = hide;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Remove History',
            buttons: [
                LSDialog.button(
                    text: 'Hide',
                    onPressed: () => _setValues(true, true),
                ),
                LSDialog.button(
                    text: 'Delete',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true, false),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to remove the history for this job?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag, _hide];
    }

    static Future<List<dynamic>> sortQueue(BuildContext context) async {
        bool _flag = false;
        NZBGetSort _sort;

        void _setValues(bool flag, NZBGetSort sort) {
            _flag = flag;
            _sort = sort;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Sort Queue',
            content: List.generate(
                NZBGetSort.values.length,
                (index) => LSDialog.tile(
                    text: NZBGetSort.values[index].name,
                    icon: NZBGetSort.values[index].icon,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, NZBGetSort.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _sort];
    }

    static Future<List<dynamic>> addNZB(BuildContext context) async {
        List<List<dynamic>> _options = [
            ['Add by URL', Icons.link, 'link'],
            ['Add by File', Icons.sd_card, 'file'],
        ];
        bool _flag = false;
        String _type = '';

        void _setValues(bool flag, String type) {
            _flag = flag;
            _type = type;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Add NZB',
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _type];
    }

    static Future<List<dynamic>> addNZBUrl(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Add NZB by URL',
            buttons: [
                LSDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'NZB URL',
                        keyboardType: TextInputType.url,
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) => !value.startsWith('http://') && !value.startsWith('https://')
                            ? 'Please enter a valid URL'
                            : null,
                    ),
                ),
            ],
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> speedLimit(BuildContext context, String currentSpeed) async {
        List<List<dynamic>> _options = [
            ['Unlimited', Icons.timeline, 0],
            ['125 MB/s', Icons.timeline, 128000],
            ['100 MB/s', Icons.timeline, 102400],
            ['75 MB/s', Icons.timeline, 76800],
            ['50 MB/s', Icons.timeline, 51200],
            ['25 MB/s', Icons.timeline, 25600],
            ['10 MB/s', Icons.timeline, 10240],
            ['Custom...', Icons.timeline, -1],
        ];
        bool _flag = false;
        int _limit = 0;

        void _setValues(bool flag, int limit) {
            _flag = flag;
            _limit = limit;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: currentSpeed == 'Unlimited' ? 'Speed Limit (Unlimited)' : 'Speed Limit ($currentSpeed/s)',
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _limit];
    }

    static Future<List<dynamic>> customSpeedLimit(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Custom Speed Limit',
            buttons: [
                LSDialog.button(
                    text: 'Set',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Please enter a speed limit in KB/s.'),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Speed Limit',
                        onSubmitted: (_) => _setValues(true),
                        keyboardType: TextInputType.number,
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
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, int.tryParse(_textController.text)];
    }

    static Future<List<dynamic>> historySettings(BuildContext context, String title) async {
        List<List<dynamic>> _options = [
            ['Retry Job', Icons.autorenew, 'retry'],
            ['Hide History', Icons.visibility_off, 'hide'],
            ['Delete History', Icons.delete, 'delete'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: title,
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> pauseFor(BuildContext context) async {
        List<List<dynamic>> _options = [
            ['5 Minutes', Icons.access_time, 5],
            ['15 Minutes', Icons.access_time, 15],
            ['30 Minutes', Icons.access_time, 30],
            ['1 Hour', Icons.access_time, 60],
            ['3 Hours', Icons.access_time, 180],
            ['6 Hours', Icons.access_time, 360],
            ['Custom...', Icons.access_time, -1],
        ];
        bool _flag = false;
        int _duration = 0;

        void _setValues(bool flag, int duration) {
            _flag = flag;
            _duration = duration;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Pause Queue For...',
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _duration];
    }

    static Future<List<dynamic>> customPauseFor(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Custom Pause Duration',
            buttons: [
                LSDialog.button(
                    text: 'Pause',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.richText(
                    children: [
                        LSDialog.textSpanContent(text: 'Please enter how long in '),
                        LSDialog.bolded(text: 'minutes'),
                        LSDialog.textSpanContent(text: ' you want to pause the queue for.'),
                    ],
                    alignment: TextAlign.center,
                ),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Pause Duration in Minutes',
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            int _value = int.tryParse(value);
                            if(_value == null || _value < 1) {
                                return 'Must be at least 1';
                            }
                            return null;
                        }
                    ),
                ),
            ],
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, int.tryParse(_textController.text)];
    }

    static Future<List<dynamic>> defaultPage(BuildContext context) async {
        bool _flag = false;
        int _index = 0;

        void _setValues(bool flag, int index) {
            _flag = flag;
            _index = index;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Default Page',
            content: List.generate(
                NZBGetNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: NZBGetNavigationBar.titles[index],
                    icon: NZBGetNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }
}
