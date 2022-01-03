import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum AlertsDatabaseValue {
  CHANGELOG,
}

extension AlertsDatabaseValueExtension on AlertsDatabaseValue {
  String get key {
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        return 'ALERTS_CHANGELOG';
    }
  }

  dynamic get data {
    final box = Database.alerts.box;
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        return box.get(this.key, defaultValue: '');
    }
  }

  void put(dynamic value) {
    final box = Database.alerts.box;
    switch (this) {
      case AlertsDatabaseValue.CHANGELOG:
        if (value.runtimeType == String) box.put(this.key, value);
        return;
    }
  }

  ValueListenableBuilder listen({
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) =>
      ValueListenableBuilder(
        valueListenable: Database.alerts.box.listenable(keys: [this.key]),
        builder: builder,
      );
}
