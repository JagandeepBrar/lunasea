import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LunaChangelog {
    /// Check if the current build number is not equal to the stored build number.
    /// 
    /// If they are not the same, stores the current build number and shows the changelog.
    Future<void> checkAndShowChangelog() async {
        PackageInfo.fromPlatform()
        .then((package) {
            if(package != null && AlertsDatabaseValue.CHANGELOG.data != package.buildNumber) {
                AlertsDatabaseValue.CHANGELOG.put(package.buildNumber);
                showChangelog(package.version, package.buildNumber);
            }
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to fetch platform information', error, stack);
        });
    }

    /// Load the changelog asset and show a bottom modal sheet with the changelog.
    Future<void> showChangelog(String version, String buildNumber) async {
        await DefaultAssetBundle.of(LunaState.navigatorKey.currentContext).loadString('assets/changelog.json')
        .then((data) {
            _Changelog changelog = _Changelog.fromJson(json.decode(data));
            LunaBottomModalSheet().showModal(
                context: LunaState.navigatorKey.currentContext,
                builder: (context) => LunaScaffold(
                    scaffoldKey: null,
                    body: LunaListViewModal(
                        shrinkWrap: false,
                        children: [
                            if(version != null && buildNumber != null) LunaHeader(text: '$version ($buildNumber)', subtitle: changelog.motd),
                            if(version == null || buildNumber == null) LunaHeader(text: 'LunaSea', subtitle: changelog.motd),
                            if((changelog.changesNew?.length ?? 0) != 0) LunaHeader(text: 'New'),
                            if((changelog.changesNew?.length ?? 0) != 0) LunaTableCard(
                                content: List<LunaTableContent>.generate(
                                    changelog.changesNew.length,
                                    (index) => LunaTableContent(
                                        title: changelog.changesNew[index].module,
                                        body: changelog.changesNew[index].changes.fold('', (data, object) => data += '${LunaUI.TEXT_BULLET}\t$object\n').trim(),
                                    ),
                                ),
                            ),
                            if((changelog.changesTweaks?.length ?? 0) != 0) LunaHeader(text: 'Tweaks'),
                            if((changelog.changesTweaks?.length ?? 0) != 0) LunaTableCard(
                                content: List<LunaTableContent>.generate(
                                    changelog.changesTweaks.length,
                                    (index) => LunaTableContent(
                                        title: changelog.changesTweaks[index].module,
                                        body: changelog.changesTweaks[index].changes.fold('', (data, object) => data += '${LunaUI.TEXT_BULLET}\t$object\n').trim(),
                                    ),
                                ),
                            ),
                            if((changelog.changesFixes?.length ?? 0) != 0) LunaHeader(text: 'Fixes'),
                            if((changelog.changesFixes?.length ?? 0) != 0) LunaTableCard(
                                content: List<LunaTableContent>.generate(
                                    changelog.changesFixes.length,
                                    (index) => LunaTableContent(
                                        title: changelog.changesFixes[index].module,
                                        body: changelog.changesFixes[index].changes.fold('', (data, object) => data += '${LunaUI.TEXT_BULLET}\t$object\n').trim(),
                                    ),
                                ),
                            ),
                            if((changelog.changesPlatform?.length ?? 0) != 0) LunaHeader(text: 'Platform-Specific'),
                            if((changelog.changesPlatform?.length ?? 0) != 0) LunaTableCard(
                                content: List<LunaTableContent>.generate(
                                    changelog.changesPlatform.length,
                                    (index) => LunaTableContent(
                                        title: changelog.changesPlatform[index].module,
                                        body: changelog.changesPlatform[index].changes.fold('', (data, object) => data += '${LunaUI.TEXT_BULLET}\t$object\n').trim(),
                                    ),
                                ),
                            ),
                        ],
                    ),
                    bottomNavigationBar: LunaBottomActionBar(
                        actions: [
                            LunaButton.text(
                                text: 'Full Changelog',
                                icon: Icons.track_changes_rounded,
                                onTap: LunaLinks.CHANGELOG.launch,
                            ),
                        ],
                    ),
                ),
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to fetched changelog asset', error, stack);
            showLunaErrorSnackBar(title: 'Failed to Load Changelog', error: error);
        });
    }
}

class _Changelog {
    String motd;
    String version;
    List<_Change> changesNew;
    List<_Change> changesTweaks;
    List<_Change> changesFixes;
    List<_Change> changesPlatform;

    static _Changelog fromJson(Map<String, dynamic> json) {
        _Changelog changelog = _Changelog();
        changelog.motd = json['motd'] ?? '';
        changelog.version = json['version'] ?? '';
        changelog.changesNew = json['new'] == null ? [] : (json['new'] as List).map<_Change>((change) => _Change.fromJson(change)).toList();
        changelog.changesTweaks = json['tweaks'] == null ? [] : (json['tweaks'] as List).map<_Change>((change) => _Change.fromJson(change)).toList();
        changelog.changesFixes = json['fixes'] == null ? [] : (json['fixes'] as List).map<_Change>((change) => _Change.fromJson(change)).toList();
        // macOS
        changelog.changesPlatform = [];
        int _index = -1;
        _index = (json['platform'] as List).indexWhere((element) => element['module'] == 'macOS');
        if(Platform.isMacOS &&  json['platform'] != null &&  _index >= 0) changelog.changesPlatform = [
            _Change.fromJson(json['platform'][_index]),
        ];
        // Android
        _index = (json['platform'] as List).indexWhere((element) => element['module'] == 'Android');
        if(Platform.isAndroid &&  json['platform'] != null &&  _index >= 0) changelog.changesPlatform = [
            _Change.fromJson(json['platform'][_index]),
        ];
        // iOS
        _index = (json['platform'] as List).indexWhere((element) => element['module'] == 'iOS');
        if(Platform.isIOS &&  json['platform'] != null &&  _index >= 0) changelog.changesPlatform = [
            _Change.fromJson(json['platform'][_index]),
        ];
        return changelog;
    }
}

class _Change {
    String module;
    List<String> changes;

    static _Change fromJson(Map<String, dynamic> json) {
        _Change change = _Change();
        change.module = json['module'] ?? '';
        change.changes = (json['changes'] as List)?.cast<String>() ?? [];
        return change;
    }
}
