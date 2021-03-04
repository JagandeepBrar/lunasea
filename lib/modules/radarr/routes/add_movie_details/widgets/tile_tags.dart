import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsTagsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Tags'),
            subtitle: LunaText.subtitle(text: context.watch<RadarrAddMovieDetailsState>().tags.length == 0
                ? LunaUI.TEXT_EMDASH
                : context.watch<RadarrAddMovieDetailsState>().tags.map((e) => e.label).join(', ')),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async => await RadarrDialogs().setAddTags(context),
        );
    }
}
