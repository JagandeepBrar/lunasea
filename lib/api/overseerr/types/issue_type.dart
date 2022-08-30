import 'package:lunasea/core.dart';

const _VIDEO = 1;
const _AUDIO = 2;
const _SUBTITLE = 3;
const _OTHER = 4;

@JsonEnum()
enum OverseerrIssueType {
  @JsonValue(_VIDEO)
  VIDEO,
  @JsonValue(_AUDIO)
  AUDIO,
  @JsonValue(_SUBTITLE)
  SUBTITLE,
  @JsonValue(_OTHER)
  OTHER,
}

extension OverseerrIssueTypeExtension on OverseerrIssueType {
  int get key {
    switch (this) {
      case OverseerrIssueType.VIDEO:
        return _VIDEO;
      case OverseerrIssueType.AUDIO:
        return _AUDIO;
      case OverseerrIssueType.SUBTITLE:
        return _SUBTITLE;
      case OverseerrIssueType.OTHER:
        return _OTHER;
    }
  }

  String get name {
    switch (this) {
      case OverseerrIssueType.VIDEO:
        return 'overseerr.Video'.tr();
      case OverseerrIssueType.AUDIO:
        return 'overseerr.Audio'.tr();
      case OverseerrIssueType.SUBTITLE:
        return 'overseerr.Subtitle'.tr();
      case OverseerrIssueType.OTHER:
        return 'overseerr.Other'.tr();
    }
  }
}
