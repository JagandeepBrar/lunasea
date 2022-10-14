import 'package:lunasea/api/rss/models/rss_feed.dart';
import 'package:lunasea/api/rss/models/rss_item.dart';
import 'package:lunasea/core.dart';

part 'rss.g.dart';

@JsonSerializable()
@HiveType(typeId: 30, adapterName: 'LunaRssAdapter')
class LunaRss extends HiveObject {
  @JsonKey()
  @HiveField(0, defaultValue: '')
  String displayName;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String url;

  @JsonKey()
  @HiveField(2, defaultValue: '')
  String include;

  @JsonKey()
  @HiveField(3, defaultValue: '')
  String exclude;

  @JsonKey()
  @HiveField(4, defaultValue: <String, String>{})
  Map<String, String> headers;

  @JsonKey()
  @HiveField(5)
  DateTime? syncDate;

  @JsonKey()
  int recent = 0;

  @JsonKey()
  DateTime? lastItemDate;

  LunaRss._internal({
    required this.displayName,
    required this.url,
    required this.include,
    required this.exclude,
    required this.headers,
  });

  factory LunaRss({
    String? displayName,
    String? url,
    String? include,
    String? exclude,
    Map<String, String>? headers,
  }) {
    return LunaRss._internal(
      displayName: displayName ?? '',
      url: url ?? '',
      include: include ?? '',
      exclude: exclude ?? '',
      headers: headers ?? {},
    );
  }

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$LunaRssToJson(this);

  factory LunaRss.fromJson(Map<String, dynamic> json) {
    return _$LunaRssFromJson(json);
  }

  factory LunaRss.clone(LunaRss profile) {
    return LunaRss.fromJson(profile.toJson());
  }

  factory LunaRss.get(String key) {
    return LunaBox.rss.read(key)!;
  }

  void applyFilter(RssFeed value) {
    int recent = 0;
    List<RssItem> items = value.items!
        .where((item) =>
            this.include!.isEmpty ||
            item.title!.contains(RegExp("(${this.include!})")))
        .where((item) =>
            this.exclude!.isEmpty ||
            !item.title!.contains(RegExp("(${this.exclude!})")))
        .onEach((item) {
      item.isRecent =
          this.syncDate == null || !this.syncDate!.isAfter(item.publishDate!);
      if (item.isRecent) ++recent;
    }).toList();

    value.filteredItems = items;
    this.recent = recent;
    this.lastItemDate = value.filteredItems!.first!.publishDate;
  }
}
