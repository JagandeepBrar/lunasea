import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/database/table.dart';

class LunaConfig {
  Future<void> import(BuildContext context, String data) async {
    await LunaDatabase().clear();

    try {
      Map config = json.decode(data);
      _setProfiles(config[BOX_PROFILES_KEY]);
      _setIndexers(config[BOX_INDEXERS_KEY]);
      _setExternalModules(config[BOX_EXTERNAL_MODULES_KEY]);
      for (final table in LunaTable.values) table.import(config[table.key]);
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to import configuration, resetting to default',
        error,
        stack,
      );
      LunaDatabase().bootstrap();
    }

    LunaState.reset(context);
  }

  String export() {
    Map<String, dynamic> config = {};
    config[BOX_EXTERNAL_MODULES_KEY] = LunaBox.externalModules.export();
    config[BOX_INDEXERS_KEY] = LunaBox.indexers.export();
    config[BOX_PROFILES_KEY] = LunaBox.profiles.export();
    for (final table in LunaTable.values) config[table.key] = table.export();

    return json.encode(config);
  }

  void _setProfiles(List? data) {
    if (data == null) return;

    for (final item in data) {
      final key = item['key'];
      final obj = ProfileHiveObject.fromMap(item);
      LunaBox.profiles.box.put(key, obj);
    }
  }

  void _setIndexers(List? data) {
    if (data == null) return;

    for (final indexer in data) {
      final obj = IndexerHiveObject.fromMap(indexer);
      LunaBox.indexers.box.add(obj);
    }
  }

  void _setExternalModules(List? data) {
    if (data == null) return;

    for (final module in data) {
      final obj = ExternalModuleHiveObject.fromMap(module);
      LunaBox.externalModules.box.add(obj);
    }
  }
}
