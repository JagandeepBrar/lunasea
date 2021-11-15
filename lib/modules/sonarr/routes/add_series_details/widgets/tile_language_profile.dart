import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsLanguageProfileTile extends StatelessWidget {
  const SonarrSeriesAddDetailsLanguageProfileTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'sonarr.LanguageProfile'.tr()),
      subtitle: LunaText.subtitle(
          text: context
                  .watch<SonarrSeriesAddDetailsState>()
                  .languageProfile
                  ?.name ??
              LunaUI.TEXT_EMDASH),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<SonarrLanguageProfile> _profiles =
        await context.read<SonarrState>().languageProfiles;
    Tuple2<bool, SonarrLanguageProfile> result =
        await SonarrDialogs().editLanguageProfiles(context, _profiles);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().languageProfile =
          result.item2;
      SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE
          .put(result.item2.id);
    }
  }
}
