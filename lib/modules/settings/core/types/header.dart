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
  }

  IconData get icon {
    switch (this) {
      case HeaderType.GENERIC:
        return Icons.device_hub_rounded;
      case HeaderType.AUTHORIZATION:
        return Icons.verified_user_rounded;
    }
  }
}
