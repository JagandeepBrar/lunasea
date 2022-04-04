import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum RssDatabaseValue {
  SYNC,
  REFRESH_RATE,
}

class RssDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (RssDatabaseValue value in RssDatabaseValue.values) {
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
      RssDatabaseValue? value = valueFromKey(key);
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
  RssDatabaseValue? valueFromKey(String key) {
    for (RssDatabaseValue value in RssDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension RssDatabaseValueExtension on RssDatabaseValue {
  String get key {
    return 'RSS_${this.name}';
  }

  dynamic get data {
    return Database.lunasea.box.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunasea.box.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key? key,
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunasea.box.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case RssDatabaseValue.SYNC:
        return value is bool;
      case RssDatabaseValue.REFRESH_RATE:
        return value is int;
    }
  }

  dynamic get _defaultValue {
    switch (this) {
      case RssDatabaseValue.SYNC:
        return false;
      case RssDatabaseValue.REFRESH_RATE:
        return 300;
    }
  }
}
