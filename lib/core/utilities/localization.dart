import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaLocalization {
    /// Returns an iterable list of [Locale] objects containing all supported locales.
    Iterable<Locale> get supportedLocales {
        return [
            fallbackLocale,
            Locale('fr'),
            Locale('nb', 'NO'),
        ];
    }

    Locale get fallbackLocale => Locale('en');

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
    NORWEGIAN_BOKMAL,
}

extension LunaLanguageExtension on LunaLanguage {
    LunaLanguage fromLocale(Locale locale) {
        if(locale.toLanguageTag() == LunaLanguage.ENGLISH.languageTag) return LunaLanguage.ENGLISH;
        if(locale.toLanguageTag() == LunaLanguage.FRENCH.languageTag) return LunaLanguage.FRENCH;
        if(locale.toLanguageTag() == LunaLanguage.NORWEGIAN_BOKMAL.languageTag) return LunaLanguage.NORWEGIAN_BOKMAL;
        return null;
    }

    String get name {
        switch(this) {
            case LunaLanguage.ENGLISH: return 'English';
            case LunaLanguage.FRENCH: return 'French';
            case LunaLanguage.NORWEGIAN_BOKMAL: return 'Norwegian (Bokmål)';
        }
        throw Exception('Invalid LunaLanguage');
    }

    String get languageTag {
        switch(this) { 
            case LunaLanguage.ENGLISH: return 'en';
            case LunaLanguage.FRENCH: return 'fr';
            case LunaLanguage.NORWEGIAN_BOKMAL: return 'nb-NO';
        }
        throw Exception('Invalid LunaLanguage');
    }

    Locale get locale {
        switch(this) {
            case LunaLanguage.ENGLISH: return Locale('en');
            case LunaLanguage.FRENCH: return Locale('fr');
            case LunaLanguage.NORWEGIAN_BOKMAL: return Locale('nb', 'NO');
        }
        throw Exception('Invalid LunaLanguage');
    }

    Future<void> use(BuildContext context) => context.setLocale(this.locale);
}
