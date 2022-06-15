import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'indexer_icon.g.dart';

const _GENERIC = 'generic';
const _DOGNZB = 'dognzb';
const _DRUNKENSLUG = 'drunkenslug';
const _NZBFINDER = 'nzbfinder';
const _NZBGEEK = 'nzbgeek';
const _NZBHYDRA = 'nzbhydra';
const _NZBSU = 'nzbsu';

@JsonEnum()
@HiveType(typeId: 22, adapterName: 'LunaIndexerIconAdapter')
enum LunaIndexerIcon {
  @JsonValue(_GENERIC)
  @HiveField(0)
  GENERIC(_GENERIC),

  @JsonValue(_DOGNZB)
  @HiveField(1)
  DOGNZB(_DOGNZB),

  @JsonValue(_DRUNKENSLUG)
  @HiveField(2)
  DRUNKENSLUG(_DRUNKENSLUG),

  @JsonValue(_NZBFINDER)
  @HiveField(3)
  NZBFINDER(_NZBFINDER),

  @JsonValue(_NZBGEEK)
  @HiveField(4)
  NZBGEEK(_NZBGEEK),

  @JsonValue(_NZBHYDRA)
  @HiveField(5)
  NZBHYDRA(_NZBHYDRA),

  @JsonValue(_NZBSU)
  @HiveField(6)
  NZBSU(_NZBSU);

  final String key;
  const LunaIndexerIcon(this.key);

  static LunaIndexerIcon fromKey(String key) {
    switch (key) {
      case _DOGNZB:
        return LunaIndexerIcon.DOGNZB;
      case _DRUNKENSLUG:
        return LunaIndexerIcon.DRUNKENSLUG;
      case _NZBFINDER:
        return LunaIndexerIcon.NZBFINDER;
      case _NZBGEEK:
        return LunaIndexerIcon.NZBGEEK;
      case _NZBHYDRA:
        return LunaIndexerIcon.NZBHYDRA;
      case _NZBSU:
        return LunaIndexerIcon.NZBSU;
      default:
        return LunaIndexerIcon.GENERIC;
    }
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
  }
}
