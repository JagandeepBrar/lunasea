import 'package:lunasea/core.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrCollection {
  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  @JsonKey()
  String? posterPath;

  @JsonKey()
  String? backdropPath;

  OverseerrCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrCollection.fromJson(Map<String, dynamic> json) =>
      _$OverseerrCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrCollectionToJson(this);
}
