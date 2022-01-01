import 'package:lunasea/core.dart';

part 'qualityprofile.g.dart';

@HiveType(typeId: 6, adapterName: 'DeprecatedRadarrQualityProfileAdapter')
class DeprecatedRadarrQualityProfile extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  factory DeprecatedRadarrQualityProfile.empty() =>
      DeprecatedRadarrQualityProfile(
        id: -1,
        name: '',
      );

  DeprecatedRadarrQualityProfile({
    required this.id,
    required this.name,
  });
}
