import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class SettingsDialogs {
  Future<bool> confirmAccountSignOut(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.SignOut'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'settings.SignOut'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.SignOutHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, LunaFirebaseBackupDocument>> getBackupFromCloud(
    BuildContext context,
    List<LunaFirebaseBackupDocument> backups,
  ) async {
    bool _flag = false;
    LunaFirebaseBackupDocument _document;

    void _setValues(bool flag, LunaFirebaseBackupDocument document) {
      _flag = flag;
      _document = document;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.BackupList'.tr(),
      content: backups.isNotEmpty
          ? List.generate(
              backups.length,
              (index) => LunaDialog.tile(
                icon: Icons.file_copy_rounded,
                iconColor: LunaColours().byListIndex(index),
                text: backups[index].title.toString(),
                onTap: () => _setValues(true, backups[index]),
              ),
            )
          : [LunaDialog.textContent(text: 'settings.NoBackupsFound'.tr())],
      contentPadding: backups.isNotEmpty
          ? LunaDialog.listDialogContentPadding()
          : LunaDialog.textDialogContentPadding(),
    );
    return Tuple2(_flag, _document);
  }

  Future<Tuple2<bool, String>> editHost(
    BuildContext context, {
    String prefill = '',
  }) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController()..text = prefill;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.Host'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint3'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint4'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint5'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'settings.Host'.tr(),
            keyboardType: TextInputType.url,
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              // Allow empty value
              if (value == '') return null;
              // Test for https:// or http://
              RegExp exp = RegExp(r"^(http|https)://", caseSensitive: false);
              if (exp.hasMatch(value)) return null;
              return 'settings.HostValidation'.tr();
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<Tuple2<bool, String>> editExternalModuleHost(
    BuildContext context, {
    String prefill = '',
  }) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController()..text = prefill;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.Host'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint3'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.HostHint4'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'settings.Host'.tr(),
            keyboardType: TextInputType.url,
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              // Allow empty value
              if (value == '') return null;
              // Test for https:// or http://
              RegExp exp = RegExp(r"^(http|https)://", caseSensitive: false);
              if (exp.hasMatch(value)) return null;
              return 'settings.HostValidation'.tr();
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<bool> deleteIndexer(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DeleteIndexer'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.DeleteIndexerHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> deleteExternalModule(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DeleteModule'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.DeleteModuleHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> deleteHeader(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DeleteHeader'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.DeleteHeaderHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, HeaderType>> addHeader(BuildContext context) async {
    bool _flag = false;
    HeaderType _type;

    void _setValues(bool flag, HeaderType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.AddHeader'.tr(),
      content: List.generate(
        HeaderType.values.length,
        (index) => LunaDialog.tile(
          text: HeaderType.values[index].name,
          icon: HeaderType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, HeaderType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _type);
  }

  Future<Tuple3<bool, String, String>> addCustomHeader(
    BuildContext context,
  ) async {
    bool _flag = false;
    final formKey = GlobalKey<FormState>();
    TextEditingController _key = TextEditingController();
    TextEditingController _value = TextEditingController();

    void _setValues(bool flag) {
      if (formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.CustomHeader'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Add'.tr(),
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
                validator: (key) {
                  if (key.isNotEmpty) return null;
                  return 'settings.HeaderKeyValidation'.tr();
                },
                onSubmitted: (_) => _setValues(true),
                title: 'settings.HeaderKey'.tr(),
              ),
              LunaDialog.textFormInput(
                controller: _value,
                validator: (value) {
                  if (value.isNotEmpty) return null;
                  return 'settings.HeaderValueValidation'.tr();
                },
                onSubmitted: (_) => _setValues(true),
                title: 'settings.HeaderValue'.tr(),
              ),
            ],
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return Tuple3(_flag, _key.text, _value.text);
  }

  Future<Tuple3<bool, String, String>> addBasicAuthenticationHeader(
    BuildContext context,
  ) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _username = TextEditingController();
    final _password = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.BasicAuthentication'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Add'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BasicAuthenticationHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BasicAuthenticationHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BasicAuthenticationHint3'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              LunaDialog.textFormInput(
                controller: _username,
                validator: (username) => username.isNotEmpty
                    ? null
                    : 'settings.UsernameValidation'.tr(),
                onSubmitted: (_) => _setValues(true),
                title: 'settings.Username'.tr(),
              ),
              LunaDialog.textFormInput(
                controller: _password,
                validator: (password) => password.isNotEmpty
                    ? null
                    : 'settings.PasswordValidation'.tr(),
                onSubmitted: (_) => _setValues(true),
                obscureText: true,
                title: 'settings.Password'.tr(),
              ),
            ],
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple3(_flag, _username.text, _password.text);
  }

  Future<bool> clearLogs(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.ClearLogs'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Clear'.tr(),
          onPressed: () => _setValues(true),
          textColor: LunaColours.red,
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.ClearLogsHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, String>> confirmDeleteAccount(
    BuildContext context,
  ) async {
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();
    bool _flag = false;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DeleteAccount'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          onPressed: () => _setValues(true),
          textColor: LunaColours.red,
        ),
      ],
      content: [
        LunaDialog.richText(
          children: [
            LunaDialog.bolded(
              text: 'settings.DeleteAccountWarning1'.tr().toUpperCase(),
              color: LunaColours.red,
              fontSize: LunaDialog.BUTTON_SIZE,
            ),
            LunaDialog.textSpanContent(text: '\n\n'),
            LunaDialog.textSpanContent(
              text: 'settings.DeleteAccountHint1'.tr(),
            ),
            LunaDialog.textSpanContent(text: '\n\n'),
            LunaDialog.textSpanContent(
              text: 'settings.DeleteAccountHint2'.tr(),
            ),
          ],
          alignment: TextAlign.center,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'settings.Password'.tr(),
            obscureText: true,
            onSubmitted: (_) => _setValues(true),
            validator: (value) =>
                value.isEmpty ? 'settings.PasswordValidation'.tr() : null,
          ),
        ),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<Tuple2<bool, String>> addProfile(
    BuildContext context,
    List<String> profiles,
  ) async {
    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController();
    bool _flag = false;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.AddProfile'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Add'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _controller,
            validator: (value) {
              if (profiles.contains(value)) {
                return 'settings.ProfileAlreadyExists'.tr();
              }
              if (value.isEmpty) {
                return 'settings.ProfileNameRequired'.tr();
              }
              return null;
            },
            onSubmitted: (_) => _setValues(true),
            title: 'settings.ProfileName'.tr(),
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return Tuple2(_flag, _controller.text);
  }

  Future<Tuple2<bool, String>> renameProfile(
    BuildContext context,
    List<String> profiles,
  ) async {
    bool _flag = false;
    String _profile = '';

    void _setValues(bool flag, String profile) {
      _flag = flag;
      _profile = profile;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.RenameProfile'.tr(),
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          icon: Icons.settings_rounded,
          iconColor: LunaColours().byListIndex(index),
          text: profiles[index],
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _profile);
  }

  Future<Tuple2<bool, String>> renameProfileSelected(
    BuildContext context,
    List<String> profiles,
  ) async {
    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController();
    bool _flag = false;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.RenameProfile'.tr(),
      buttons: [
        LunaDialog.button(
            text: 'lunasea.Rename'.tr(),
            onPressed: () => _setValues(true),
            textColor: LunaColours.accent),
      ],
      content: [
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _controller,
            validator: (value) {
              if (profiles.contains(value)) {
                return 'settings.ProfileAlreadyExists'.tr();
              }
              if (value.isEmpty) {
                return 'settings.ProfileNameRequired'.tr();
              }
              return null;
            },
            onSubmitted: (_) => _setValues(true),
            title: 'settings.ProfileName'.tr(),
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return Tuple2(_flag, _controller.text);
  }

  Future<Tuple2<bool, String>> deleteProfile(
    BuildContext context,
    List<String> profiles,
  ) async {
    bool _flag = false;
    String _profile = '';

    void _setValues(bool flag, String profile) {
      _flag = flag;
      _profile = profile;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DeleteProfile'.tr(),
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          icon: Icons.settings_rounded,
          iconColor: LunaColours().byListIndex(index),
          text: profiles[index],
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _profile);
  }

  Future<Tuple2<bool, String>> enabledProfile(
    BuildContext context,
    List<String> profiles,
  ) async {
    bool _flag = false;
    String _profile = '';

    void _setValues(bool flag, String profile) {
      _flag = flag;
      _profile = profile;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.EnabledProfile'.tr(),
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          icon: Icons.settings_rounded,
          iconColor: LunaColours().byListIndex(index),
          text: profiles[index],
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _profile);
  }

  Future<Tuple2<bool, LunaBrowser>> changeBrowser(BuildContext context) async {
    bool _flag = false;
    LunaBrowser _browser;

    void _setValues(bool flag, LunaBrowser browser) {
      _flag = flag;
      _browser = browser;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.OpenLinksIn'.tr(),
      content: List.generate(
        LunaBrowser.values.length,
        (index) => LunaDialog.tile(
          icon: LunaBrowser.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          text: LunaBrowser.values[index].name,
          onTap: () => _setValues(true, LunaBrowser.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _browser);
  }

  Future<Tuple2<bool, LunaLanguage>> changeLanguage(
    BuildContext context,
  ) async {
    List<LunaLanguage> languages = LunaLocalization().supportedLanguages;
    bool _flag = false;
    LunaLanguage _language;

    void _setValues(bool flag, LunaLanguage language) {
      _flag = flag;
      _language = language;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.Language'.tr(),
      content: List.generate(
        languages.length,
        (index) => LunaDialog.tile(
          icon: Icons.language_rounded,
          iconColor: LunaColours().byListIndex(index),
          text: languages[index].name,
          onTap: () => _setValues(true, languages[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _language);
  }

  Future<Tuple2<bool, CalendarStartingDay>> editCalendarStartingDay(
    BuildContext context,
  ) async {
    bool _flag = false;
    CalendarStartingDay _startingDate;

    void _setValues(bool flag, CalendarStartingDay startingDate) {
      _flag = flag;
      _startingDate = startingDate;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.StartingDay'.tr(),
      content: List.generate(
        CalendarStartingDay.values.length,
        (index) => LunaDialog.tile(
          icon: Icons.calendar_today_rounded,
          iconColor: LunaColours().byListIndex(index),
          text: CalendarStartingDay.values[index].name,
          onTap: () => _setValues(true, CalendarStartingDay.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _startingDate);
  }

  Future<Tuple2<bool, CalendarStartingSize>> editCalendarStartingSize(
    BuildContext context,
  ) async {
    bool _flag = false;
    CalendarStartingSize _startingSize;

    void _setValues(bool flag, CalendarStartingSize startingSize) {
      _flag = flag;
      _startingSize = startingSize;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.StartingSize'.tr(),
      content: List.generate(
        CalendarStartingSize.values.length,
        (index) => LunaDialog.tile(
          icon: CalendarStartingSize.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          text: CalendarStartingSize.values[index].name,
          onTap: () => _setValues(true, CalendarStartingSize.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _startingSize);
  }

  Future<Tuple2<bool, CalendarStartingType>> editCalendarStartingView(
    BuildContext context,
  ) async {
    bool _flag = false;
    CalendarStartingType _startingType;

    void _setValues(bool flag, CalendarStartingType startingType) {
      _flag = flag;
      _startingType = startingType;
      Navigator.of(context).pop();
    }

    IconData _getIcon(CalendarStartingType type) {
      switch (type) {
        case CalendarStartingType.CALENDAR:
          return CalendarStartingType.SCHEDULE.icon;
        case CalendarStartingType.SCHEDULE:
          return CalendarStartingType.CALENDAR.icon;
        default:
          return Icons.help_rounded;
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.StartingView'.tr(),
      content: List.generate(
        CalendarStartingType.values.length,
        (index) => LunaDialog.tile(
          icon: _getIcon(CalendarStartingType.values[index]),
          iconColor: LunaColours().byListIndex(index),
          text: CalendarStartingType.values[index].name,
          onTap: () => _setValues(true, CalendarStartingType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _startingType);
  }

  Future<Tuple2<bool, String>> editBroadcastAddress(
    BuildContext context,
    String prefill,
  ) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController()..text = prefill;

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.BroadcastAddress'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BroadcastAddressHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BroadcastAddressHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BroadcastAddressHint3'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _controller,
            validator: (address) {
              if (address.isEmpty) return null;
              return IPv4Address.validate(address)
                  ? null
                  : 'settings.BroadcastAddressValidation'.tr();
            },
            onSubmitted: (_) => _setValues(true),
            title: 'settings.BroadcastAddress'.tr(),
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _controller.text);
  }

  Future<Tuple2<bool, String>> editMACAddress(
    BuildContext context,
    String prefill,
  ) async {
    bool _flag = false;
    final formKey = GlobalKey<FormState>();
    final _controller = TextEditingController()..text = prefill;

    void _setValues(bool flag) {
      if (formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.MACAddress'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.MACAddressHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.MACAddressHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.MACAddressHint3'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text: '${LunaUI.TEXT_BULLET}\t${'settings.MACAddressHint4'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: formKey,
          child: LunaDialog.textFormInput(
            controller: _controller,
            validator: (address) {
              if (address.isEmpty) return null;
              return MACAddress.validate(address)
                  ? null
                  : 'settings.MACAddressValidation'.tr();
            },
            onSubmitted: (_) => _setValues(true),
            title: 'settings.MACAddress'.tr(),
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _controller.text);
  }

  Future<bool> dismissTooltipBanners(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DismissBanners'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Dismiss'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.DismissBannersHint1'.tr()),
        LunaDialog.textContent(text: ''),
        LunaDialog.textContent(text: 'settings.DismissBannersHint2'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> clearConfiguration(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.ClearConfiguration'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Clear'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.ClearConfigurationHint1'.tr()),
        LunaDialog.textContent(text: ''),
        LunaDialog.textContent(text: 'settings.ClearConfigurationHint2'.tr()),
        LunaDialog.textContent(text: ''),
        LunaDialog.textContent(text: 'settings.ClearConfigurationHint3'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, String>> decryptBackup(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.DecryptBackup'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Restore'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'settings.DecryptBackupHint1'.tr()),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'settings.EncryptionKey'.tr(),
            obscureText: true,
            onSubmitted: (_) => _setValues(true),
            validator: (value) => value.length < 8
                ? 'settings.MinimumCharacters'.tr(args: [8.toString()])
                : null,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<Tuple2<bool, String>> backupConfiguration(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.BackupConfiguration'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.BackUp'.tr(),
          textColor: LunaColours.accent,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BackupConfigurationHint1'.tr()}',
          textAlign: TextAlign.left,
        ),
        LunaDialog.textContent(
          text:
              '${LunaUI.TEXT_BULLET}\t${'settings.BackupConfigurationHint2'.tr()}',
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            obscureText: true,
            controller: _textController,
            title: 'settings.EncryptionKey'.tr(),
            validator: (value) => value.length < 8
                ? 'settings.MinimumCharacters'.tr(args: [8.toString()])
                : null,
            onSubmitted: (_) => _setValues(true),
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<bool> disableCrashlyticsWarning(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.FirebaseCrashlytics'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Website'.tr(),
          onPressed: LunaLinks.CRASHLYTICS.launch,
          textColor: LunaColours.accent,
        ),
        LunaDialog.button(
          text: 'lunasea.Disable'.tr(),
          onPressed: () => _setValues(true),
          textColor: LunaColours.red,
        ),
      ],
      content: [
        LunaDialog.richText(
          children: [
            LunaDialog.bolded(
              text: '${'settings.FirebaseCrashlyticsHint1'.tr()}\n\n',
              color: LunaColours.red,
              fontSize: LunaDialog.BUTTON_SIZE,
            ),
            LunaDialog.textSpanContent(
              text: '${'settings.FirebaseCrashlyticsHint2'.tr()}\n\n',
            ),
            LunaDialog.textSpanContent(
              text: '${'settings.FirebaseCrashlyticsHint3'.tr()}\n\n',
            ),
            LunaDialog.textSpanContent(
              text: '${'settings.FirebaseCrashlyticsHint4'.tr()}\n\n',
            ),
            LunaDialog.bolded(
              text: 'settings.FirebaseCrashlyticsHint5'.tr(),
              color: LunaColours.accent,
              fontSize: LunaDialog.BUTTON_SIZE,
            ),
          ],
          alignment: TextAlign.center,
        ),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, int>> changeBackgroundImageOpacity(
    BuildContext context,
  ) async {
    bool _flag = false;
    int _opacity = 0;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController()
      ..text = LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data.toString();

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _opacity = int.parse(_textController.text);
        _flag = flag;
        Navigator.of(context).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'settings.ImageBackgroundOpacity'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'settings.ImageBackgroundOpacityHint1'.tr(),
        ),
        LunaDialog.textContent(text: ''),
        LunaDialog.textContent(
          text: 'settings.ImageBackgroundOpacityHint2'.tr(),
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'settings.ImageBackgroundOpacity'.tr(),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              int _opacity = int.tryParse(value);
              if (_opacity == null || _opacity < 0 || _opacity > 100)
                return 'settings.MustBeValueBetween'.tr(args: [
                  0.toString(),
                  100.toString(),
                ]);
              return null;
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _opacity);
  }

  Future<void> accountHelpMessage(BuildContext context) async {
    await LunaDialog.dialog(
      context: context,
      title: 'settings.AccountHelp'.tr(),
      content: [LunaDialog.textContent(text: 'settings.AccountHelpHint1'.tr())],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
  }
}
