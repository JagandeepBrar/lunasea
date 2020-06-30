import 'dart:convert';
import 'package:lunasea/core/database.dart';

class Export {
    Export._();

    static bool validateType(dynamic value) {
        Type _type = value.runtimeType;
        if(
            _type == bool ||
            _type == String ||
            _type == int ||
            _type == double
        ) return true;
        return false;
    }

    static Map get _lunasea {
        Map<String, dynamic> _data = {};
        _data['profile'] = LunaSeaDatabaseValue.ENABLED_PROFILE.data;
        return _data;
    }

    static List get _profiles {
        Box<dynamic> _box = Database.profilesBox;
        List _data = [];
        for(var key in _box.keys) {
            ProfileHiveObject profile = _box.get(key);
            _data.add(profile.toMap());
        }
        return _data;
    }

    static List get _indexers {
        Box<dynamic> _box = Database.indexersBox;
        List _data = [];
        for(var key in _box.keys) {
            IndexerHiveObject indexer = _box.get(key);
            _data.add(indexer.toMap());
        }
        return _data;
    }

    static String export() {
        return json.encode({
            "lunasea": _lunasea,
            "profiles": _profiles,
            "indexers": _indexers,
        });
    }
}