import 'dart:convert';
import 'package:lunasea/core/database.dart';

class Export {
    Export._();

    static Map get _lunasea {
        Box<dynamic> _box = Database.getLunaSeaBox();
        Map<String, dynamic> _data = {};
        for(var key in _box.keys) {
            _data[key] = _box.get(key);
        }
        return _data;
    }

    static List get _profiles {
        Box<dynamic> _box = Database.getProfilesBox();
        List _data = [];
        for(var key in _box.keys) {
            ProfileHiveObject profile = _box.get(key);
            _data.add(profile.toMap());
        }
        return _data;
    }

    static List get _indexers {
        Box<dynamic> _box = Database.getIndexersBox();
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