import 'dart:convert';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/modules.dart' show HomeConstants, HomeDatabase;

class ExportConfiguration {
    List<Map<String, dynamic>> _setProfiles() {
        List<Map<String, dynamic>> _data = [];
        for(var key in Database.profilesBox.keys) {
            ProfileHiveObject profile = Database.profilesBox.get(key);
            _data.add(profile.toMap());
        }
        return _data;
    }

    List<Map<String, dynamic>> _setIndexers() {
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
        "profiles": _setProfiles(),
        "indexers": _setIndexers(),
        "lunasea": LunaSeaDatabase().export(),
        HomeConstants.MODULE_KEY: HomeDatabase().export(),
    });
}
