import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsQualityProfileTile extends StatelessWidget {
  const RadarrAddMovieDetailsQualityProfileTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'radarr.QualityProfile'.tr()),
      subtitle: Selector<RadarrAddMovieDetailsState, RadarrQualityProfile>(
        selector: (_, state) => state.qualityProfile,
        builder: (context, profile, _) =>
            LunaText.subtitle(text: profile?.name ?? LunaUI.TEXT_EMDASH),
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        List<RadarrQualityProfile> qualityProfiles =
            await context.read<RadarrState>().qualityProfiles;
        Tuple2<bool, RadarrQualityProfile> values =
            await RadarrDialogs().editQualityProfile(context, qualityProfiles);
        if (values.item1)
          context.read<RadarrAddMovieDetailsState>().qualityProfile =
              values.item2;
      },
    );
  }
}
