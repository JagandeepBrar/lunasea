import 'package:lunasea/vendor.dart';

part 'change.g.dart';

@JsonSerializable()
class Change {
  @JsonKey()
  String module;

  @JsonKey()
  List<String> changes;

  Change({
    required this.module,
    required this.changes,
  });

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() {
    return _$ChangeToJson(this);
  }

  factory Change.fromJson(Map<String, dynamic> json) {
    return _$ChangeFromJson(json);
  }
}
