import 'package:flutter/material.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/system/flavor.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/utils/changelog/sheet.dart';
import 'package:lunasea/widgets/ui.dart';

class BuildDetails extends ConsumerStatefulWidget {
  const BuildDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<BuildDetails> createState() => _State();
}

class _State extends ConsumerState<BuildDetails> {
  Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();
  Future<Tuple2<bool, int?>> checkUpdates = LunaBuild().isLatestBuildNumber();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: packageInfo,
      builder: (context, AsyncSnapshot<PackageInfo> package) {
        return FutureBuilder(
          future: checkUpdates,
          builder: (context, AsyncSnapshot<Tuple2<bool, int?>> updates) {
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
      onTap: ChangelogSheet().show,
    );
  }

  LunaButton _updatesButton(AsyncSnapshot<Tuple2<bool, int?>> updates) {
    if (updates.hasError) {
      return LunaButton.text(
        icon: LunaIcons.ERROR,
        text: 'Error',
      );
    }
    if (updates.connectionState == ConnectionState.done && updates.hasData) {
      if (updates.data!.item1) {
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
            checkUpdates = LunaBuild().isLatestBuildNumber();
          }),
        );
      }
    }

    return LunaButton.loader();
  }
}
