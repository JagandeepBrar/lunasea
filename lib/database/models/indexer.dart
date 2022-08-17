import 'package:lunasea/core.dart';
import 'package:lunasea/types/indexer_icon.dart';

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

  @JsonKey()
  @HiveField(4)
  LunaIndexerIcon? icon;

  LunaIndexer({
    this.displayName = '',
    this.host = '',
    this.apiKey = '',
    this.headers = const {},
    this.icon,
  });

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
