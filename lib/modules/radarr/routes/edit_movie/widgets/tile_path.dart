import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditPathTile extends StatelessWidget {
  const RadarrMoviesEditPathTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'radarr.MoviePath'.tr()),
      subtitle: LunaText.subtitle(
          text: context.watch<RadarrMoviesEditState>().path ??
              LunaUI.TEXT_EMDASH),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
            context, 'radarr.MoviePath'.tr(),
            prefill: context.read<RadarrMoviesEditState>().path);
        if (_values.item1)
          context.read<RadarrMoviesEditState>().path = _values.item2;
      },
    );
  }
}
