import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/vendor.dart';

part 'profile.g.dart';

@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'LunaProfileAdapter')
class LunaProfile extends HiveObject {
  static const String DEFAULT_PROFILE = 'default';

  static LunaProfile get current {
    final enabled = LunaSeaDatabase.ENABLED_PROFILE.read();
    return LunaBox.profiles.read(enabled) ?? LunaProfile();
  }

  static List<String> get list {
    final profiles = LunaBox.profiles.keys.cast<String>().toList();
    profiles.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return profiles;
  }

  @JsonKey()
  @HiveField(0, defaultValue: false)
  bool lidarrEnabled;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String lidarrHost;

  @JsonKey()
  @HiveField(2, defaultValue: '')
  String lidarrKey;

  @JsonKey()
  @HiveField(26, defaultValue: <String, String>{})
  Map<String, String> lidarrHeaders;

  @JsonKey()
  @HiveField(3, defaultValue: false)
  bool radarrEnabled;

  @JsonKey()
  @HiveField(4, defaultValue: '')
  String radarrHost;

  @JsonKey()
  @HiveField(5, defaultValue: '')
  String radarrKey;

  @JsonKey()
  @HiveField(27, defaultValue: <String, String>{})
  Map<String, String> radarrHeaders;

  @JsonKey()
  @HiveField(6, defaultValue: false)
  bool sonarrEnabled;

  @JsonKey()
  @HiveField(7, defaultValue: '')
  String sonarrHost;

  @JsonKey()
  @HiveField(8, defaultValue: '')
  String sonarrKey;

  @JsonKey()
  @HiveField(28, defaultValue: <String, String>{})
  Map<String, String> sonarrHeaders;

  @JsonKey()
  @HiveField(9, defaultValue: false)
  bool sabnzbdEnabled;

  @JsonKey()
  @HiveField(10, defaultValue: '')
  String sabnzbdHost;

  @JsonKey()
  @HiveField(11, defaultValue: '')
  String sabnzbdKey;

  @JsonKey()
  @HiveField(29, defaultValue: <String, String>{})
  Map<String, String> sabnzbdHeaders;

  @JsonKey()
  @HiveField(12, defaultValue: false)
  bool nzbgetEnabled;

  @JsonKey()
  @HiveField(13, defaultValue: '')
  String nzbgetHost;

  @JsonKey()
  @HiveField(14, defaultValue: '')
  String nzbgetUser;

  @JsonKey()
  @HiveField(15, defaultValue: '')
  String nzbgetPass;

  @JsonKey()
  @HiveField(30, defaultValue: <String, String>{})
  Map<String, String> nzbgetHeaders;

  @JsonKey()
  @HiveField(23, defaultValue: false)
  bool wakeOnLANEnabled;

  @JsonKey()
  @HiveField(24, defaultValue: '')
  String wakeOnLANBroadcastAddress;

  @JsonKey()
  @HiveField(25, defaultValue: '')
  String wakeOnLANMACAddress;

  @JsonKey()
  @HiveField(31, defaultValue: false)
  bool tautulliEnabled;

  @JsonKey()
  @HiveField(32, defaultValue: '')
  String tautulliHost;

  @JsonKey()
  @HiveField(33, defaultValue: '')
  String tautulliKey;

  @JsonKey()
  @HiveField(35, defaultValue: <String, String>{})
  Map<String, String> tautulliHeaders;

  @JsonKey()
  @HiveField(40, defaultValue: false)
  bool overseerrEnabled;

  @JsonKey()
  @HiveField(41, defaultValue: '')
  String overseerrHost;

  @JsonKey()
  @HiveField(42, defaultValue: '')
  String overseerrKey;

  @JsonKey()
  @HiveField(43, defaultValue: <String, String>{})
  Map<String, String> overseerrHeaders;

  LunaProfile._internal({
    //Lidarr
    required this.lidarrEnabled,
    required this.lidarrHost,
    required this.lidarrKey,
    required this.lidarrHeaders,
    //Radarr
    required this.radarrEnabled,
    required this.radarrHost,
    required this.radarrKey,
    required this.radarrHeaders,
    //Sonarr
    required this.sonarrEnabled,
    required this.sonarrHost,
    required this.sonarrKey,
    required this.sonarrHeaders,
    //SABnzbd
    required this.sabnzbdEnabled,
    required this.sabnzbdHost,
    required this.sabnzbdKey,
    required this.sabnzbdHeaders,
    //NZBGet
    required this.nzbgetEnabled,
    required this.nzbgetHost,
    required this.nzbgetUser,
    required this.nzbgetPass,
    required this.nzbgetHeaders,
    //Wake On LAN
    required this.wakeOnLANEnabled,
    required this.wakeOnLANBroadcastAddress,
    required this.wakeOnLANMACAddress,
    //Tautulli
    required this.tautulliEnabled,
    required this.tautulliHost,
    required this.tautulliKey,
    required this.tautulliHeaders,
    //Overseerr
    required this.overseerrEnabled,
    required this.overseerrHost,
    required this.overseerrKey,
    required this.overseerrHeaders,
  });

