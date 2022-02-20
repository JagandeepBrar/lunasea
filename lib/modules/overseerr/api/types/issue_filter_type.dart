import 'package:lunasea/core.dart';

const _ALL = 'all';
const _OPEN = 'open';
const _RESOLVED = 'resolved';

@JsonEnum()
enum OverseerrIssueFilterType {
  @JsonValue(_ALL)
  ALL,
  @JsonValue(_OPEN)
  OPEN,
  @JsonValue(_RESOLVED)
  RESOLVED,
}

extension OverseerrIssueFilterTypeExtension on OverseerrIssueFilterType {
  String get key {
    switch (this) {
      case OverseerrIssueFilterType.ALL:
        return _ALL;
      case OverseerrIssueFilterType.OPEN:
        return _OPEN;
      case OverseerrIssueFilterType.RESOLVED:
        return _RESOLVED;
    }
  }
}
