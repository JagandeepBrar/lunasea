import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 0, adapterName: 'ProfileHiveObjectAdapter')
class ProfileHiveObject extends HiveObject {
    factory ProfileHiveObject.empty(String displayName) {
        return ProfileHiveObject(
            displayName: displayName,
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

    ProfileHiveObject({
        @required this.displayName,
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
        return {
            "displayName": displayName,
            "lidarr": getLidarr(),
            "radarr": getRadarr(),
            "sonarr": getSonarr(),
            "sabnzbd": getSABnzbd(),
            "nzbget": getNZBGet(),
        }.toString();
    }
    
    @HiveField(0)
    String displayName;

    //Lidarr
    @HiveField(1)
    bool lidarrEnabled;
    @HiveField(2)
    String lidarrHost;
    @HiveField(3)
    String lidarrKey;
    Map<String, dynamic> getLidarr() => {
        'enabled': lidarrEnabled ?? false,
        'host': lidarrHost ?? '',
        'key': lidarrKey ?? '',
    };

    //Radarr
    @HiveField(4)
    bool radarrEnabled;
    @HiveField(5)
    String radarrHost;
    @HiveField(6)
    String radarrKey;
    Map<String, dynamic> getRadarr() => {
        'enabled': radarrEnabled ?? false,
        'host': radarrHost ?? '',
        'key': radarrKey ?? '',
    };

    //Sonarr
    @HiveField(7)
    bool sonarrEnabled;
    @HiveField(8)
    String sonarrHost;
    @HiveField(9)
    String sonarrKey;
    Map<String, dynamic> getSonarr() => {
        'enabled': sonarrEnabled ?? false,
        'host': sonarrHost ?? '',
        'key': sonarrKey ?? '',
    };

    //SABnzbd
    @HiveField(10)
    bool sabnzbdEnabled;
    @HiveField(11)
    String sabnzbdHost;
    @HiveField(12)
    String sabnzbdKey;
    Map<String, dynamic> getSABnzbd() => {
        'enabled': sabnzbdEnabled ?? false,
        'host': sabnzbdHost ?? '',
        'key': sabnzbdKey ?? '',
    };

    //NZBGet
    @HiveField(13)
    bool nzbgetEnabled;
    @HiveField(14)
    String nzbgetHost;
    @HiveField(15)
    String nzbgetUser;
    @HiveField(16)
    String nzbgetPass;
    Map<String, dynamic> getNZBGet() => {
        'enabled': nzbgetEnabled ?? false,
        'host': nzbgetHost ?? '',
        'user': nzbgetUser ?? '',
        'pass': nzbgetPass ?? '',
    };
}
