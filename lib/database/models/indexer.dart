import 'package:lunasea/core.dart';

part 'indexer.g.dart';

@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'LunaIndexerAdapter')
class LunaIndexer extends HiveObject {
  @JsonKey()
  @HiveField(0, defaultValue: '')
  String displayName;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String host;

  @JsonKey(name: 'key')
  @HiveField(2, defaultValue: '')
  String apiKey;

  @JsonKey()
  @HiveField(3, defaultValue: <String, String>{})
  Map<String, String> headers;

  LunaIndexer._internal({
    required this.displayName,
    required this.host,
    required this.apiKey,
    required this.headers,
  });

  factory LunaIndexer({
    String? displayName,
    String? host,
    String? apiKey,
    Map<String, String>? headers,
  }) {
    return LunaIndexer._internal(
      displayName: displayName ?? '',
      host: host ?? '',
      apiKey: apiKey ?? '',
      headers: headers ?? {},
    );
  }

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$LunaIndexerToJson(this);

  factory LunaIndexer.fromJson(Map<String, dynamic> json) {
    return _$LunaIndexerFromJson(json);
  }

  factory LunaIndexer.clone(LunaIndexer profile) {
    return LunaIndexer.fromJson(profile.toJson());
  }

  factory LunaIndexer.get(String key) {
    return LunaBox.indexers.read(key)!;
  }
}
