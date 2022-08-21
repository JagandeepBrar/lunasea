import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/sheets/changelog/change.dart';

part 'changelog.g.dart';

@JsonSerializable()
class Changelog {
  @JsonKey()
  String? motd;

  @JsonKey(name: 'feat')
  Map<String, List<Change>>? feat;

  @JsonKey(name: 'refactor')
  Map<String, List<Change>>? tweaks;

  @JsonKey(name: 'fix')
  Map<String, List<Change>>? fixes;

  @JsonKey(name: 'docs')
  Map<String, List<Change>>? docs;

  @JsonKey(name: 'chore')
  Map<String, List<Change>>? chores;

  @JsonKey(name: 'release')
  Map<String, List<Change>>? release;

  Changelog({
    this.motd,
    this.feat,
    this.tweaks,
    this.fixes,
    this.docs,
    this.chores,
    this.release,
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
