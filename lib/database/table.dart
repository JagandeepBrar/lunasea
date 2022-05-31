import 'package:flutter/material.dart';
import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/tables/dashboard.dart';
import 'package:lunasea/database/tables/lidarr.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/database/tables/nzbget.dart';
import 'package:lunasea/database/tables/overseerr.dart';
import 'package:lunasea/database/tables/radarr.dart';
import 'package:lunasea/database/tables/sabnzbd.dart';
import 'package:lunasea/database/tables/search.dart';
import 'package:lunasea/database/tables/sonarr.dart';
import 'package:lunasea/database/tables/tautulli.dart';
import 'package:lunasea/vendor.dart';

const TABLE_DASHBOARD_KEY = 'home';
const TABLE_LIDARR_KEY = 'lidarr';
const TABLE_LUNASEA_KEY = 'lunasea';
const TABLE_NZBGET_KEY = 'nzbget';
const TABLE_OVERSEERR_KEY = 'overseerr';
const TABLE_RADARR_KEY = 'radarr';
const TABLE_SABNZBD_KEY = 'sabnzbd';
const TABLE_SEARCH_KEY = 'search';
const TABLE_SONARR_KEY = 'sonarr';
const TABLE_TAUTULLI_KEY = 'tautulli';

enum LunaTable<T extends LunaTableMixin> {
  dashboard<DashboardDatabase>(DashboardDatabase.values),
  lidarr<LidarrDatabase>(LidarrDatabase.values),
  lunasea<LunaSeaDatabase>(LunaSeaDatabase.values),
  nzbget<NZBGetDatabase>(NZBGetDatabase.values),
  overseerr<OverseerrDatabase>(OverseerrDatabase.values),
  radarr<RadarrDatabase>(RadarrDatabase.values),
  sabnzbd<SABnzbdDatabase>(SABnzbdDatabase.values),
  search<SearchDatabase>(SearchDatabase.values),
  sonarr<SonarrDatabase>(SonarrDatabase.values),
  tautulli<TautulliDatabase>(TautulliDatabase.values);

  final List<T> items;
  const LunaTable(this.items);

  T? itemFromKey(String key) {
    for (final item in items) {
      if (item.key == key) return item;
    }
    return null;
  }

  Map<String, dynamic> export() {
    Map<String, dynamic> results = {};

    for (final item in this.items) {
      final value = item.export();
      if (value != null) results[item.key] = value;
    }

    return results;
  }

  void import(Map<String, dynamic>? table) {
    if (table == null || table.isEmpty) return;
    for (final key in table.keys) {
      final db = itemFromKey(key);
      db?.import(table[key]);
    }
  }
}

extension LunaTableExtension on LunaTable {
  LunaTable? fromKey(String key) {
    switch (key) {
      case TABLE_DASHBOARD_KEY:
        return LunaTable.dashboard;
      case TABLE_LIDARR_KEY:
        return LunaTable.lidarr;
      case TABLE_LUNASEA_KEY:
        return LunaTable.lunasea;
      case TABLE_NZBGET_KEY:
        return LunaTable.nzbget;
      case TABLE_OVERSEERR_KEY:
        return LunaTable.overseerr;
      case TABLE_RADARR_KEY:
        return LunaTable.radarr;
      case TABLE_SABNZBD_KEY:
        return LunaTable.sabnzbd;
      case TABLE_SEARCH_KEY:
        return LunaTable.search;
      case TABLE_SONARR_KEY:
        return LunaTable.sonarr;
      case TABLE_TAUTULLI_KEY:
        return LunaTable.tautulli;
    }
    return null;
  }

  String get key {
    switch (this) {
      case LunaTable.dashboard:
        return TABLE_DASHBOARD_KEY;
      case LunaTable.lidarr:
        return TABLE_LIDARR_KEY;
      case LunaTable.lunasea:
        return TABLE_LUNASEA_KEY;
      case LunaTable.nzbget:
        return TABLE_NZBGET_KEY;
      case LunaTable.overseerr:
        return TABLE_OVERSEERR_KEY;
      case LunaTable.radarr:
        return TABLE_RADARR_KEY;
      case LunaTable.sabnzbd:
        return TABLE_SABNZBD_KEY;
      case LunaTable.search:
        return TABLE_SEARCH_KEY;
      case LunaTable.sonarr:
        return TABLE_SONARR_KEY;
      case LunaTable.tautulli:
        return TABLE_TAUTULLI_KEY;
    }
  }
}

mixin LunaTableMixin<T> on Enum {
  T get defaultValue;
  String get table;

  LunaBox get box => LunaBox.lunasea;
  String get key => '${table.toUpperCase()}_$name';

  T read() => box.box.get(key, defaultValue: defaultValue);
  void update(T value) => LunaBox.lunasea.box.put(key, value);

  /// Default is a no-op and does not register any Hive adapters
  void registerAdapters() {}

  ValueListenableBuilder listen({
    required Widget Function(BuildContext, Widget?) builder,
    Key? key,
    Widget? child,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: box.box.listenable(keys: [this.key]),
      builder: (context, _, widget) => builder(context, widget),
      child: child,
    );
  }

  @mustCallSuper
  dynamic export() {
    return read();
  }

  @mustCallSuper
  void import(dynamic value) {
    return update(value);
  }
}
