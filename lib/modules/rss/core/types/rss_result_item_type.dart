import 'package:intl/intl.dart';
import 'package:xml/xml.dart';
import '../parse/rss_category.dart';
import '../parse/rss_item.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';

class RssResultItem {

  final RssItem _item;

  RssResultItem(this._item);

  String? get title => _item.title;
  DateTime? get date => _parseDateTime(_item.pubDate);
  String? get link => _item.link;
  String? get description => _item.description;
  List<RssCategory>? get categories => _item.categories;

  Map<String,String> get fields => _item.fields;

  DateTime? _parseDateTime(dateString) {
    if (dateString == null) return null;
    return _parseRfc822DateTime(dateString) ?? _parseIso8601DateTime(dateString);
  }

  DateTime? _parseRfc822DateTime(String dateString) {
    try {
      final num? length = dateString.length.clamp(0, rfc822DatePattern.length);
      final trimmedPattern = rfc822DatePattern.substring(0, length as int?); //Some feeds use a shortened RFC 822 date, e.g. 'Tue, 04 Aug 2020'
      final format = DateFormat(trimmedPattern, 'en_US');
      return format.parse(dateString);
    } on FormatException {
      return null;
    }
  }

  DateTime? _parseIso8601DateTime(dateString) {
    try {
      return DateTime.parse(dateString);
    } on FormatException {
      return null;
    }
  }

}


