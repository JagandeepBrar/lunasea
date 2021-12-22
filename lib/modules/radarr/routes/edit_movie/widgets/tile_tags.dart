import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditTagsTile extends StatelessWidget {
  const RadarrMoviesEditTagsTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrMoviesEditState, List<RadarrTag>>(
      selector: (_, state) => state.tags,
      builder: (context, tags, _) => LunaBlock(
        title: 'radarr.Tags'.tr(),
        body: [
          TextSpan(
            text: tags.isEmpty
                ? LunaUI.TEXT_EMDASH
                : tags.map((e) => e.label).join(', '),
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async => await RadarrDialogs().setEditTags(context),
      ),
    );
  }
}
