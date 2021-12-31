import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsQualityProfileTile extends StatelessWidget {
  const RadarrAddMovieDetailsQualityProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrAddMovieDetailsState, RadarrQualityProfile>(
      selector: (_, state) => state.qualityProfile,
      builder: (context, profile, _) => LunaBlock(
        title: 'radarr.QualityProfile'.tr(),
        body: [TextSpan(text: profile.name ?? LunaUI.TEXT_EMDASH)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<RadarrQualityProfile> qualityProfiles =
              await context.read<RadarrState>().qualityProfiles!;
          Tuple2<bool, RadarrQualityProfile?> values = await RadarrDialogs()
              .editQualityProfile(context, qualityProfiles);
          if (values.item1)
            context.read<RadarrAddMovieDetailsState>().qualityProfile =
                values.item2!;
        },
      ),
    );
  }
}
