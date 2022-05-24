import 'package:flutter/material.dart';
import 'package:lunasea/core/utilities/changelog.dart';
import 'package:lunasea/extensions/string_links.dart';
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/system/flavor.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

class BuildDetails extends ConsumerStatefulWidget {
  const BuildDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<BuildDetails> createState() => _State();
}

class _State extends ConsumerState<BuildDetails> {
  Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();
  Future<bool> checkForUpdates = LunaBuild().checkForUpdates();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: packageInfo,
      builder: (context, AsyncSnapshot<PackageInfo> package) {
        return FutureBuilder(
          future: checkForUpdates,
          builder: (context, AsyncSnapshot<bool> updates) {
            return LunaTableCard(
              content: [
                LunaTableContent(
                  title: 'settings.Version'.tr(),
                  body: package.data?.version ?? 'lunasea.Unknown'.tr(),
                ),
                LunaTableContent(
                  title: 'settings.Platform'.tr(),
                  body: LunaPlatform.current.name,
                ),
                LunaTableContent(
                  title: 'settings.Channel'.tr(),
                  body: LunaFlavor.current.name,
                ),
                LunaTableContent(
                  title: 'settings.Build'.tr(),
                  body: '${LunaEnvironment.build} (${LunaBuild().shortCommit})',
                ),
              ],
              buttons: [
                _changesButton(context),
                _updatesButton(updates),
              ],
            );
          },
        );
      },
    );
  }

  LunaButton _changesButton(BuildContext context) {
    return LunaButton.text(
      icon: LunaIcons.CHANGELOG,
      text: 'lunasea.Changelog'.tr(),
      onTap: () async => LunaChangelogSheet().show(
        context: context,
        showCommitHistory: true,
      ),
    );
  }

  LunaButton _updatesButton(AsyncSnapshot<bool> updates) {
    if (updates.hasError) {
      return LunaButton.text(
        icon: LunaIcons.ERROR,
        text: 'Error',
      );
    }
    if (updates.connectionState == ConnectionState.done && updates.hasData) {
      if (updates.data!) {
        return LunaButton.text(
          icon: LunaIcons.DOWNLOAD,
          color: LunaColours.orange,
          text: 'settings.DownloadUpdate'.tr(),
          onTap: LunaFlavor.current.downloadLink.openLink,
        );
      } else {
        return LunaButton.text(
          icon: LunaIcons.CHECK_MARK,
          color: LunaColours.accent,
          text: 'settings.UpToDate'.tr(),
          onTap: () => setState(() {
            checkForUpdates = LunaBuild().checkForUpdates();
          }),
        );
      }
    }

    return LunaButton.loader();
  }
}
