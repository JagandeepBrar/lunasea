import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdDialogs {
  SABnzbdDialogs._();

  static Future<List<dynamic>> globalSettings(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['View Web GUI', Icons.language_rounded, 'web_gui'],
      ['Add NZB', Icons.add_rounded, 'add_nzb'],
      ['Sort Queue', Icons.sort_rounded, 'sort'],
      ['Clear History', Icons.clear_all_rounded, 'clear_history'],
      ['On Complete Action', Icons.settings_power_rounded, 'complete_action'],
      ['Status & Statistics', Icons.info_outline_rounded, 'server_details'],
    ];
    bool _flag = false;
    String _value = '';

    void _setValues(bool flag, String value) {
      _flag = flag;
      _value = value;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Settings',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> queueSettings(
      BuildContext context, String title, bool isPaused) async {
    List<List<dynamic>> _options = [
      isPaused
          ? ['Resume Job', Icons.play_arrow_rounded, 'status']
          : ['Pause Job', Icons.pause_rounded, 'status'],
      ['Change Category', Icons.category_rounded, 'category'],
      ['Change Priority', Icons.low_priority_rounded, 'priority'],
      ['Set Password', Icons.vpn_key_rounded, 'password'],
      ['Rename Job', Icons.text_format_rounded, 'rename'],
      ['Delete Job', Icons.delete_rounded, 'delete'],
    ];
    bool _flag = false;
    String _value = '';

    void _setValues(bool flag, String value) {
      _flag = flag;
      _value = value;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: title,
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> historySettings(
      BuildContext context, String title, bool failed) async {
    List<List<dynamic>> _options = [
      if (failed) ['Retry Job', Icons.autorenew_rounded, 'retry'],
      if (failed) ['Set Password', Icons.vpn_key_rounded, 'password'],
      ['Delete History', Icons.delete_rounded, 'delete'],
    ];
    bool _flag = false;
    String _value = '';

    void _setValues(bool flag, String value) {
      _flag = flag;
      _value = value;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: title,
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: _options.length == 1
              ? LunaColours.red
              : LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> changeCategory(
      BuildContext context, List<SABnzbdCategoryData> categories) async {
    bool _flag = false;
    String? _value = '';

    void _setValues(bool flag, String? value) {
      _flag = flag;
      _value = value;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Change Category',
      content: List.generate(
        categories.length,
        (index) => LunaDialog.tile(
          text: categories[index].category!,
          icon: Icons.category_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, categories[index].category),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> sortQueue(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['Age (Ascending)', Icons.access_time_rounded, 'avg_age', 'asc'],
      ['Age (Descending)', Icons.access_time_rounded, 'avg_age', 'desc'],
      ['Name (Ascending)', Icons.text_rotate_vertical_rounded, 'name', 'asc'],
      ['Name (Descending)', Icons.text_rotate_vertical_rounded, 'name', 'desc'],
      ['Size (Ascending)', Icons.sd_card_rounded, 'size', 'asc'],
      ['Size (Descending)', Icons.sd_card_rounded, 'size', 'desc'],
    ];
    bool _flag = false;
    String _sort = '';
    String _dir = '';
    String _name = '';

    void _setValues(bool flag, String sort, String dir, String name) {
      _flag = flag;
      _sort = sort;
      _dir = dir;
      _name = name;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Sort Queue',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
            text: _options[index][0],
            icon: _options[index][1],
            iconColor: LunaColours().byListIndex(index),
            onTap: () => _setValues(true, _options[index][2],
                _options[index][3], _options[index][0])),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _sort, _dir, _name];
  }

  static Future<List<dynamic>> addNZB(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['Add by URL', Icons.link_rounded, 'link'],
      ['Add by File', Icons.sd_card_rounded, 'file'],
    ];
    bool _flag = false;
    String _value = '';
    void _setValues(bool flag, String value) {
      _flag = flag;
      _value = value;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Add NZB',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> addNZBUrl(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Add NZB by URL',
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
            controller: _textController,
            title: 'NZB URL',
            keyboardType: TextInputType.url,
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              if (!(value?.startsWith('http://') ?? true) &&
                  !(value?.startsWith('https://') ?? true)) {
                return 'Please enter a valid URL';
              }
              return null;
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return [_flag, _textController.text];
  }

  static Future<List<dynamic>> renameJob(
      BuildContext context, String originalName) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController()..text = originalName;

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Rename Job',
      buttons: [
        LunaDialog.button(
          text: 'Rename',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'Job Name',
            onSubmitted: (_) => _setValues(true),
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Please enter a valid name' : null,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return [_flag, _textController.text];
  }

  static Future<List<dynamic>> setPassword(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Set Password',
      buttons: [
        LunaDialog.button(
          text: 'Set',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'Job Password',
            onSubmitted: (_) => _setValues(true),
            validator: (value) => (value?.isEmpty ?? true)
                ? 'Please enter a valid password'
                : null,
            obscureText: true,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return [_flag, _textController.text];
  }

  static Future<List<dynamic>> speedLimit(
      BuildContext context, int currentSpeed) async {
    List<List<dynamic>> _options = [
      ['20%', Icons.timeline_rounded, 20],
      ['40%', Icons.timeline_rounded, 40],
      ['60%', Icons.timeline_rounded, 60],
      ['80%', Icons.timeline_rounded, 80],
      ['100%', Icons.timeline_rounded, 100],
      ['Custom...', Icons.timeline_rounded, -1],
    ];
    bool _flag = false;
    int _limit = 0;

    void _setValues(bool flag, int limit) {
      _flag = flag;
      _limit = limit;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Speed Limit ($currentSpeed%)',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
            text: _options[index][0],
            icon: _options[index][1],
            iconColor: LunaColours().byListIndex(index),
            onTap: () => _setValues(true, _options[index][2])),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _limit];
  }

  static Future<List<dynamic>> pauseFor(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['5 Minutes', Icons.access_time_rounded, 5],
      ['15 Minutes', Icons.access_time_rounded, 15],
      ['30 Minutes', Icons.access_time_rounded, 30],
      ['1 Hour', Icons.access_time_rounded, 60],
      ['3 Hours', Icons.access_time_rounded, 180],
      ['6 Hours', Icons.access_time_rounded, 360],
      ['Custom...', Icons.access_time_rounded, -1],
    ];
    bool _flag = false;
    int _duration = 0;

    void _setValues(bool flag, int duration) {
      _flag = flag;
      _duration = duration;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Pause Queue For...',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _duration];
  }

  static Future<List<dynamic>> customPauseFor(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Custom Pause Duration',
      buttons: [
        LunaDialog.button(
          text: 'Pause',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.richText(
          children: [
            LunaDialog.textSpanContent(text: 'Please enter how long in '),
            LunaDialog.bolded(text: 'minutes'),
            LunaDialog.textSpanContent(
                text: ' you want to pause the queue for.'),
          ],
          alignment: TextAlign.center,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
              controller: _textController,
              title: 'Pause Duration in Minutes',
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _setValues(true),
              validator: (value) {
                int? _value = int.tryParse(value!);
                if (_value == null || _value < 1) {
                  return 'Must be at least 1';
                }
                return null;
              }),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return [_flag, int.tryParse(_textController.text)];
  }

  static Future<List<dynamic>> changePriority(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['Category Default', Icons.low_priority_rounded, -100],
      ['Force', Icons.low_priority_rounded, 2],
      ['High', Icons.low_priority_rounded, 1],
      ['Normal', Icons.low_priority_rounded, 0],
      ['Low', Icons.low_priority_rounded, -1],
      ['Stop', Icons.low_priority_rounded, -4],
    ];
    bool _flag = false;
    int _priority = 0;
    String _name = '';

    void _setValues(bool flag, int priority, String name) {
      _flag = flag;
      _priority = priority;
      _name = name;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Change Priority',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2], _options[index][0]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _priority, _name];
  }

  static Future<List<dynamic>> changeOnCompleteAction(
      BuildContext context) async {
    List<List<dynamic>> _options = [
      ['Shutdown SABnzbd', Icons.settings_power_rounded, 'shutdown_program'],
      ['Shutdown Machine', Icons.settings_power_rounded, 'shutdown_pc'],
      ['Hibernate Machine', Icons.settings_power_rounded, 'hibernate_pc'],
      ['Standby Machine', Icons.settings_power_rounded, 'standby_pc'],
      ['Nothing', Icons.settings_power_rounded, 'none'],
    ];
    bool _flag = false;
    String _action = '';
    String _name = '';

    void _setValues(bool flag, String action, String name) {
      _flag = flag;
      _action = action;
      _name = name;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'On Complete Action',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _options[index][2], _options[index][0]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _action, _name];
  }

  static Future<List<dynamic>> clearAllHistory(BuildContext context) async {
    List<List<dynamic>> _options = [
      ['Clear All', Icons.clear_all_rounded, 'all', false],
      ['Clear Completed', Icons.clear_all_rounded, 'completed', false],
      ['Clear Failed', Icons.clear_all_rounded, 'failed', false],
      ['Clear & Delete Failed', Icons.clear_all_rounded, 'failed', true],
    ];
    bool _flag = false;
    bool _delete = false;
    String _action = '';
    String _name = '';

    void _setValues(bool flag, String action, bool delete, String name) {
      _flag = flag;
      _action = action;
      _delete = delete;
      _name = name;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Clear History',
      content: List.generate(
        _options.length,
        (index) => LunaDialog.tile(
          text: _options[index][0],
          icon: _options[index][1],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(
              true, _options[index][2], _options[index][3], _options[index][0]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _action, _delete, _name];
  }

  static Future<List<dynamic>> customSpeedLimit(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Custom Speed Limit',
      buttons: [
        LunaDialog.button(
          text: 'Set',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Please enter a percentage between 1 and 100.'),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'Speed Limit',
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              int? _value = int.tryParse(value!);
              if (_value == null || _value < 1 || _value > 100) {
                return 'Must be between 1 and 100';
              }
              return null;
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return [_flag, int.tryParse(_textController.text)];
  }

  static Future<List<dynamic>> deleteJob(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Delete Job',
      buttons: [
        LunaDialog.button(
          text: 'Delete',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to delete this job?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return [_flag];
  }

  static Future<List<dynamic>> deleteHistory(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Delete History',
      buttons: [
        LunaDialog.button(
          text: 'Delete',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to delete the history for this job?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return [_flag];
  }

  static Future<List<dynamic>> defaultPage(BuildContext context) async {
    bool _flag = false;
    int _index = 0;

    void _setValues(bool flag, int index) {
      _flag = flag;
      _index = index;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Page',
      content: List.generate(
        SABnzbdNavigationBar.titles.length,
        (index) => LunaDialog.tile(
          text: SABnzbdNavigationBar.titles[index],
          icon: SABnzbdNavigationBar.icons[index],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, index),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );

    return [_flag, _index];
  }
}
