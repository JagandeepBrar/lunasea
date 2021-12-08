import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum NZBGetDatabaseValue {
  NAVIGATION_INDEX,
}

class NZBGetDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (NZBGetDatabaseValue value in NZBGetDatabaseValue.values) {
      switch (value) {
        // Primitive values
        default:
          data[value.key] = value.data;
          break;
      }
    }
    return data;
  }

  @override
  void import(Map<String, dynamic> config) {
    for (String key in config.keys) {
      NZBGetDatabaseValue value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  NZBGetDatabaseValue valueFromKey(String key) {
    for (NZBGetDatabaseValue value in NZBGetDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension NZBGetDatabaseValueExtension on NZBGetDatabaseValue {
  String get key {
    return 'NZBGET_${this.name}';
  }

  dynamic get data {
    return Database.lunaSeaBox.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunaSeaBox.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key key,
    @required Widget Function(BuildContext, dynamic, Widget) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case NZBGetDatabaseValue.NAVIGATION_INDEX:
        return value is int;
    }
    throw Exception('Invalid NZBGetDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case NZBGetDatabaseValue.NAVIGATION_INDEX:
        return 0;
    }
    throw Exception('Invalid NZBGetDatabaseValue');
  }
}
