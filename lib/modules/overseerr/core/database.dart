import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum OverseerrDatabaseValue {
  NAVIGATION_INDEX,
  CONTENT_PAGE_SIZE,
}

class OverseerrDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (OverseerrDatabaseValue value in OverseerrDatabaseValue.values) {
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
      OverseerrDatabaseValue value = valueFromKey(key);
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
  OverseerrDatabaseValue valueFromKey(String key) {
    for (OverseerrDatabaseValue value in OverseerrDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension OverseerrDatabaseValueExtension on OverseerrDatabaseValue {
  String get key {
    return 'OVERSEERR_${this.name}';
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
      case OverseerrDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case OverseerrDatabaseValue.CONTENT_PAGE_SIZE:
        return value is int;
    }
    throw Exception('Invalid OverseerrDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case OverseerrDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case OverseerrDatabaseValue.CONTENT_PAGE_SIZE:
        return 25;
    }
    throw Exception('Invalid OverseerrDatabaseValue');
  }
}
