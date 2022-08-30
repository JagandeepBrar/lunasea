import 'package:lunasea/core.dart';

part 'spoken_language.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrSpokenLanguage {
  @JsonKey()
  String? englishName;

  @JsonKey(name: 'english_name')
  String? englishNameSecondary;

  @JsonKey(name: 'iso_639_1')
  String? iso6391;

  @JsonKey()
  String? name;

  OverseerrSpokenLanguage({
    this.englishName,
    this.englishNameSecondary,
    this.iso6391,
    this.name,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrSpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$OverseerrSpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrSpokenLanguageToJson(this);
}
