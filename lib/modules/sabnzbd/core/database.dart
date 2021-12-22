import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum SABnzbdDatabaseValue {
  NAVIGATION_INDEX,
}

class SABnzbdDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (SABnzbdDatabaseValue value in SABnzbdDatabaseValue.values) {
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
      SABnzbdDatabaseValue value = valueFromKey(key);
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
  SABnzbdDatabaseValue valueFromKey(String key) {
    for (SABnzbdDatabaseValue value in SABnzbdDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension SABnzbdDatabaseValueExtension on SABnzbdDatabaseValue {
  String get key {
    return 'SABNZBD_${this.name}';
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
      case SABnzbdDatabaseValue.NAVIGATION_INDEX:
        return value is int;
    }
    throw Exception('Invalid SABnzbdDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case SABnzbdDatabaseValue.NAVIGATION_INDEX:
        return 0;
    }
    throw Exception('Invalid SABnzbdDatabaseValue');
  }
}
