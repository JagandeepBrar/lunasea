import 'dart:convert';
import 'package:lunasea/core/database.dart';

class ExportConfiguration {
    ///
    List<Map<String, dynamic>> profiles() {
        List<Map<String, dynamic>> _data = [];
        for(var key in Database.profilesBox.keys) {
            ProfileHiveObject profile = Database.profilesBox.get(key);
            _data.add(profile.toMap());
        }
        return _data;
    }

    List<Map<String, dynamic>> indexers() {
        List<Map<String, dynamic>> _data = [];
        for(var key in Database.indexersBox.keys) {
            IndexerHiveObject indexer = Database.indexersBox.get(key);
            _data.add(indexer.toMap());
        }
        return _data;
    }

    /// Export the entire configuration to the filesystem.
    /// 
    /// Achieved by calling `export()` on all module databases, which implement [LunaModuleDatabase].
    String export() => json.encode({
        "lunasea": LunaSeaDatabase().export(),
        "profiles": profiles(),
        "indexers": indexers(),
    });
}