import 'package:lunasea/core.dart';

part 'genre.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrGenre {
  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  OverseerrGenre({
    this.id,
    this.name,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrGenre.fromJson(Map<String, dynamic> json) =>
      _$OverseerrGenreFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrGenreToJson(this);
}
