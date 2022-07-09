import 'package:flutter/material.dart';
import 'package:lunasea/deprecated/state/state.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/system/flavor.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/utils/links.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/utils/changelog/change.dart';
import 'package:lunasea/utils/changelog/changelog.dart';
import 'package:lunasea/widgets/ui.dart';

class ChangelogSheet extends LunaBottomModalSheet {
  static final _defaultMOTD =
      'Welcome to LunaSea!\n\nThank you for testing ${LunaFlavor.current.key} release builds! Please see below for all documented changes found in this release.';
  late Changelog _changelog;
  late String _version;

  @override
  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async {
    try {
      _version = await PackageInfo.fromPlatform().then((v) => v.version);
      await _loadChangelog();

      return this.showModal(builder: builder);
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to show changelog sheet',
        error,
        stack,
      );
    }
  }

  Future<void> _loadChangelog() async {
    final context = LunaState.navigatorKey.currentContext!;
    final asset = LunaFlavor.isStable
        ? 'assets/changelog_stable.json'
        : 'assets/changelog.json';

    _changelog = await DefaultAssetBundle.of(context)
        .loadString(asset)
        .then((c) => Changelog.fromJson(json.decode(c)));
  }

  @override
  Widget builder(BuildContext context) {
    final showDefaultMOTD = _changelog.motd?.isEmpty ?? true;
    return LunaListViewModal(
      children: [
        LunaHeader(
          text: '$_version (${LunaEnvironment.build})',
          subtitle: showDefaultMOTD ? _defaultMOTD : _changelog.motd,
        ),
        ..._buildChangeBlock(
          'lunasea.New'.tr(),
          _changelog.feat,
        ),
        ..._buildChangeBlock(
          'lunasea.Tweaks'.tr(),
          _changelog.tweaks,
        ),
        ..._buildChangeBlock(
          'lunasea.Fixes'.tr(),
          _changelog.fixes,
        ),
        if (LunaFlavor.isEdge)
          ..._buildChangeBlock(
            'lunasea.Chores'.tr(),
            _changelog.chores,
          ),
        if (LunaFlavor.isEdge)
          ..._buildChangeBlock(
            'lunasea.Docs'.tr(),
            _changelog.docs,
          ),
        const SizedBox(height: LunaUI.DEFAULT_MARGIN_SIZE / 2),
      ],
      actionBar: LunaBottomActionBar(
        actions: [
          LunaButton.text(
            text: 'lunasea.FullChangelog'.tr(),
            icon: Icons.track_changes_rounded,
            onTap: LunaFlavor.isStable
                ? LunaLinkedContent.CHANGELOG.launch
                : LunaBuild().openCommitHistory,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChangeBlock(String header, List<Change>? changes) {
    if (changes == null || changes.isEmpty) return [];
    return [
      LunaHeader(text: header),
      LunaTableCard(
        content: List<LunaTableContent>.generate(
          changes.length,
          (i) => LunaTableContent(
            body: changes[i].message.bulleted(),
            url: LunaBuild().getCommitUrl(changes[i].commit),
          ),
        ),
      ),
    ];
  }
}
