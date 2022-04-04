import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import 'rss_category.dart';

class RssItem {
  final Map<String, String> fields;
  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory>? categories;
  final String? guid;
  final String? pubDate;

  RssItem({
    required this.fields,
    this.title,
    this.description,
    this.link,
    this.categories,
    this.guid,
    this.pubDate,
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
}
