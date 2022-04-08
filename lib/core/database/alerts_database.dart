import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum AlertsDatabaseValue {
  PREVIOUS_BUILD,
}

extension AlertsDatabaseValueExtension on AlertsDatabaseValue {
  String get key {
    return 'ALERTS_${this.name}';
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

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case AlertsDatabaseValue.PREVIOUS_BUILD:
        return value is String;
    }
  }

  dynamic get _defaultValue {
    switch (this) {
      case AlertsDatabaseValue.PREVIOUS_BUILD:
        return '0.0.0';
    }
  }

  ValueListenableBuilder listen({
    Key? key,
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.alerts.box.listenable(keys: [this.key]),
      builder: builder,
    );
  }
}
