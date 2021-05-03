import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum HeaderType {
  GENERIC,
  AUTHORIZATION,
}

extension HeaderTypeExtension on HeaderType {
  String get name {
    switch (this) {
      case HeaderType.GENERIC:
        return 'settings.Custom'.tr();
      case HeaderType.AUTHORIZATION:
        return 'settings.BasicAuthentication'.tr();
    }
    throw Exception('Invalid HeaderType');
  }

  IconData get icon {
    switch (this) {
      case HeaderType.GENERIC:
        return Icons.device_hub;
      case HeaderType.AUTHORIZATION:
        return Icons.verified_user;
    }
    throw Exception('Invalid HeaderType');
  }
}
