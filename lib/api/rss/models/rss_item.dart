import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/system/logger.dart';
import 'package:xml/xml.dart';

import 'rss_category.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';

class RssItem {
  final Map<String, String> fields;
  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory>? categories;
  final String? guid;
  final String? pubDate;
  DateTime? get publishDate => _parseDateTime(pubDate);

  bool isRecent;

  RssItem({
    required this.fields,
    this.title,
    this.description,
    this.link,
    this.categories,
    this.guid,
    this.pubDate,
    this.isRecent = false,
  });

  factory RssItem.parse(XmlElement element) {
    List<RssCategory>? categories = element
        .findElements('category')
        .map((e) => RssCategory.parse(e))
        .toList();

    Map<String, String> fields = {};
    for (var v in element.childElements) {
      if (!["title", "description", "link", "category", "guid", "pubdate"]
          .contains(v.name.qualified.toLowerCase())) {
        if (v.name.local == "category") {
          categories.add(RssCategory(v.name.prefix, v.text));
        }
        fields[v.name.local] = v.text;
      }
    }

    return RssItem(
      fields: fields,
      title: element.findElements('title').firstOrNull?.text,
      description: element.findElements('description').firstOrNull?.text,
      link: element.findElements('link').firstOrNull?.text,
      categories: categories,
      guid: element.findElements('guid').firstOrNull?.text,
      pubDate: element.findElements('pubDate').firstOrNull?.text,
    );
  }

  DateTime? _parseDateTime(dateString) {
    if (dateString == null) return null;
    // return _parseIso8601DateTime(dateString);
    return _parseRfc822DateTime(dateString) ??
        _parseIso8601DateTime(dateString);
  }

  DateTime? _parseRfc822DateTime(String dateString) {
    try {
      final format = DateFormat(rfc822DatePattern, 'en_US');
      DateTime d = format.parse(dateString, true);

      //DateFormat doesn't support timezones
      final tz = RegExp(r'(\+|-)([0-9]{4})$');
      final match = tz.firstMatch(dateString);
      if (match != null) {
        var duration = Duration(
            hours: int.parse(match.group(2)!.substring(0, 2)),
            minutes: int.parse(match.group(2)!.substring(2, 4)));
        if (match.group(1) == '+') d = d.subtract(duration);
        if (match.group(1) == '-') d = d.add(duration);
      }
      return d;
    } on FormatException catch (error, stack) {
      LunaLogger()
          .error('RSS: Failed to parse Rfc822 date $dateString', error, stack);
      return null;
    }
  }

  DateTime? _parseIso8601DateTime(dateString) {
    try {
      return DateTime.parse(dateString);
    } on FormatException catch (error, stack) {
      LunaLogger()
          .error('RSS: Failed to parse Iso8601 date $dateString', error, stack);
      return null;
    }
  }
}
