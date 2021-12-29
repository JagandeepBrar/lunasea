import 'package:flutter/material.dart';
import 'package:lunasea/core/database/database.dart';
import 'package:lunasea/core/utilities/logger.dart';

enum AlertsDatabaseValue {
  CHANGELOG,
}

extension AlertsDatabaseValueExtension on AlertsDatabaseValue {
  String get key {
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        return 'ALERTS_CHANGELOG';
    }
    throw Exception('key not found');
  }

  dynamic get data {
    final box = Database.alertsBox;
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        return box.get(this.key, defaultValue: '');
    }
    throw Exception('data not found');
  }

  void put(dynamic value) {
    final box = Database.alertsBox;
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        if (value.runtimeType == String) box.put(this.key, value);
        return;
    }
    LunaLogger().warning(
      'AlertsDatabaseValueExtension',
      'put',
      'Attempted to enter data for invalid AlertsDatabaseValue: ${this?.toString() ?? 'null'}',
    );
  }

  ValueListenableBuilder listen({
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) =>
      ValueListenableBuilder(
        valueListenable: Database.alertsBox.listenable(keys: [this.key]),
        builder: builder,
      );
}
