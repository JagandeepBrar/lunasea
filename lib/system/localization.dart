import 'package:flutter/material.dart';
import 'package:lunasea/state/state.dart';

import 'package:lunasea/system/flavor.dart';
import 'package:lunasea/vendor.dart';

class LunaLocalization {
  static const fileDirectory = 'assets/localization';
  static final fallbackLocale = LunaLanguage.ENGLISH.locale;

  List<LunaLanguage> supportedLanguages() {
    return LunaLanguage.values.where((lang) => lang.enabled).toList();
  }

  List<Locale> supportedLocales() {
    return supportedLanguages().map<Locale>((lang) => lang.locale).toList();
  }

  Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }
}

enum LunaLanguage {
  CATALAN('ca', Locale('ca'), 'Catalan'),
  CHINESE_SIMPLIFIED('zh-Hans', Locale('zh', 'Hans'), 'Chinese (Simplified)'),
  CROATIAN('hr', Locale('hr'), 'Croatian'),
  DUTCH('nl', Locale('nl'), 'Dutch'),
  ENGLISH('en', Locale('en'), 'English'),
  FRENCH('fr', Locale('fr'), 'French'),
  GERMAN('de', Locale('de'), 'German'),
  HUNGARIAN('hu', Locale('hu'), 'Hungarian'),
  ITALIAN('it', Locale('it'), 'Italian'),
  NORWEGIAN_BOKMAL('nb-NO', Locale('nb', 'NO'), 'Norwegian (Bokmål)'),
  PORTUGUESE('pt', Locale('pt'), 'Portuguese'),
  RUSSIAN('ru', Locale('ru'), 'Russian'),
  SPANISH('es', Locale('es'), 'Spanish'),
  SWEDISH('sv', Locale('sv'), 'Swedish'),
  TURKISH('tr', Locale('tr'), 'Turkish'),
  VIETNAMESE('vi', Locale('vi'), 'Vietnamese');

  final String languageTag;
  final Locale locale;
  final String name;
  const LunaLanguage(this.languageTag, this.locale, this.name);

  static LunaLanguage current([BuildContext? context]) {
    final locale = (context ?? LunaState.context).locale;
    return fromLocale(locale) ?? LunaLanguage.ENGLISH;
  }

  static LunaLanguage? fromLocale(Locale locale) {
    final tag = locale.toLanguageTag();
    for (final language in LunaLanguage.values) {
      if (tag == language.languageTag) return language;
    }
    return null;
  }

  Future<void> use([BuildContext? context]) async {
    await (context ?? LunaState.context).setLocale(locale);
    Intl.defaultLocale = languageTag;
  }

  bool get enabled {
    switch (this) {
      case LunaLanguage.ENGLISH:
        return true;
      case LunaLanguage.FRENCH:
        return true;
      default:
        return LunaFlavor.BETA.isRunningFlavor();
    }
  }
}
