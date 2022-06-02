import 'package:flutter/foundation.dart';
import 'package:lunasea/core/models/configuration/external_module.dart';
import 'package:lunasea/core/models/configuration/indexer.dart';
import 'package:lunasea/core/models/configuration/profile.dart';
import 'package:lunasea/core/models/logs/log.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/vendor.dart';

enum LunaBox<T> {
  alerts<dynamic>('alerts'),
  externalModules<ExternalModuleHiveObject>('external_modules'),
  indexers<IndexerHiveObject>('indexers'),
  logs<LunaLogHiveObject>('logs'),
  lunasea<dynamic>('lunasea'),
  profiles<ProfileHiveObject>('profiles');

  final String key;
  const LunaBox(this.key);

  Box<T> get _instance => Hive.box<T>(key);

  Map<dynamic, T> get data => _instance.toMap();
  int get size => _instance.length;
  bool get isEmpty => _instance.isEmpty;

  static Future<void> open() async {
    for (final box in LunaBox.values) await box._open();
  }

  T? read(dynamic key, {T? fallback}) {
    return _instance.get(key, defaultValue: fallback);
  }

  T? readAt(int index) {
    return _instance.getAt(index);
  }

  bool contains(dynamic key) {
    return _instance.containsKey(key);
  }

  Future<int> create(T value) async {
    return _instance.add(value);
  }

  Future<void> update(dynamic key, T value) {
    return _instance.put(key, value);
  }

  Future<void> delete(dynamic key) async {
    return _instance.delete(key);
  }

  ValueListenable<Box<T>> listenable([List<dynamic>? keys]) {
    return _instance.listenable(keys: keys);
  }

  Future<void> clear() async {
    _instance.keys.forEach((k) async => await _instance.delete(k));
  }

  Future<Box<T>> _open() async {
    return Hive.openBox<T>(key);
  }
}

extension LunaBoxExtension on LunaBox {
  /// This only works for boxes that are typed specifically for a hive object
  /// Should be improved to actually support every box.
  List<Map<String, dynamic>> export() {
    try {
      return _instance.keys
          .map<Map<String, dynamic>>((k) => _instance.get(k)!.toMap())
          .toList();
    } catch (error, stack) {
      LunaLogger().error('Failed to export LunaBox', error, stack);
      return [];
    }
  }
}
