import 'package:lunasea/core.dart';

part 'keyword.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrKeyword {
  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  OverseerrKeyword({
    this.id,
    this.name,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrKeyword.fromJson(Map<String, dynamic> json) =>
      _$OverseerrKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrKeywordToJson(this);
}
