import 'package:lunasea/core.dart';

const _MOVIE = 'movie';
const _TV = 'tv';

@JsonEnum()
enum OverseerrMediaType {
  @JsonValue(_MOVIE)
  MOVIE,
  @JsonValue(_TV)
  TV,
}

extension OverseerrMediaTypeExtension on OverseerrMediaType {
  String get key {
    switch (this) {
      case OverseerrMediaType.MOVIE:
        return _MOVIE;
      case OverseerrMediaType.TV:
        return _TV;
    }
  }
}
