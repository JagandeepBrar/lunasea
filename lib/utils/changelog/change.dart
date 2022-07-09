import 'package:lunasea/vendor.dart';

part 'change.g.dart';

@JsonSerializable()
class Change {
  @JsonKey()
  String commit;

  @JsonKey()
  String message;

  Change({
    required this.commit,
    required this.message,
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
