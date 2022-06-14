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
  @HiveField(0)
  bool lidarrEnabled;

  @JsonKey()
  @HiveField(1)
  String lidarrHost;

  @JsonKey()
  @HiveField(2)
  String lidarrKey;

  @JsonKey()
  @HiveField(26)
  Map lidarrHeaders;

  Map<String, dynamic> getLidarr() {
    return {
      'enabled': lidarrEnabled,
      'host': lidarrHost,
      'key': lidarrKey,
      'headers': lidarrHeaders,
    };
  }

  @JsonKey()
  @HiveField(3)
  bool radarrEnabled;

  @JsonKey()
  @HiveField(4)
  String radarrHost;

  @JsonKey()
  @HiveField(5)
  String radarrKey;

  @HiveField(27)
  Map radarrHeaders;

  Map<String, dynamic> getRadarr() {
    return {
      'enabled': radarrEnabled,
      'host': radarrHost,
      'key': radarrKey,
      'headers': radarrHeaders,
    };
  }

  @JsonKey()
  @HiveField(6)
  bool sonarrEnabled;

  @JsonKey()
  @HiveField(7)
  String sonarrHost;

  @JsonKey()
  @HiveField(8)
  String sonarrKey;

  @JsonKey()
  @HiveField(28)
  Map sonarrHeaders;

  Map<String, dynamic> getSonarr() {
    return {
      'enabled': sonarrEnabled,
      'host': sonarrHost,
      'key': sonarrKey,
      'headers': sonarrHeaders,
    };
  }

  @JsonKey()
  @HiveField(9)
  bool sabnzbdEnabled;

  @JsonKey()
  @HiveField(10)
  String sabnzbdHost;

  @JsonKey()
  @HiveField(11)
  String sabnzbdKey;

  @JsonKey()
  @JsonKey()
  @HiveField(29)
  Map sabnzbdHeaders;

  Map<String, dynamic> getSABnzbd() {
    return {
      'enabled': sabnzbdEnabled,
      'host': sabnzbdHost,
      'key': sabnzbdKey,
      'headers': sabnzbdHeaders,
    };
  }

  @JsonKey()
  @HiveField(12)
  bool nzbgetEnabled;

  @JsonKey()
  @HiveField(13)
  String nzbgetHost;

  @JsonKey()
  @HiveField(14)
  String nzbgetUser;

  @JsonKey()
  @HiveField(15)
  String nzbgetPass;

  @JsonKey()
  @HiveField(30)
  Map nzbgetHeaders;

  Map<String, dynamic> getNZBGet() {
    return {
      'enabled': nzbgetEnabled,
      'host': nzbgetHost,
      'user': nzbgetUser,
      'pass': nzbgetPass,
      'headers': nzbgetHeaders,
    };
  }

  @JsonKey()
  @HiveField(23)
  bool wakeOnLANEnabled;

  @JsonKey()
  @HiveField(24)
  String wakeOnLANBroadcastAddress;

  @JsonKey()
  @HiveField(25)
  String wakeOnLANMACAddress;

  Map<String, dynamic> getWakeOnLAN() {
    return {
      'enabled': wakeOnLANEnabled,
      'broadcastAddress': wakeOnLANBroadcastAddress,
      'MACAddress': wakeOnLANMACAddress,
    };
  }

  @JsonKey()
  @HiveField(31)
  bool tautulliEnabled;

  @JsonKey()
  @HiveField(32)
  String tautulliHost;

  @JsonKey()
  @HiveField(33)
  String tautulliKey;

  @JsonKey()
  @HiveField(35)
  Map tautulliHeaders;

  Map<String, dynamic> getTautulli() {
    return {
      'enabled': tautulliEnabled,
      'host': tautulliHost,
      'key': tautulliKey,
      'headers': tautulliHeaders,
    };
  }

  @JsonKey()
  @HiveField(40)
  bool overseerrEnabled;

  @JsonKey()
  @HiveField(41)
  String overseerrHost;

  @JsonKey()
  @HiveField(42)
  String overseerrKey;

  @JsonKey()
  @HiveField(43)
  Map overseerrHeaders;

  Map<String, dynamic> getOverseerr() {
    return {
      'enabled': overseerrEnabled,
      'host': overseerrHost,
      'key': overseerrKey,
      'headers': overseerrHeaders,
    };
  }

  LunaProfile({
    //Lidarr
    this.lidarrEnabled = false,
    this.lidarrHost = '',
    this.lidarrKey = '',
    this.lidarrHeaders = const {},
    //Radarr
    this.radarrEnabled = false,
    this.radarrHost = '',
    this.radarrKey = '',
    this.radarrHeaders = const {},
    //Sonarr
    this.sonarrEnabled = false,
    this.sonarrHost = '',
    this.sonarrKey = '',
    this.sonarrHeaders = const {},
    //SABnzbd
    this.sabnzbdEnabled = false,
    this.sabnzbdHost = '',
    this.sabnzbdKey = '',
    this.sabnzbdHeaders = const {},
    //NZBGet
    this.nzbgetEnabled = false,
    this.nzbgetHost = '',
    this.nzbgetUser = '',
    this.nzbgetPass = '',
    this.nzbgetHeaders = const {},
    //Wake On LAN
    this.wakeOnLANEnabled = false,
    this.wakeOnLANBroadcastAddress = '',
    this.wakeOnLANMACAddress = '',
    //Tautulli
    this.tautulliEnabled = false,
    this.tautulliHost = '',
    this.tautulliKey = '',
    this.tautulliHeaders = const {},
    //Overseerr
    this.overseerrEnabled = false,
    this.overseerrHost = '',
    this.overseerrKey = '',
    this.overseerrHeaders = const {},
  });

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$LunaProfileToJson(this);

  factory LunaProfile.fromJson(Map<String, dynamic> json) {
    return _$LunaProfileFromJson(json);
  }

  factory LunaProfile.clone(LunaProfile profile) {
    return LunaProfile.fromJson(profile.toJson());
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
