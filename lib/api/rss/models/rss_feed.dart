import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import 'rss_item.dart';

class RssFeed {
  final String? title;
  final String? author;
  final String? description;
  final String? link;
  final List<RssItem>? items;
  List<RssItem>? filteredItems;
  final String? lastBuildDate;

  final DateTime? syncDate;

  RssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.lastBuildDate,
    this.filteredItems,
    this.syncDate,
  });

  factory RssFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    var rss = document.findElements('rss').firstOrNull;
    var rdf = document.findElements('rdf:RDF').firstOrNull;
    if (rss == null && rdf == null) {
      throw ArgumentError('not a rss feed');
    }
    var channelElement = (rss ?? rdf)!.findElements('channel').firstOrNull;
    if (channelElement == null) {
      throw ArgumentError('channel not found');
    }
    return RssFeed(
      title: channelElement.findElements('title').firstOrNull?.text,
      author: channelElement.findElements('author').firstOrNull?.text,
      description: channelElement.findElements('description').firstOrNull?.text,
      link: channelElement.findElements('link').firstOrNull?.text,
      items: (rdf ?? channelElement)
          .findElements('item')
          .map((e) => RssItem.parse(e))
          .toList(),
      lastBuildDate:
          channelElement.findElements('lastBuildDate').firstOrNull?.text,
      syncDate: DateTime.now().toUtc(),
    );
  }
}
