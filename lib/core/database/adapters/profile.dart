import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';

part 'profile.g.dart';

//Next HiveField ID: 31

@HiveType(typeId: 0, adapterName: 'ProfileHiveObjectAdapter')
class ProfileHiveObject extends HiveObject {
    factory ProfileHiveObject.empty() {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: false,
            lidarrHost: '',
            lidarrKey: '',
            lidarrStrictTLS: true,
            lidarrHeaders: {},
            //Radarr
            radarrEnabled: false,
            radarrHost: '',
            radarrKey: '',
            radarrStrictTLS: true,
            radarrHeaders: {},
            //Sonarr
            sonarrEnabled: false,
            sonarrHost: '',
            sonarrKey: '',
            sonarrStrictTLS: true,
            sonarrVersion3: false,
            sonarrHeaders: {},
            //SABnzbd
            sabnzbdEnabled: false,
            sabnzbdHost: '',
            sabnzbdKey: '',
            sabnzbdStrictTLS: true,
            sabnzbdHeaders: {},
            //NZBGet
            nzbgetEnabled: false,
            nzbgetHost: '',
            nzbgetUser: '',
            nzbgetPass: '',
            nzbgetStrictTLS: true,
            nzbgetBasicAuth: false,
            nzbgetHeaders: {},
            //Wake on LAN
            wakeOnLANEnabled: false,
            wakeOnLANBroadcastAddress: '',
            wakeOnLANMACAddress: '',
        );
    }

    factory ProfileHiveObject.from(ProfileHiveObject obj) {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: obj.lidarrEnabled,
            lidarrHost: obj.lidarrHost,
            lidarrKey: obj.lidarrKey,
            lidarrStrictTLS: obj.lidarrStrictTLS,
            lidarrHeaders: obj.lidarrHeaders,
            //Radarr
            radarrEnabled: obj.radarrEnabled,
            radarrHost: obj.radarrHost,
            radarrKey: obj.radarrKey,
            radarrStrictTLS: obj.radarrStrictTLS,
            radarrHeaders: obj.radarrHeaders,
            //Sonarr
            sonarrEnabled: obj.sonarrEnabled,
            sonarrHost: obj.sonarrHost,
            sonarrKey: obj.sonarrKey,
            sonarrStrictTLS: obj.sonarrStrictTLS,
            sonarrVersion3: obj.sonarrVersion3,
            sonarrHeaders: obj.sonarrHeaders,
            //SABnzbd
            sabnzbdEnabled: obj.sabnzbdEnabled,
            sabnzbdHost: obj.sabnzbdHost,
            sabnzbdKey: obj.sabnzbdKey,
            sabnzbdStrictTLS: obj.sabnzbdStrictTLS,
            sabnzbdHeaders: obj.sabnzbdHeaders,
            //NZBGet
            nzbgetEnabled: obj.nzbgetEnabled,
            nzbgetHost: obj.nzbgetHost,
            nzbgetUser: obj.nzbgetUser,
            nzbgetPass: obj.nzbgetPass,
            nzbgetStrictTLS: obj.nzbgetStrictTLS,
            nzbgetBasicAuth: obj.nzbgetBasicAuth,
            nzbgetHeaders: obj.nzbgetHeaders,
            //Wake On LAN
            wakeOnLANEnabled: obj.wakeOnLANEnabled,
            wakeOnLANBroadcastAddress: obj.wakeOnLANBroadcastAddress,
            wakeOnLANMACAddress: obj.wakeOnLANMACAddress,
        );
    }

    ProfileHiveObject({
        //Lidarr
        @required this.lidarrEnabled,
        @required this.lidarrHost,
        @required this.lidarrKey,
        @required this.lidarrStrictTLS,
        @required this.lidarrHeaders,
        //Radarr
        @required this.radarrEnabled,
        @required this.radarrHost,
        @required this.radarrKey,
        @required this.radarrStrictTLS,
        @required this.radarrHeaders,
        //Sonarr
        @required this.sonarrEnabled,
        @required this.sonarrHost,
        @required this.sonarrKey,
        @required this.sonarrStrictTLS,
        @required this.sonarrVersion3,
        @required this.sonarrHeaders,
        //SABnzbd
        @required this.sabnzbdEnabled,
        @required this.sabnzbdHost,
        @required this.sabnzbdKey,
        @required this.sabnzbdStrictTLS,
        @required this.sabnzbdHeaders,
        //NZBGet
        @required this.nzbgetEnabled,
        @required this.nzbgetHost,
        @required this.nzbgetUser,
        @required this.nzbgetPass,
        @required this.nzbgetStrictTLS,
        @required this.nzbgetBasicAuth,
        @required this.nzbgetHeaders,
        //Wake On LAN
        @required this.wakeOnLANEnabled,
        @required this.wakeOnLANBroadcastAddress,
        @required this.wakeOnLANMACAddress,
    });

    @override
    String toString() {
        return toMap().toString();
    }

    Map<String, dynamic> toMap() {
        return {
            "key": key,
            //Sonarr
            "sonarrEnabled": sonarrEnabled,
            "sonarrHost": sonarrHost,
            "sonarrKey": sonarrKey,
            "sonarrStrictTLS": sonarrStrictTLS,
            "sonarrVersion3": sonarrVersion3,
            "sonarrHeaders": sonarrHeaders,
            //Radarr
            "radarrEnabled": radarrEnabled,
            "radarrHost": radarrHost,
            "radarrKey": radarrKey,
            "radarrStrictTLS": radarrStrictTLS,
            "radarrHeaders": radarrHeaders,
            //Lidarr
            "lidarrEnabled": lidarrEnabled,
            "lidarrHost": lidarrHost,
            "lidarrKey": lidarrKey,
            "lidarrStrictTLS": lidarrStrictTLS,
            "lidarrHeaders": lidarrHeaders,
            //SABnzbd
            "sabnzbdEnabled": sabnzbdEnabled,
            "sabnzbdHost": sabnzbdHost,
            "sabnzbdKey": sabnzbdKey,
            "sabnzbdStrictTLS": sabnzbdStrictTLS,
            "sabnzbdHeaders": sabnzbdHeaders,
            //NZBGet
            "nzbgetEnabled": nzbgetEnabled,
            "nzbgetHost": nzbgetHost,
            "nzbgetUser": nzbgetUser,
            "nzbgetPass": nzbgetPass,
            "nzbgetStrictTLS": nzbgetStrictTLS,
            "nzbgetBasicAuth": nzbgetBasicAuth,
            "nzbgetHeaders": nzbgetHeaders,
            //Wake On LAN
            "wakeOnLANEnabled": wakeOnLANEnabled,
            "wakeOnLANBroadcastAddress": wakeOnLANBroadcastAddress,
            "wakeOnLANMACAddress": wakeOnLANMACAddress,
        };
    }

    //Lidarr
    @HiveField(0)
    bool lidarrEnabled;
    @HiveField(1)
    String lidarrHost;
    @HiveField(2)
    String lidarrKey;
    @HiveField(18)
    bool lidarrStrictTLS;
    @HiveField(26)
    Map lidarrHeaders;

    Map<String, dynamic> getLidarr() => {
        'enabled': lidarrEnabled ?? false,
        'host': lidarrHost ?? '',
        'key': lidarrKey ?? '',
        'strict_tls': lidarrStrictTLS ?? true,
        'headers': lidarrHeaders ?? {},
    };

    //Radarr
    @HiveField(3)
    bool radarrEnabled;
    @HiveField(4)
    String radarrHost;
    @HiveField(5)
    String radarrKey;
    @HiveField(17)
    bool radarrStrictTLS;
    @HiveField(27)
    Map radarrHeaders;

    Map<String, dynamic> getRadarr() => {
        'enabled': radarrEnabled ?? false,
        'host': radarrHost ?? '',
        'key': radarrKey ?? '',
        'strict_tls': radarrStrictTLS ?? true,
        'headers': radarrHeaders ?? {},
    };

    //Sonarr
    @HiveField(6)
    bool sonarrEnabled;
    @HiveField(7)
    String sonarrHost;
    @HiveField(8)
    String sonarrKey;
    @HiveField(16)
    bool sonarrStrictTLS;
    @HiveField(21)
    bool sonarrVersion3;
    @HiveField(28)
    Map sonarrHeaders;

    Map<String, dynamic> getSonarr() => {
        'enabled': sonarrEnabled ?? false,
        'host': sonarrHost ?? '',
        'key': sonarrKey ?? '',
        'strict_tls': sonarrStrictTLS ?? true,
        'v3': sonarrVersion3 ?? false,
        'headers': sonarrHeaders ?? {},
    };

    //SABnzbd
    @HiveField(9)
    bool sabnzbdEnabled;
    @HiveField(10)
    String sabnzbdHost;
    @HiveField(11)
    String sabnzbdKey;
    @HiveField(19)
    bool sabnzbdStrictTLS;
    @HiveField(29)
    Map sabnzbdHeaders;
    
    Map<String, dynamic> getSABnzbd() => {
        'enabled': sabnzbdEnabled ?? false,
        'host': sabnzbdHost ?? '',
        'key': sabnzbdKey ?? '',
        'strict_tls': sabnzbdStrictTLS ?? true,
        'headers': sabnzbdHeaders ?? {},
    };

    //NZBGet
    @HiveField(12)
    bool nzbgetEnabled;
    @HiveField(13)
    String nzbgetHost;
    @HiveField(14)
    String nzbgetUser;
    @HiveField(15)
    String nzbgetPass;
    @HiveField(20)
    bool nzbgetStrictTLS;
    @HiveField(22)
    bool nzbgetBasicAuth;
    @HiveField(30)
    Map nzbgetHeaders;

    Map<String, dynamic> getNZBGet() => {
        'enabled': nzbgetEnabled ?? false,
        'host': nzbgetHost ?? '',
        'user': nzbgetUser ?? '',
        'pass': nzbgetPass ?? '',
        'strict_tls': nzbgetStrictTLS ?? true,
        'basic_auth': nzbgetBasicAuth ?? false,
        'headers': nzbgetHeaders ?? {},
    };

    //Wake On LAN
    @HiveField(23)
    bool wakeOnLANEnabled;
    @HiveField(24)
    String wakeOnLANBroadcastAddress;
    @HiveField(25)
    String wakeOnLANMACAddress;

    Map<String, dynamic> getWakeOnLAN() => {
        'enabled': wakeOnLANEnabled ?? false,
        'broadcastAddress': wakeOnLANBroadcastAddress ?? '',
        'MACAddress': wakeOnLANMACAddress ?? '',
    };

    List<String> get enabledModules => [
        if(ModuleFlags.AUTOMATION && ModuleFlags.LIDARR && lidarrEnabled) 'lidarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.RADARR && radarrEnabled) 'radarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.SONARR && sonarrEnabled) 'sonarr',
        if(ModuleFlags.CLIENTS && ModuleFlags.NZBGET && nzbgetEnabled) 'nzbget',
        if(ModuleFlags.CLIENTS && ModuleFlags.SABNZBD && sabnzbdEnabled) 'sabnzbd',
    ];

    List<String> get enabledAutomationModules => [
        if(ModuleFlags.AUTOMATION && ModuleFlags.LIDARR && lidarrEnabled) 'lidarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.RADARR && radarrEnabled) 'radarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.SONARR && sonarrEnabled) 'sonarr',
    ];

    List<String> get enabledClientModules => [
        if(ModuleFlags.CLIENTS && ModuleFlags.NZBGET && nzbgetEnabled) 'nzbget',
        if(ModuleFlags.CLIENTS && ModuleFlags.SABNZBD && sabnzbdEnabled) 'sabnzbd',
    ];

    bool get anyAutomationEnabled => lidarrEnabled || radarrEnabled || sonarrEnabled;
    bool get anyClientsEnabled => nzbgetEnabled || sabnzbdEnabled;
    bool get anythingEnabled => anyAutomationEnabled || anyClientsEnabled;
}
