import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

const _OPEN = 1;
const _RESOLVED = 2;

@JsonEnum()
enum OverseerrIssueStatus {
  @JsonValue(_OPEN)
  OPEN,
  @JsonValue(_RESOLVED)
  RESOLVED,
}

extension OverseerrIssueStatusExtension on OverseerrIssueStatus {
  int get key {
    switch (this) {
      case OverseerrIssueStatus.OPEN:
        return _OPEN;
      case OverseerrIssueStatus.RESOLVED:
        return _RESOLVED;
    }
  }

  String get name {
    switch (this) {
      case OverseerrIssueStatus.OPEN:
        return 'overseerr.Open'.tr();
      case OverseerrIssueStatus.RESOLVED:
        return 'overseerr.Resolved'.tr();
    }
  }

  Color get color {
    switch (this) {
      case OverseerrIssueStatus.OPEN:
        return LunaColours.orange;
      case OverseerrIssueStatus.RESOLVED:
        return LunaColours.accent;
    }
  }
}
