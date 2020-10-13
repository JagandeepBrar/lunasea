import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

part 'profile.g.dart';

//Next HiveField ID: 40

/**
 * Dead Fields
 * 16, 17, 18, 19, 20, 34
 */

/// Hive database object containing all profile fields
@HiveType(typeId: 0, adapterName: 'ProfileHiveObjectAdapter')
class ProfileHiveObject extends HiveObject {
    factory ProfileHiveObject.empty() {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: false,
            lidarrHost: '',
            lidarrKey: '',
            lidarrHeaders: {},
            //Radarr
            radarrEnabled: false,
            radarrHost: '',
            radarrKey: '',
            radarrHeaders: {},
            //Sonarr
            sonarrEnabled: false,
            sonarrHost: '',
            sonarrKey: '',
            sonarrVersion3: false,
            sonarrHeaders: {},
            //SABnzbd
            sabnzbdEnabled: false,
            sabnzbdHost: '',
            sabnzbdKey: '',
            sabnzbdHeaders: {},
            //NZBGet
            nzbgetEnabled: false,
            nzbgetHost: '',
            nzbgetUser: '',
            nzbgetPass: '',
            nzbgetBasicAuth: false,
            nzbgetHeaders: {},
            //Wake on LAN
            wakeOnLANEnabled: false,
            wakeOnLANBroadcastAddress: '',
            wakeOnLANMACAddress: '',
            //Tautulli
            tautulliEnabled: false,
            tautulliHost: '',
            tautulliKey: '',
            tautulliHeaders: {},
            //Ombi
            ombiEnabled: false,
            ombiHost: '',
            ombiKey: '',
            ombiHeaders: {},
        );
    }

    factory ProfileHiveObject.from(ProfileHiveObject obj) {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: obj.lidarrEnabled,
            lidarrHost: obj.lidarrHost,
            lidarrKey: obj.lidarrKey,
            lidarrHeaders: obj.lidarrHeaders,
            //Radarr
            radarrEnabled: obj.radarrEnabled,
            radarrHost: obj.radarrHost,
            radarrKey: obj.radarrKey,
            radarrHeaders: obj.radarrHeaders,
            //Sonarr
            sonarrEnabled: obj.sonarrEnabled,
            sonarrHost: obj.sonarrHost,
            sonarrKey: obj.sonarrKey,
            sonarrVersion3: obj.sonarrVersion3,
            sonarrHeaders: obj.sonarrHeaders,
            //SABnzbd
            sabnzbdEnabled: obj.sabnzbdEnabled,
            sabnzbdHost: obj.sabnzbdHost,
            sabnzbdKey: obj.sabnzbdKey,
            sabnzbdHeaders: obj.sabnzbdHeaders,
            //NZBGet
            nzbgetEnabled: obj.nzbgetEnabled,
            nzbgetHost: obj.nzbgetHost,
            nzbgetUser: obj.nzbgetUser,
            nzbgetPass: obj.nzbgetPass,
            nzbgetBasicAuth: obj.nzbgetBasicAuth,
            nzbgetHeaders: obj.nzbgetHeaders,
            //Wake On LAN
            wakeOnLANEnabled: obj.wakeOnLANEnabled,
            wakeOnLANBroadcastAddress: obj.wakeOnLANBroadcastAddress,
            wakeOnLANMACAddress: obj.wakeOnLANMACAddress,
            //Tautulli
            tautulliEnabled: obj.tautulliEnabled,
            tautulliHost: obj.tautulliHost,
            tautulliKey: obj.tautulliKey,
            tautulliHeaders: obj.tautulliHeaders,
            //Ombi
            ombiEnabled: obj.ombiEnabled,
            ombiHost: obj.ombiHost,
            ombiKey: obj.ombiKey,
            ombiHeaders: obj.ombiHeaders,
        );
    }

    ProfileHiveObject({
        //Lidarr
        @required this.lidarrEnabled,
        @required this.lidarrHost,
        @required this.lidarrKey,
        @required this.lidarrHeaders,
        //Radarr
        @required this.radarrEnabled,
        @required this.radarrHost,
        @required this.radarrKey,
        @required this.radarrHeaders,
        //Sonarr
        @required this.sonarrEnabled,
        @required this.sonarrHost,
        @required this.sonarrKey,
        @required this.sonarrVersion3,
        @required this.sonarrHeaders,
        //SABnzbd
        @required this.sabnzbdEnabled,
        @required this.sabnzbdHost,
        @required this.sabnzbdKey,
        @required this.sabnzbdHeaders,
        //NZBGet
        @required this.nzbgetEnabled,
        @required this.nzbgetHost,
        @required this.nzbgetUser,
        @required this.nzbgetPass,
        @required this.nzbgetBasicAuth,
        @required this.nzbgetHeaders,
        //Wake On LAN
        @required this.wakeOnLANEnabled,
        @required this.wakeOnLANBroadcastAddress,
        @required this.wakeOnLANMACAddress,
        //Tautulli
        @required this.tautulliEnabled,
        @required this.tautulliHost,
        @required this.tautulliKey,
        @required this.tautulliHeaders,
        //Ombi
        @required this.ombiEnabled,
        @required this.ombiHost,
        @required this.ombiKey,
        @required this.ombiHeaders,
    });

    @override
    String toString() => toMap().toString();

    Map<String, dynamic> toMap() {
        return {
            "key": key,
            //Sonarr
            "sonarrEnabled": sonarrEnabled,
            "sonarrHost": sonarrHost,
            "sonarrKey": sonarrKey,
            "sonarrVersion3": sonarrVersion3,
            "sonarrHeaders": sonarrHeaders,
            //Radarr
            "radarrEnabled": radarrEnabled,
            "radarrHost": radarrHost,
            "radarrKey": radarrKey,
            "radarrHeaders": radarrHeaders,
            //Lidarr
            "lidarrEnabled": lidarrEnabled,
            "lidarrHost": lidarrHost,
            "lidarrKey": lidarrKey,
            "lidarrHeaders": lidarrHeaders,
            //SABnzbd
            "sabnzbdEnabled": sabnzbdEnabled,
            "sabnzbdHost": sabnzbdHost,
            "sabnzbdKey": sabnzbdKey,
            "sabnzbdHeaders": sabnzbdHeaders,
            //NZBGet
            "nzbgetEnabled": nzbgetEnabled,
            "nzbgetHost": nzbgetHost,
            "nzbgetUser": nzbgetUser,
            "nzbgetPass": nzbgetPass,
            "nzbgetBasicAuth": nzbgetBasicAuth,
            "nzbgetHeaders": nzbgetHeaders,
            //Wake On LAN
            "wakeOnLANEnabled": wakeOnLANEnabled,
            "wakeOnLANBroadcastAddress": wakeOnLANBroadcastAddress,
            "wakeOnLANMACAddress": wakeOnLANMACAddress,
            //Tautulli
            "tautulliEnabled": tautulliEnabled,
            "tautulliHost": tautulliHost,
            "tautulliKey": tautulliKey,
            "tautulliHeaders": tautulliHeaders,
            //Ombi
            "ombiEnabled": ombiEnabled,
            "ombiHost": ombiHost,
            "ombiKey": ombiKey,
            "ombiHeaders": ombiHeaders,
        };
    }

    //Lidarr
    @HiveField(0)
    bool lidarrEnabled;
    @HiveField(1)
    String lidarrHost;
    @HiveField(2)
    String lidarrKey;
    @HiveField(26)
    Map lidarrHeaders;

    Map<String, dynamic> getLidarr() => {
        'enabled': lidarrEnabled ?? false,
        'host': lidarrHost ?? '',
        'key': lidarrKey ?? '',
        'headers': lidarrHeaders ?? {},
    };

    //Radarr
    @HiveField(3)
    bool radarrEnabled;
    @HiveField(4)
    String radarrHost;
    @HiveField(5)
    String radarrKey;
    @HiveField(27)
    Map radarrHeaders;

    Map<String, dynamic> getRadarr() => {
        'enabled': radarrEnabled ?? false,
        'host': radarrHost ?? '',
        'key': radarrKey ?? '',
        'headers': radarrHeaders ?? {},
    };

    //Sonarr
    @HiveField(6)
    bool sonarrEnabled;
    @HiveField(7)
    String sonarrHost;
    @HiveField(8)
    String sonarrKey;
    @HiveField(21)
    bool sonarrVersion3;
    @HiveField(28)
    Map sonarrHeaders;

    Map<String, dynamic> getSonarr() => {
        'enabled': sonarrEnabled ?? false,
        'host': sonarrHost ?? '',
        'key': sonarrKey ?? '',
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
    @HiveField(29)
    Map sabnzbdHeaders;
    
    Map<String, dynamic> getSABnzbd() => {
        'enabled': sabnzbdEnabled ?? false,
        'host': sabnzbdHost ?? '',
        'key': sabnzbdKey ?? '',
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
    @HiveField(22)
    bool nzbgetBasicAuth;
    @HiveField(30)
    Map nzbgetHeaders;

    Map<String, dynamic> getNZBGet() => {
        'enabled': nzbgetEnabled ?? false,
        'host': nzbgetHost ?? '',
        'user': nzbgetUser ?? '',
        'pass': nzbgetPass ?? '',
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

    //Tautulli
    @HiveField(31)
    bool tautulliEnabled;
    @HiveField(32)
    String tautulliHost;
    @HiveField(33)
    String tautulliKey;
    @HiveField(35)
    Map tautulliHeaders;

    Map<String, dynamic> getTautulli() => {
        'enabled': tautulliEnabled ?? false,
        'host': tautulliHost ?? '',
        'key': tautulliKey ?? '',
        'headers': tautulliHeaders ?? {},
    };

    //Ombi
    @HiveField(36)
    bool ombiEnabled;
    @HiveField(37)
    String ombiHost;
    @HiveField(38)
    String ombiKey;
    @HiveField(39)
    Map ombiHeaders;

    Map<String, dynamic> getOmbi() => {
        'enabled': ombiEnabled ?? false,
        'host': ombiHost ?? '',
        'key': ombiKey ?? '',
        'headers': ombiHeaders ?? {},
    };

    List<String> get enabledModules => [
        ...enabledAutomationModules,
        ...enabledClientModules,
        ...enabledMonitoringModules,
    ];

    List<String> get enabledAutomationModules => [
        if(lidarrEnabled ?? false) LidarrConstants.MODULE_KEY,
        if(radarrEnabled ?? false) RadarrConstants.MODULE_KEY,
        if(sonarrEnabled ?? false) SonarrConstants.MODULE_KEY,
    ];

    List<String> get enabledClientModules => [
        if(nzbgetEnabled ?? false) NZBGetConstants.MODULE_KEY,
        if(sabnzbdEnabled ?? false) SABnzbdConstants.MODULE_KEY,
    ];

    List<String> get enabledMonitoringModules => [
        if(tautulliEnabled ?? false) TautulliConstants.MODULE_KEY,
        if(ombiEnabled ?? false) OmbiConstants.MODULE_KEY,
    ];

    bool get anyAutomationEnabled => enabledAutomationModules.isNotEmpty;
    bool get anyClientsEnabled => enabledClientModules.isNotEmpty;
    bool get anyMonitoringEnabled => enabledMonitoringModules.isNotEmpty;
    bool get anythingEnabled => anyAutomationEnabled || anyClientsEnabled || anyMonitoringEnabled;
}
