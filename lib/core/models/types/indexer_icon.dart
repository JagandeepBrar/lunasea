import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'indexer_icon.g.dart';

@HiveType(typeId: 22, adapterName: 'LunaIndexerIconAdapter')
enum LunaIndexerIcon {
  @HiveField(0)
  GENERIC,
  @HiveField(1)
  DOGNZB,
  @HiveField(2)
  DRUNKENSLUG,
  @HiveField(3)
  NZBFINDER,
  @HiveField(4)
  NZBGEEK,
  @HiveField(5)
  NZBHYDRA,
  @HiveField(6)
  NZBSU,
}

extension LunaIndexerIconExtension on LunaIndexerIcon {
  LunaIndexerIcon fromKey(String key) {
    switch (key) {
      case 'generic':
        return LunaIndexerIcon.GENERIC;
      case 'dognzb':
        return LunaIndexerIcon.DOGNZB;
      case 'drunkenslug':
        return LunaIndexerIcon.DRUNKENSLUG;
      case 'nzbfinder':
        return LunaIndexerIcon.NZBFINDER;
      case 'nzbgeek':
        return LunaIndexerIcon.NZBGEEK;
      case 'nzbhydra':
        return LunaIndexerIcon.NZBHYDRA;
      case 'nzbsu':
        return LunaIndexerIcon.NZBSU;
      default:
        return LunaIndexerIcon.GENERIC;
    }
  }

  String get key {
    switch (this) {
      case LunaIndexerIcon.GENERIC:
        return 'generic';
      case LunaIndexerIcon.DOGNZB:
        return 'dognzb';
      case LunaIndexerIcon.DRUNKENSLUG:
        return 'drunkenslug';
      case LunaIndexerIcon.NZBFINDER:
        return 'nzbfinder';
      case LunaIndexerIcon.NZBGEEK:
        return 'nzbgeek';
      case LunaIndexerIcon.NZBHYDRA:
        return 'nzbhydra';
      case LunaIndexerIcon.NZBSU:
        return 'nzbsu';
    }
    throw Exception('Unknown LunaIndexerIcon');
  }

  String get name {
    switch (this) {
      case LunaIndexerIcon.GENERIC:
        return 'Generic';
      case LunaIndexerIcon.DOGNZB:
        return 'DOGnzb';
      case LunaIndexerIcon.DRUNKENSLUG:
        return 'DrunkenSlug';
      case LunaIndexerIcon.NZBFINDER:
        return 'NZBFinder';
      case LunaIndexerIcon.NZBGEEK:
        return 'NZBGeek';
      case LunaIndexerIcon.NZBHYDRA:
        return 'NZBHydra2';
      case LunaIndexerIcon.NZBSU:
        return 'NZB.su';
    }
    throw Exception('Unknown LunaIndexerIcon');
  }

  IconData get icon {
    switch (this) {
      case LunaIndexerIcon.GENERIC:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.DOGNZB:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.DRUNKENSLUG:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.NZBFINDER:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.NZBGEEK:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.NZBHYDRA:
        return Icons.rss_feed_rounded;
      case LunaIndexerIcon.NZBSU:
        return Icons.rss_feed_rounded;
    }
    throw Exception('Unknown LunaIndexerIcon');
  }
}
