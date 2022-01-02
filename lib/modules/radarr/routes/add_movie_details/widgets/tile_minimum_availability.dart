import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsMinimumAvailabilityTile extends StatelessWidget {
  const RadarrAddMovieDetailsMinimumAvailabilityTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrAddMovieDetailsState, RadarrAvailability>(
      selector: (_, state) => state.availability,
      builder: (context, availability, _) {
        return LunaBlock(
          title: 'radarr.MinimumAvailability'.tr(),
          body: [TextSpan(text: availability.readable)],
          trailing: const LunaIconButton.arrow(),
          onTap: () async {
            Tuple2<bool, RadarrAvailability?> values =
                await RadarrDialogs().editMinimumAvailability(context);
            if (values.item1)
              context.read<RadarrAddMovieDetailsState>().availability =
                  values.item2!;
          },
        );
      },
    );
  }
}
