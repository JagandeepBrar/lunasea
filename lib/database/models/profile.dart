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
