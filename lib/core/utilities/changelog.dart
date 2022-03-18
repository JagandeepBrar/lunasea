import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaChangelogSheet extends LunaBottomModalSheet {
  late _Changelog _changelog;
  String _version = '';
  String _buildNumber = '';

  @override
  Future<dynamic> show({
    required BuildContext? context,
    Widget Function(BuildContext context)? builder,
    bool checkBuildNumber = false,
    bool showCommitHistory = false,
  }) async {
    // Do not show unless it is a prod release
    if (LunaFlavor().isLowerOrEqualTo(LunaEnvironment.BETA)) {
      if (showCommitHistory) LunaFlavor().openCommitHistory();
      return;
    }

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

  static _Changelog fromJson(Map<String, dynamic> json) {
    _Changelog changelog = _Changelog();
    List<dynamic>? data;

    changelog.motd = json['motd'] ?? 'Welcome to LunaSea!';

    data = json['new'];
    data?.forEach((c) => changelog.changesNew.add(_Change.fromJson(c)));

    data = json['tweaks'];
    data?.forEach((c) => changelog.changesTweaks.add(_Change.fromJson(c)));

    data = json['fixes'];
    data?.forEach((c) => changelog.changesFixes.add(_Change.fromJson(c)));

    return changelog;
  }
}

class _Change {
  late String module;
  late List<String> changes;

  _Change._();

  static _Change fromJson(Map<String, dynamic> json) {
    _Change change = _Change._();
    change.module = json['module'] as String;
    change.changes = (json['changes'] as List).cast<String>();
    return change;
  }
}
