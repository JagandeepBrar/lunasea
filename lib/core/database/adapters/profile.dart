import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';

part 'profile.g.dart';

@HiveType(typeId: 0, adapterName: 'ProfileHiveObjectAdapter')
class ProfileHiveObject extends HiveObject {
    factory ProfileHiveObject.empty() {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: false,
            lidarrHost: '',
            lidarrKey: '',
            //Radarr
            radarrEnabled: false,
            radarrHost: '',
            radarrKey: '',
            //Sonarr
            sonarrEnabled: false,
            sonarrHost: '',
            sonarrKey: '',
            //SABnzbd
            sabnzbdEnabled: false,
            sabnzbdHost: '',
            sabnzbdKey: '',
            //NZBGet
            nzbgetEnabled: false,
            nzbgetHost: '',
            nzbgetUser: '',
            nzbgetPass: '',
        );
    }

    factory ProfileHiveObject.from(ProfileHiveObject obj) {
        return ProfileHiveObject(
            //Lidarr
            lidarrEnabled: obj.lidarrEnabled,
            lidarrHost: obj.lidarrHost,
            lidarrKey: obj.lidarrKey,
            //Radarr
            radarrEnabled: obj.radarrEnabled,
            radarrHost: obj.radarrHost,
            radarrKey: obj.radarrKey,
            //Sonarr
            sonarrEnabled: obj.sonarrEnabled,
            sonarrHost: obj.sonarrHost,
            sonarrKey: obj.sonarrKey,
            //SABnzbd
            sabnzbdEnabled: obj.sabnzbdEnabled,
            sabnzbdHost: obj.sabnzbdHost,
            sabnzbdKey: obj.sabnzbdKey,
            //NZBGet
            nzbgetEnabled: obj.nzbgetEnabled,
            nzbgetHost: obj.nzbgetHost,
            nzbgetUser: obj.nzbgetUser,
            nzbgetPass: obj.nzbgetPass,
        );
    }

    ProfileHiveObject({
        //Lidarr
        @required this.lidarrEnabled,
        @required this.lidarrHost,
        @required this.lidarrKey,
        //Radarr
        @required this.radarrEnabled,
        @required this.radarrHost,
        @required this.radarrKey,
        //Sonarr
        @required this.sonarrEnabled,
        @required this.sonarrHost,
        @required this.sonarrKey,
        //SABnzbd
        @required this.sabnzbdEnabled,
        @required this.sabnzbdHost,
        @required this.sabnzbdKey,
        //NZBGet
        @required this.nzbgetEnabled,
        @required this.nzbgetHost,
        @required this.nzbgetUser,
        @required this.nzbgetPass,
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
            //Radarr
            "radarrEnabled": radarrEnabled,
            "radarrHost": radarrHost,
            "radarrKey": radarrKey,
            //Lidarr
            "lidarrEnabled": lidarrEnabled,
            "lidarrHost": lidarrHost,
            "lidarrKey": lidarrKey,
            //SABnzbd
            "sabnzbdEnabled": sabnzbdEnabled,
            "sabnzbdHost": sabnzbdHost,
            "sabnzbdKey": sabnzbdKey,
            //NZBGet
            "nzbgetEnabled": nzbgetEnabled,
            "nzbgetHost": nzbgetHost,
            "nzbgetUser": nzbgetUser,
            "nzbgetPass": nzbgetPass,
        };
    }

    //Lidarr
    @HiveField(0)
    bool lidarrEnabled = false;
    @HiveField(1)
    String lidarrHost = '';
    @HiveField(2)
    String lidarrKey = '';

    Map<String, dynamic> getLidarr() => {
        'enabled': lidarrEnabled ?? false,
        'host': lidarrHost ?? '',
        'key': lidarrKey ?? '',
    };

    //Radarr
    @HiveField(3)
    bool radarrEnabled;
    @HiveField(4)
    String radarrHost;
    @HiveField(5)
    String radarrKey;

    Map<String, dynamic> getRadarr() => {
        'enabled': radarrEnabled ?? false,
        'host': radarrHost ?? '',
        'key': radarrKey ?? '',
    };

    //Sonarr
    @HiveField(6)
    bool sonarrEnabled;
    @HiveField(7)
    String sonarrHost;
    @HiveField(8)
    String sonarrKey;

    Map<String, dynamic> getSonarr() => {
        'enabled': sonarrEnabled ?? false,
        'host': sonarrHost ?? '',
        'key': sonarrKey ?? '',
    };

    //SABnzbd
    @HiveField(9)
    bool sabnzbdEnabled;
    @HiveField(10)
    String sabnzbdHost;
    @HiveField(11)
    String sabnzbdKey;
    
    Map<String, dynamic> getSABnzbd() => {
        'enabled': sabnzbdEnabled ?? false,
        'host': sabnzbdHost ?? '',
        'key': sabnzbdKey ?? '',
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

    Map<String, dynamic> getNZBGet() => {
        'enabled': nzbgetEnabled ?? false,
        'host': nzbgetHost ?? '',
        'user': nzbgetUser ?? '',
        'pass': nzbgetPass ?? '',
    };

    List<String> get enabledServices => [
        if(ModuleFlags.AUTOMATION && ModuleFlags.LIDARR && lidarrEnabled) 'lidarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.RADARR && radarrEnabled) 'radarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.SONARR && sonarrEnabled) 'sonarr',
        if(ModuleFlags.CLIENTS && ModuleFlags.NZBGET && nzbgetEnabled) 'nzbget',
        if(ModuleFlags.CLIENTS && ModuleFlags.SABNZBD && sabnzbdEnabled) 'sabnzbd',
    ];

    List<String> get enabledAutomationServices => [
        if(ModuleFlags.AUTOMATION && ModuleFlags.LIDARR && lidarrEnabled) 'lidarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.RADARR && radarrEnabled) 'radarr',
        if(ModuleFlags.AUTOMATION && ModuleFlags.SONARR && sonarrEnabled) 'sonarr',
    ];

    List<String> get enabledClientServices => [
        if(ModuleFlags.CLIENTS && ModuleFlags.NZBGET && nzbgetEnabled) 'nzbget',
        if(ModuleFlags.CLIENTS && ModuleFlags.SABNZBD && sabnzbdEnabled) 'sabnzbd',
    ];

    bool get anyAutomationEnabled => lidarrEnabled || radarrEnabled || sonarrEnabled;
    bool get anyClientsEnabled => nzbgetEnabled || sabnzbdEnabled;
    bool get anythingEnabled => anyAutomationEnabled || anyClientsEnabled;
}
