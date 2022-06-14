import 'package:lunasea/vendor.dart';
import 'package:lunasea/utils/changelog/change.dart';

part 'changelog.g.dart';

@JsonSerializable()
class Changelog {
  @JsonKey()
  String? motd;

  @JsonKey(name: 'new')
  List<Change>? feat;

  @JsonKey(name: 'tweaks')
  List<Change>? tweaks;

  @JsonKey(name: 'fixes')
  List<Change>? fixes;

  Changelog({
    this.motd,
    this.feat,
    this.tweaks,
    this.fixes,
  });

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() {
    return _$ChangelogToJson(this);
  }

  factory Changelog.fromJson(Map<String, dynamic> json) {
    return _$ChangelogFromJson(json);
  }
}
