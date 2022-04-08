import 'package:lunasea/core.dart';
export 'package:hive_flutter/hive_flutter.dart';

class Database {
  static const String _DATABASE_PATH = 'database';

  static late _BoxManager alerts;
  static late _BoxManager<ExternalModuleHiveObject> externalModules;
  static late _BoxManager<IndexerHiveObject> indexers;
  static late _BoxManager<LunaLogHiveObject> logs;
  static late _BoxManager lunasea;
  static late _BoxManager<ProfileHiveObject> profiles;
  static late _BoxManager<FeedHiveObject> feeds;

  Future<void> initialize() async {
    await Hive.initFlutter(_DATABASE_PATH);

    LunaDatabase().registerAdapters();
    LunaModule.values.forEach((module) => module.database?.registerAdapters());

    for (_BoxInstance instance in _BoxInstance.values) await instance.init();
    if (Database.profiles.box.isEmpty) bootstrap();
  }

  Future<void> deinitialize() async {
    await Hive.close();
  }

  void bootstrap() {
    clearAll();
    for (_BoxInstance instance in _BoxInstance.values) instance.bootstrap();
  }

  void clearAll() {
    alerts.clear();
    externalModules.clear();
    indexers.clear();
    logs.clear();
    lunasea.clear();
    profiles.clear();
    feeds.clear();
  }
}

enum _BoxInstance {
  ALERTS,
  EXTERNAL_MODULES,
  INDEXERS,
  LOGS,
  LUNASEA,
  PROFILES,
  FEEDS
}

extension _BoxInstanceExtension on _BoxInstance {
  String get key {
    switch (this) {
      case _BoxInstance.ALERTS:
        return 'alerts';
      case _BoxInstance.EXTERNAL_MODULES:
        return 'external_modules';
      case _BoxInstance.INDEXERS:
        return 'indexers';
      case _BoxInstance.LOGS:
        return 'logs';
      case _BoxInstance.LUNASEA:
        return 'lunasea';
      case _BoxInstance.PROFILES:
        return 'profiles';
      case _BoxInstance.FEEDS:
        return 'feeds';
    }
  }

  Future<void> init() async {
    switch (this) {
      case _BoxInstance.ALERTS:
        await Hive.openBox('alerts');
        Database.alerts = _BoxManager(this);
        break;
      case _BoxInstance.EXTERNAL_MODULES:
        await Hive.openBox<ExternalModuleHiveObject>('external_modules');
        Database.externalModules = _BoxManager(this);
        break;
      case _BoxInstance.INDEXERS:
        await Hive.openBox<IndexerHiveObject>('indexers');
        Database.indexers = _BoxManager(this);
        break;
      case _BoxInstance.LOGS:
        await Hive.openBox<LunaLogHiveObject>('logs');
        Database.logs = _BoxManager(this);
        break;
      case _BoxInstance.LUNASEA:
        await Hive.openBox('lunasea');
        Database.lunasea = _BoxManager(this);
        break;
      case _BoxInstance.PROFILES:
        await Hive.openBox<ProfileHiveObject>('profiles');
        Database.profiles = _BoxManager(this);
        break;
      case _BoxInstance.FEEDS:
        await Hive.openBox<FeedHiveObject>('feeds');
        Database.feeds = _BoxManager(this);
        break;
    }
  }

  void bootstrap() {
    switch (this) {
      case _BoxInstance.ALERTS:
        break;
      case _BoxInstance.EXTERNAL_MODULES:
        break;
      case _BoxInstance.INDEXERS:
        break;
      case _BoxInstance.LOGS:
        break;
      case _BoxInstance.LUNASEA:
        LunaDatabaseValue.ENABLED_PROFILE.put('default');
        break;
      case _BoxInstance.PROFILES:
        Database.profiles.box.put('default', ProfileHiveObject.empty());
        break;
      case _BoxInstance.FEEDS:
        break;
    }
  }
}

class _BoxManager<E> {
  final _BoxInstance _instance;

  _BoxManager(this._instance);

  Box<E> get box => Hive.box<E>(_instance.key);
  Future<void> clear() async => box.keys.forEach((k) => box.delete(k));
  Future<int> size() async => box.length;
}
