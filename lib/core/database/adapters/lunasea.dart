enum LunaSeaDatabaseValue {
    ENABLED_PROFILE,
}

extension LunaSeaDatabaseValueExtension on LunaSeaDatabaseValue {
    String get key {
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: return 'profile';
        }
        return '';
    }
}
