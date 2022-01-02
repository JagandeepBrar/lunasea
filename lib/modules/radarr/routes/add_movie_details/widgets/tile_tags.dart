import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsTagsTile extends StatelessWidget {
  const RadarrAddMovieDetailsTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'radarr.Tags'.tr(),
      body: [
        TextSpan(
          text: context.watch<RadarrAddMovieDetailsState>().tags.isEmpty
              ? LunaUI.TEXT_EMDASH
              : context
                  .watch<RadarrAddMovieDetailsState>()
                  .tags
                  .map((e) => e.label)
                  .join(', '),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await RadarrDialogs().setAddTags(context),
    );
  }
}
