import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum TautulliDatabaseValue {
  NAVIGATION_INDEX,
  NAVIGATION_INDEX_GRAPHS,
  NAVIGATION_INDEX_LIBRARIES_DETAILS,
  NAVIGATION_INDEX_MEDIA_DETAILS,
  NAVIGATION_INDEX_USER_DETAILS,
  REFRESH_RATE,
  CONTENT_LOAD_LENGTH,
  STATISTICS_STATS_COUNT,
  TERMINATION_MESSAGE,
  GRAPHS_DAYS,
  GRAPHS_LINECHART_DAYS,
  GRAPHS_MONTHS,
}

class TautulliDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {}

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (TautulliDatabaseValue value in TautulliDatabaseValue.values) {
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
      TautulliDatabaseValue value = valueFromKey(key);
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
  TautulliDatabaseValue valueFromKey(String key) {
    for (TautulliDatabaseValue value in TautulliDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension TautulliDatabaseValueExtension on TautulliDatabaseValue {
  String get key {
    return 'TAUTULLI_${this.name}';
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

  dynamic get _defaultValue {
    switch (this) {
      case TautulliDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS:
        return 0;
      case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS:
        return 0;
      case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS:
        return 0;
      case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS:
        return 0;
      case TautulliDatabaseValue.REFRESH_RATE:
        return 10;
      case TautulliDatabaseValue.CONTENT_LOAD_LENGTH:
        return 125;
      case TautulliDatabaseValue.STATISTICS_STATS_COUNT:
        return 3;
      case TautulliDatabaseValue.TERMINATION_MESSAGE:
        return '';
      case TautulliDatabaseValue.GRAPHS_DAYS:
        return 30;
      case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS:
        return 14;
      case TautulliDatabaseValue.GRAPHS_MONTHS:
        return 6;
    }
    throw Exception('Invalid TautulliDatabaseValue');
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case TautulliDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS:
        return value is int;
      case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS:
        return value is int;
      case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS:
        return value is int;
      case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS:
        return value is int;
      case TautulliDatabaseValue.REFRESH_RATE:
        return value is int;
      case TautulliDatabaseValue.CONTENT_LOAD_LENGTH:
        return value is int;
      case TautulliDatabaseValue.STATISTICS_STATS_COUNT:
        return value is int;
      case TautulliDatabaseValue.TERMINATION_MESSAGE:
        return value is String;
      case TautulliDatabaseValue.GRAPHS_DAYS:
        return value is int;
      case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS:
        return value is int;
      case TautulliDatabaseValue.GRAPHS_MONTHS:
        return value is int;
    }
    throw Exception('Invalid TautulliDatabaseValue');
  }
}
