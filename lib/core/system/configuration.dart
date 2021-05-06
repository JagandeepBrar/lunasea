import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaConfiguration {
  static const String _EXTERNAL_MODULES_KEY = 'external_modules';
  static const String _INDEXERS_KEY = 'indexers';
  static const String _LUNASEA_KEY = 'lunasea';
  static const String _PROFILES_KEY = 'profiles';

  /// Returns a list of all profiles converted to a map.
  List<Map<String, dynamic>> _getProfiles() {
    List<Map<String, dynamic>> _data = [];
    for (var key in Database.profilesBox.keys)
      _data.add(Database.profilesBox.get(key).toMap());
    return _data;
  }

  /// Given a list of map objects, creates or updates profiles for each object.
  void _setProfiles(List data) {
    Box<dynamic> box = Database.profilesBox;
    for (Map profile in data)
      box.put(profile['key'], ProfileHiveObject.fromMap(profile));
  }

  /// Returns a list of all indexers converted to a map.
  List<Map<String, dynamic>> _getIndexers() {
    List<Map<String, dynamic>> _data = [];
    for (var key in Database.indexersBox.keys)
      _data.add(Database.indexersBox.get(key).toMap());
    return _data;
  }

  /// Given a list of map objects, creates or updates indexers for each object.
  void _setIndexers(List data) {
    Box<dynamic> box = Database.indexersBox;
    for (Map indexer in data) box.add(IndexerHiveObject.fromMap(indexer));
  }

  /// Returns a list of all external modules converted to a map.
  List<Map<String, dynamic>> _getExternalModules() {
    List<Map<String, dynamic>> _data = [];
    for (var key in Database.externalModulesBox.keys)
      _data.add(Database.externalModulesBox.get(key).toMap());
    return _data;
  }

  /// Given a list of map objects, creates or updates external modules for each object.
  void _setExternalModules(List data) {
    Box<dynamic> box = Database.externalModulesBox;
    for (Map module in data) box.add(ExternalModuleHiveObject.fromMap(module));
  }

  /// Import the entire configuration from a JSON-encoded string (typically read through a `.lunasea` backup file).
  ///
  /// - Clears all boxes
  /// - Calls [_setProfiles], [_setIndexers], and [_setExternalModules].
  /// - Calls `import()` on all module databases, which implement [LunaDatabase].
  /// - Resets the application state
  ///
  /// On a failed import, resets LunaSea back to the default/base state
  Future<void> import(BuildContext context, String data) async {
    Map config = json.decode(data);
    Database().clearAllBoxes();
    try {
      if (config[_PROFILES_KEY] != null) _setProfiles(config[_PROFILES_KEY]);
      if (config[_INDEXERS_KEY] != null) _setIndexers(config[_INDEXERS_KEY]);
      if (config[_EXTERNAL_MODULES_KEY] != null)
        _setExternalModules(config[_EXTERNAL_MODULES_KEY]);
      if (config[_LUNASEA_KEY] != null)
        LunaDatabase().import(config[_LUNASEA_KEY]);
      LunaModule.values.forEach((module) {
        if (config[module.key] != null)
          module.database?.import(config[module.key]);
      });
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to import configuration, resetting to default',
        error,
        stack,
      );
      Database().setDefaults();
    }
    // Reset the entire app's state
    LunaState.reset(context);
  }

  /// Converts the entire application configuration/database into a JSON string.
  ///
  /// - Calls `_getProfiles()` and `_getIndexers()`
  /// - Calls `export()` on all module databases, which implement [LunaModuleDatabase].
  String export() {
    Map<String, dynamic> config = {
      _EXTERNAL_MODULES_KEY: _getExternalModules(),
      _INDEXERS_KEY: _getIndexers(),
      _PROFILES_KEY: _getProfiles(),
      _LUNASEA_KEY: LunaDatabase().export(),
    };
    LunaModule.values.forEach((module) {
      if (module.database != null)
        config[module.key] = module.database.export();
    });
    return json.encode(config);
  }
}