  factory LunaProfile({
    //Lidarr
    bool? lidarrEnabled,
    String? lidarrHost,
    String? lidarrKey,
    Map<String, String>? lidarrHeaders,
    //Radarr
    bool? radarrEnabled,
    String? radarrHost,
    String? radarrKey,
    Map<String, String>? radarrHeaders,
    //Sonarr
    bool? sonarrEnabled,
    String? sonarrHost,
    String? sonarrKey,
    Map<String, String>? sonarrHeaders,
    //SABnzbd
    bool? sabnzbdEnabled,
    String? sabnzbdHost,
    String? sabnzbdKey,
    Map<String, String>? sabnzbdHeaders,
    //NZBGet
    bool? nzbgetEnabled,
    String? nzbgetHost,
    String? nzbgetUser,
    String? nzbgetPass,
    Map<String, String>? nzbgetHeaders,
    //Wake On LAN
    bool? wakeOnLANEnabled,
    String? wakeOnLANBroadcastAddress,
    String? wakeOnLANMACAddress,
    //Tautulli
    bool? tautulliEnabled,
    String? tautulliHost,
    String? tautulliKey,
    Map<String, String>? tautulliHeaders,
    //Overseerr
    bool? overseerrEnabled,
    String? overseerrHost,
    String? overseerrKey,
    Map<String, String>? overseerrHeaders,
  }) {
    return LunaProfile._internal(
      // Lidarr
      lidarrEnabled: lidarrEnabled ?? false,
      lidarrHost: lidarrHost ?? '',
      lidarrKey: lidarrKey ?? '',
      lidarrHeaders: lidarrHeaders ?? {},
      // Radarr
      radarrEnabled: radarrEnabled ?? false,
      radarrHost: radarrHost ?? '',
      radarrKey: radarrKey ?? '',
      radarrHeaders: radarrHeaders ?? {},
      // Sonarr
      sonarrEnabled: sonarrEnabled ?? false,
      sonarrHost: sonarrHost ?? '',
      sonarrKey: sonarrKey ?? '',
      sonarrHeaders: sonarrHeaders ?? {},
      // SABnzbd
      sabnzbdEnabled: sabnzbdEnabled ?? false,
      sabnzbdHost: sabnzbdHost ?? '',
      sabnzbdKey: sabnzbdKey ?? '',
      sabnzbdHeaders: sabnzbdHeaders ?? {},
      // NZBGet
      nzbgetEnabled: nzbgetEnabled ?? false,
      nzbgetHost: nzbgetHost ?? '',
      nzbgetUser: nzbgetUser ?? '',
      nzbgetPass: nzbgetPass ?? '',
      nzbgetHeaders: nzbgetHeaders ?? {},
      // Wake On LAN
      wakeOnLANEnabled: wakeOnLANEnabled ?? false,
      wakeOnLANBroadcastAddress: wakeOnLANBroadcastAddress ?? '',
      wakeOnLANMACAddress: wakeOnLANMACAddress ?? '',
      // Tautulli
      tautulliEnabled: tautulliEnabled ?? false,
      tautulliHost: tautulliHost ?? '',
      tautulliKey: tautulliKey ?? '',
      tautulliHeaders: tautulliHeaders ?? {},
      // Overseerr
      overseerrEnabled: overseerrEnabled ?? false,
      overseerrHost: overseerrHost ?? '',
      overseerrKey: overseerrKey ?? '',
      overseerrHeaders: overseerrHeaders ?? {},
    );
  }

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() {
    final json = _$LunaProfileToJson(this);
    json['key'] = key.toString();
    return json;
  }

  factory LunaProfile.fromJson(Map<String, dynamic> json) {
    return _$LunaProfileFromJson(json);
  }

  factory LunaProfile.clone(LunaProfile profile) {
    return LunaProfile.fromJson(profile.toJson().cast<String, dynamic>());
  }

  factory LunaProfile.get(String key) {
    return LunaBox.profiles.read(key)!;
  }

  bool isAnythingEnabled() {
    for (final module in LunaModule.active) {
      if (module.isEnabled) return true;
    }
    return false;
  }
}
