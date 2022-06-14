import 'package:flutter/material.dart';
import 'package:lunasea/deprecated/state/state.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/utils/links.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/changelog/change.dart';
import 'package:lunasea/widgets/changelog/changelog.dart';
import 'package:lunasea/widgets/ui.dart';

class ChangelogSheet extends LunaBottomModalSheet {
  late Changelog _changelog;
  late String _version;

  @override
  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async {
    try {
      final context = LunaState.navigatorKey.currentContext!;
      _version = await PackageInfo.fromPlatform().then((v) => v.version);
      _changelog = await DefaultAssetBundle.of(context)
          .loadString('assets/changelog.json')
          .then((c) => Changelog.fromJson(json.decode(c)));
      return this.showModal(builder: builder);
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to show changelog sheet',
        error,
        stack,
      );
    }
  }

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        LunaHeader(
          text: _version,
          subtitle: _changelog.motd ?? 'Welcome to LunaSea!',
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
        const SizedBox(height: LunaUI.DEFAULT_MARGIN_SIZE / 2),
      ],
      actionBar: LunaBottomActionBar(
        actions: [
          LunaButton.text(
            text: 'lunasea.FullChangelog'.tr(),
            icon: Icons.track_changes_rounded,
            onTap: LunaLinkedContent.CHANGELOG.launch,
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
            title: changes[i].module,
            body: changes[i].changes.map((s) => s.bulleted()).join('\n'),
          ),
        ),
      ),
    ];
  }
}
