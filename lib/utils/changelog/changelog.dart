import 'package:lunasea/vendor.dart';
import 'package:lunasea/utils/changelog/change.dart';

part 'changelog.g.dart';

@JsonSerializable()
class Changelog {
  @JsonKey()
  String? motd;

  @JsonKey(name: 'feat')
  List<Change>? feat;

  @JsonKey(name: 'refactor')
  List<Change>? tweaks;

  @JsonKey(name: 'fix')
  List<Change>? fixes;

  @JsonKey(name: 'docs')
  List<Change>? docs;

  @JsonKey(name: 'chore')
  List<Change>? chores;

  Changelog({
    this.motd,
    this.feat,
    this.tweaks,
    this.fixes,
    this.docs,
    this.chores,
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
