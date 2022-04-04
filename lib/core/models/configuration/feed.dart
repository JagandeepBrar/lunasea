import 'package:lunasea/core.dart';

part 'feed.g.dart';

/// Hive database object containing all information on an indexer
@HiveType(typeId: 30, adapterName: 'FeedHiveObjectAdapter')
class FeedHiveObject extends HiveObject {
  /// Create a new [FeedHiveObject] object with all fields set to empty values('', false, 0, {}, etc.)
  factory FeedHiveObject.empty() => FeedHiveObject(
        displayName: '',
        url: '',
        include: '',
        exclude: '',
      );

  /// Create a new [FeedHiveObject] from another [FeedHiveObject] (deep-copy).
  factory FeedHiveObject.fromIndexerHiveObject(FeedHiveObject feed) =>
      FeedHiveObject(
        displayName: feed.displayName,
        url: feed.url,
        include: feed.include,
        exclude: feed.exclude,
      );

  /// Create a new [FeedHiveObject] from a map where the keys map 1-to-1 except for "key", which was the old key for apiKey.
  ///
  /// - Does _not_ do type checking, and will throw an error if the type is invalid.
  /// - If the key is null, sets to the "empty" value
  factory FeedHiveObject.fromMap(Map feed) => FeedHiveObject(
        displayName: feed['displayName'] ?? '',
        url: feed['url'] ?? '',
        include: feed['include'] ?? '',
        exclude: feed['exclude'] ?? '',
      );

  FeedHiveObject({
    required this.displayName,
    required this.url,
    required this.include,
    required this.exclude,
  });

  @override
  String toString() => toMap().toString();

  Map<String, dynamic> toMap() => {
        "displayName": displayName ?? '',
        "url": url ?? '',
        "include": include ?? '',
        "exclude": exclude ?? '',
      };

  @HiveField(0)
  String? displayName;
  @HiveField(1)
  String? url;
  @HiveField(2)
  String? include;
  @HiveField(3)
  String? exclude;
}
