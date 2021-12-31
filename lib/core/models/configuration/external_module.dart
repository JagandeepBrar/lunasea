import 'package:lunasea/core.dart';

part 'external_module.g.dart';

/// Hive database object containing all information on an indexer
@HiveType(typeId: 26, adapterName: 'ExternalModuleHiveObjectAdapter')
class ExternalModuleHiveObject extends HiveObject {
  /// Create a new [ExternalModuleHiveObject] object with all fields set to empty values('', false, 0, {}, etc.)
  factory ExternalModuleHiveObject.empty() => ExternalModuleHiveObject(
        displayName: '',
        host: '',
      );

  /// Create a new [ExternalModuleHiveObject] from another [ExternalModuleHiveObject] (deep-copy).
  factory ExternalModuleHiveObject.fromExternalModuleHiveObject(
          ExternalModuleHiveObject indexer) =>
      ExternalModuleHiveObject(
        displayName: indexer.displayName,
        host: indexer.host,
      );

  /// Create a new [ExternalModuleHiveObject] from a map where the keys map 1-to-1 except for "key", which was the old key for apiKey.
  ///
  /// - Does _not_ do type checking, and will throw an error if the type is invalid.
  /// - If the key is null, sets to the "empty" value
  factory ExternalModuleHiveObject.fromMap(Map module) =>
      ExternalModuleHiveObject(
        displayName: module['displayName'] ?? '',
        host: module['host'] ?? '',
      );

  ExternalModuleHiveObject({
    required this.displayName,
    required this.host,
  });

  @override
  String toString() => toMap().toString();

  Map<String, dynamic> toMap() => {
        "displayName": displayName ?? '',
        "host": host ?? '',
      };

  @HiveField(0)
  String? displayName;
  @HiveField(1)
  String? host;
}
