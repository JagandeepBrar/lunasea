import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LunaChangelogSheet extends LunaBottomModalSheet {
  late _Changelog _changelog;
  String _version = '';
  String _buildNumber = '';

  @override
  Future<dynamic> show({
    required BuildContext? context,
    Widget Function(BuildContext context)? builder,
    bool checkBuildNumber = false,
  }) async {
    try {
      _changelog =
          await DefaultAssetBundle.of(LunaState.navigatorKey.currentContext!)
              .loadString('assets/changelog.json')
              .then((data) => _Changelog.fromJson(json.decode(data)));

      PackageInfo _package = await PackageInfo.fromPlatform();

      _version = _package.version;
      _buildNumber = _package.buildNumber;

      if (checkBuildNumber) {
        AlertsDatabaseValue _db = AlertsDatabaseValue.CHANGELOG;
        if (_db.data == _package.buildNumber) return;
        _db.put(_package.buildNumber);
      }

      return this.showModal(context: context!, builder: builder);
    } catch (error, stack) {
      LunaLogger().error('Failed to show changelog sheet', error, stack);
    }
  }

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        LunaHeader(
          text: '$_version ($_buildNumber)',
          subtitle: _changelog.motd,
        ),
        ..._buildChangeBlock(
          'lunasea.New'.tr(),
          _changelog.changesNew,
        ),
        ..._buildChangeBlock(
          'lunasea.Tweaks'.tr(),
          _changelog.changesTweaks,
        ),
        ..._buildChangeBlock(
          'lunasea.Fixes'.tr(),
          _changelog.changesFixes,
        ),
        ..._buildChangeBlock(
          'lunasea.PlatformSpecific'.tr(),
          _changelog.changesPlatform,
        ),
        const SizedBox(height: LunaUI.DEFAULT_MARGIN_SIZE / 2),
      ],
      actionBar: LunaBottomActionBar(
        actions: [
          LunaButton.text(
            text: 'lunasea.FullChangelog'.tr(),
            icon: Icons.track_changes_rounded,
            onTap: LunaLinks.CHANGELOG.launch,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChangeBlock(String header, List<_Change> changes) {
    if (changes.isEmpty) return [];
    return [
      LunaHeader(text: header),
      LunaTableCard(
        content: List<LunaTableContent>.generate(
          changes.length,
          (index) {
            String? _body = changes[index]
                .changes
                .fold('', (dynamic d, o) => d += '${LunaUI.TEXT_BULLET}\t$o\n')
                .trim();
            return LunaTableContent(
              title: changes[index].module,
              body: _body,
            );
          },
        ),
      ),
    ];
  }
}

class _Changelog {
  String? motd;
  List<_Change> changesNew = [];
  List<_Change> changesTweaks = [];
  List<_Change> changesFixes = [];
  List<_Change> changesPlatform = [];

  static _Changelog fromJson(Map<String, dynamic> json) {
    _Changelog changelog = _Changelog();
    int _index = -1;
    List<dynamic>? data;

    changelog.motd = json['motd'] ?? '';

    data = json['new'];
    data?.forEach((change) {
      _Change _change = _Change.fromJson(change);
      changelog.changesNew.add(_change);
    });

    data = json['tweaks'];
    data?.forEach((change) {
      _Change _change = _Change.fromJson(change);
      changelog.changesTweaks.add(_change);
    });

    data = json['fixes'];
    data?.forEach((change) {
      _Change _change = _Change.fromJson(change);
      changelog.changesFixes.add(_change);
    });

    _index = data?.indexWhere((e) => e['module'] == 'macOS') ?? -1;
    if (Platform.isMacOS && _index >= 0) {
      _Change _change = _Change.fromJson(data![_index]);
      changelog.changesFixes.add(_change);
    }

    _index = data?.indexWhere((e) => e['module'] == 'Android') ?? -1;
    if (Platform.isAndroid && _index >= 0) {
      _Change _change = _Change.fromJson(data![_index]);
      changelog.changesFixes.add(_change);
    }

    _index = data?.indexWhere((e) => e['module'] == 'iOS') ?? -1;
    if (Platform.isIOS && _index >= 0) {
      _Change _change = _Change.fromJson(data![_index]);
      changelog.changesFixes.add(_change);
    }

    return changelog;
  }
}

class _Change {
  late String module;
  late List<String> changes;

  _Change._();

  static _Change fromJson(Map<String, dynamic> json) {
    _Change change = _Change._();
    change.module = json['module']!;
    change.changes = (json['changes'] as List?)?.cast<String>() ?? [];
    return change;
  }
}
