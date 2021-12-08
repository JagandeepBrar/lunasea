import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum SearchDatabaseValue {
  HIDE_XXX,
  SHOW_LINKS,
}

class SearchDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (SearchDatabaseValue value in SearchDatabaseValue.values) {
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
      SearchDatabaseValue value = valueFromKey(key);
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
  SearchDatabaseValue valueFromKey(String key) {
    for (SearchDatabaseValue value in SearchDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension SearchDatabaseValueExtension on SearchDatabaseValue {
  String get key {
    return 'SEARCH_${this.name}';
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
      case SearchDatabaseValue.HIDE_XXX:
        return value is bool;
      case SearchDatabaseValue.SHOW_LINKS:
        return value is bool;
    }
    throw Exception('Invalid SearchDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case SearchDatabaseValue.HIDE_XXX:
        return false;
      case SearchDatabaseValue.SHOW_LINKS:
        return true;
    }
    throw Exception('Invalid SearchDatabaseValue');
  }
}
