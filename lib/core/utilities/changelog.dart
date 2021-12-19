import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LunaChangelogSheet extends LunaBottomModalSheet {
  _Changelog _changelog;
  String _version;
  String _buildNumber;

  @override
  Future<dynamic> show({
    @required BuildContext context,
    Widget Function(BuildContext context) builder,
    bool checkBuildNumber = false,
  }) async {
    try {
      _changelog =
          await DefaultAssetBundle.of(LunaState.navigatorKey.currentContext)
              .loadString('assets/changelog.json')
              .then((data) => _Changelog.fromJson(json.decode(data)));

      PackageInfo _package = await PackageInfo.fromPlatform();
      if (_package == null) return;

      _version = _package.version;
      _buildNumber = _package.buildNumber;

      if (checkBuildNumber) {
        AlertsDatabaseValue _db = AlertsDatabaseValue.CHANGELOG;
        if (_db.data == _package.buildNumber) return;
        _db.put(_package.buildNumber);
      }

      return this.showModal(context: context, builder: builder);
    } catch (error, stack) {
      LunaLogger().error('Failed to show changelog sheet', error, stack);
    }
  }

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        if (_version != null && _buildNumber != null)
          LunaHeader(
              text: '$_version ($_buildNumber)', subtitle: _changelog.motd),
        if (_version == null || _buildNumber == null)
          LunaHeader(text: 'LunaSea', subtitle: _changelog.motd),
        if ((_changelog.changesNew?.length ?? 0) != 0)
          const LunaHeader(text: 'New'),
        if ((_changelog.changesNew?.length ?? 0) != 0)
          LunaTableCard(
            content: List<LunaTableContent>.generate(
              _changelog.changesNew.length,
              (index) {
                String _body = _changelog.changesNew[index].changes
                    .fold('', (d, o) => d += '${LunaUI.TEXT_BULLET}\t$o\n')
                    .trim();
                return LunaTableContent(
                  title: _changelog.changesNew[index].module,
                  body: _body,
                );
              },
            ),
          ),
        if ((_changelog.changesTweaks?.length ?? 0) != 0)
          const LunaHeader(text: 'Tweaks'),
        if ((_changelog.changesTweaks?.length ?? 0) != 0)
          LunaTableCard(
            content: List<LunaTableContent>.generate(
              _changelog.changesTweaks.length,
              (index) {
                String _body = _changelog.changesTweaks[index].changes
                    .fold('', (d, o) => d += '${LunaUI.TEXT_BULLET}\t$o\n')
                    .trim();
                return LunaTableContent(
                  title: _changelog.changesTweaks[index].module,
                  body: _body,
                );
              },
            ),
          ),
        if ((_changelog.changesFixes?.length ?? 0) != 0)
          const LunaHeader(text: 'Fixes'),
        if ((_changelog.changesFixes?.length ?? 0) != 0)
          LunaTableCard(
            content: List<LunaTableContent>.generate(
                _changelog.changesFixes.length, (index) {
              String _body = _changelog.changesFixes[index].changes
                  .fold('', (d, o) => d += '${LunaUI.TEXT_BULLET}\t$o\n')
                  .trim();
              return LunaTableContent(
                title: _changelog.changesFixes[index].module,
                body: _body,
              );
            }),
          ),
        if ((_changelog.changesPlatform?.length ?? 0) != 0)
          const LunaHeader(text: 'Platform-Specific'),
        if ((_changelog.changesPlatform?.length ?? 0) != 0)
          LunaTableCard(
            content: List<LunaTableContent>.generate(
              _changelog.changesPlatform.length,
              (index) {
                String _body = _changelog.changesPlatform[index].changes
                    .fold('', (d, o) => d += '${LunaUI.TEXT_BULLET}\t$o\n')
                    .trim();
                return LunaTableContent(
                  title: _changelog.changesPlatform[index].module,
                  body: _body,
                );
              },
            ),
          ),
        const SizedBox(height: LunaUI.DEFAULT_MARGIN_SIZE / 2),
      ],
      actionBar: LunaBottomActionBar(
        actions: [
          LunaButton.text(
            text: 'Full Changelog',
            icon: Icons.track_changes_rounded,
            onTap: LunaLinks.CHANGELOG.launch,
          ),
        ],
      ),
    );
  }
}

class _Changelog {
  String motd;
  List<_Change> changesNew;
  List<_Change> changesTweaks;
  List<_Change> changesFixes;
  List<_Change> changesPlatform;

  static _Changelog fromJson(Map<String, dynamic> json) {
    _Changelog changelog = _Changelog();
    changelog.motd = json['motd'] ?? '';
    changelog.changesNew = [];
    if (json['new'] != null) {
      (json['new'] as List).forEach(
        (change) => changelog.changesNew.add(_Change.fromJson(change)),
      );
    }
    changelog.changesTweaks = [];
    if (json['tweaks'] != null) {
      (json['tweaks'] as List).forEach(
        (change) => changelog.changesTweaks.add(_Change.fromJson(change)),
      );
    }
    changelog.changesFixes = [];
    if (json['fixes'] != null) {
      (json['fixes'] as List).forEach(
        (change) => changelog.changesFixes.add(_Change.fromJson(change)),
      );
    }
    // macOS
    changelog.changesPlatform = [];
    int _index = -1;
    _index = (json['platform'] as List)
        .indexWhere((element) => element['module'] == 'macOS');
    if (Platform.isMacOS && json['platform'] != null && _index >= 0)
      changelog.changesPlatform = [
        _Change.fromJson(json['platform'][_index]),
      ];
    // Android
    _index = (json['platform'] as List)
        .indexWhere((element) => element['module'] == 'Android');
    if (Platform.isAndroid && json['platform'] != null && _index >= 0)
      changelog.changesPlatform = [
        _Change.fromJson(json['platform'][_index]),
      ];
    // iOS
    _index = (json['platform'] as List)
        .indexWhere((element) => element['module'] == 'iOS');
    if (Platform.isIOS && json['platform'] != null && _index >= 0)
      changelog.changesPlatform = [
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
