import 'package:lunasea/core.dart';

part 'external_module.g.dart';

@JsonSerializable()
@HiveType(typeId: 26, adapterName: 'LunaExternalModuleAdapter')
class LunaExternalModule extends HiveObject {
  @JsonKey()
  @HiveField(0, defaultValue: '')
  String displayName;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String host;

  LunaExternalModule({
    this.displayName = '',
    this.host = '',
  });

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$LunaExternalModuleToJson(this);

  factory LunaExternalModule.fromJson(Map<String, dynamic> json) {
    return _$LunaExternalModuleFromJson(json);
  }

  factory LunaExternalModule.clone(LunaExternalModule profile) {
    return LunaExternalModule.fromJson(profile.toJson());
  }

  factory LunaExternalModule.get(String key) {
    return LunaBox.externalModules.read(key)!;
  }
}
