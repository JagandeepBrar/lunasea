import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditTagsTile extends StatelessWidget {
  const RadarrMoviesEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RadarrTag> _tags = context.watch<RadarrMoviesEditState>().tags;
    return LunaBlock(
      title: 'radarr.Tags'.tr(),
      body: [
        TextSpan(
          text: _tags.isEmpty
              ? LunaUI.TEXT_EMDASH
              : _tags.map((e) => e.label).join(', '),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await RadarrDialogs().setEditTags(context),
    );
  }
}
