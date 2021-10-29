import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaLocalization {
  /// List of [LunaLanguage] values with all currently supported languages
  List<LunaLanguage> get supportedLanguages =>
      LunaLanguage.values.where((lang) => lang.enabled).toList();

  /// Returns an iterable list of [Locale] objects containing all supported & enabled locales.
  Iterable<Locale> get supportedLocales =>
      supportedLanguages.map<Locale>((lang) => lang.locale).toList();

  Locale get fallbackLocale => LunaLanguage.ENGLISH.locale;

  /// Directory containing all localization files
  String get fileDirectory => 'assets/localization';

  /// Initialize the localization system.
  Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }
}

enum LunaLanguage {
  ENGLISH,
  FRENCH,
  GERMAN,
  ITALIAN,
  NORWEGIAN_BOKMAL,
  PORTUGUESE,
  RUSSIAN,
  SWEDISH,
}

extension LunaLanguageExtension on LunaLanguage {
  LunaLanguage fromLocale(Locale locale) {
    if (locale.toLanguageTag() == LunaLanguage.ENGLISH.languageTag)
      return LunaLanguage.ENGLISH;
    if (locale.toLanguageTag() == LunaLanguage.FRENCH.languageTag)
      return LunaLanguage.FRENCH;
    if (locale.toLanguageTag() == LunaLanguage.GERMAN.languageTag)
      return LunaLanguage.GERMAN;
    if (locale.toLanguageTag() == LunaLanguage.ITALIAN.languageTag)
      return LunaLanguage.ITALIAN;
    if (locale.toLanguageTag() == LunaLanguage.NORWEGIAN_BOKMAL.languageTag)
      return LunaLanguage.NORWEGIAN_BOKMAL;
    if (locale.toLanguageTag() == LunaLanguage.PORTUGUESE.languageTag)
      return LunaLanguage.PORTUGUESE;
    if (locale.toLanguageTag() == LunaLanguage.RUSSIAN.languageTag)
      return LunaLanguage.RUSSIAN;
    if (locale.toLanguageTag() == LunaLanguage.SWEDISH.languageTag)
      return LunaLanguage.SWEDISH;
    return null;
  }

  bool get enabled {
    switch (this) {
      case LunaLanguage.ENGLISH:
        return true;
      // Keep all languages enabled in debug mode while LunaSea is being adapted for localization
      case LunaLanguage.FRENCH:
        return kDebugMode;
      case LunaLanguage.GERMAN:
        return kDebugMode;
      case LunaLanguage.ITALIAN:
        return kDebugMode;
      case LunaLanguage.NORWEGIAN_BOKMAL:
        return kDebugMode;
      case LunaLanguage.PORTUGUESE:
        return kDebugMode;
      case LunaLanguage.RUSSIAN:
        return kDebugMode;
      case LunaLanguage.SWEDISH:
        return kDebugMode;
    }
    throw Exception('Invalid LunaLanguage');
  }

  String get name {
    switch (this) {
      case LunaLanguage.ENGLISH:
        return 'English';
      case LunaLanguage.FRENCH:
        return 'French';
      case LunaLanguage.GERMAN:
        return 'German';
      case LunaLanguage.ITALIAN:
        return 'Italian';
      case LunaLanguage.NORWEGIAN_BOKMAL:
        return 'Norwegian (Bokmål)';
      case LunaLanguage.PORTUGUESE:
        return 'Portuguese';
      case LunaLanguage.RUSSIAN:
        return 'Russian';
      case LunaLanguage.SWEDISH:
        return 'Swedish';
    }
    throw Exception('Invalid LunaLanguage');
  }

  String get languageTag {
    switch (this) {
      case LunaLanguage.ENGLISH:
        return 'en';
      case LunaLanguage.FRENCH:
        return 'fr';
      case LunaLanguage.GERMAN:
        return 'de';
      case LunaLanguage.ITALIAN:
        return 'it';
      case LunaLanguage.NORWEGIAN_BOKMAL:
        return 'nb-NO';
      case LunaLanguage.PORTUGUESE:
        return 'pt';
      case LunaLanguage.RUSSIAN:
        return 'ru';
      case LunaLanguage.SWEDISH:
        return 'sv';
    }
    throw Exception('Invalid LunaLanguage');
  }

  Locale get locale {
    switch (this) {
      case LunaLanguage.ENGLISH:
        return const Locale('en');
      case LunaLanguage.FRENCH:
        return const Locale('fr');
      case LunaLanguage.GERMAN:
        return const Locale('de');
      case LunaLanguage.ITALIAN:
        return const Locale('it');
      case LunaLanguage.NORWEGIAN_BOKMAL:
        return const Locale('nb', 'NO');
      case LunaLanguage.PORTUGUESE:
        return const Locale('pt');
      case LunaLanguage.RUSSIAN:
        return const Locale('ru');
      case LunaLanguage.SWEDISH:
        return const Locale('sv');
    }
    throw Exception('Invalid LunaLanguage');
  }

  Future<void> use(BuildContext context) => context.setLocale(this.locale);
}
