import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/database/models/external_module.dart';
import 'package:lunasea/database/models/indexer.dart';
import 'package:lunasea/database/table.dart';

class LunaConfig {
  Future<void> import(BuildContext context, String data) async {
    await LunaDatabase().clear();

    try {
      Map config = json.decode(data);
      _setProfiles(config[LunaBox.profiles.key]);
      _setIndexers(config[LunaBox.indexers.key]);
      _setExternalModules(config[LunaBox.externalModules.key]);
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
    config[LunaBox.externalModules.key] = LunaBox.externalModules.export();
    config[LunaBox.indexers.key] = LunaBox.indexers.export();
    config[LunaBox.profiles.key] = LunaBox.profiles.export();
    for (final table in LunaTable.values) config[table.key] = table.export();

    return json.encode(config);
  }

  void _setProfiles(List? data) {
    if (data == null) return;

    for (final item in data) {
      final key = item['key'];
      final obj = LunaProfile.fromJson((item as Map).cast<String, dynamic>());
      LunaBox.profiles.update(key, obj);
    }
  }

  void _setIndexers(List? data) {
    if (data == null) return;

    for (final indexer in data) {
      final obj = LunaIndexer.fromJson(indexer);
      LunaBox.indexers.create(obj);
    }
  }

  void _setExternalModules(List? data) {
    if (data == null) return;

    for (final module in data) {
      final obj = LunaExternalModule.fromJson(module);
      LunaBox.externalModules.create(obj);
    }
  }
}
