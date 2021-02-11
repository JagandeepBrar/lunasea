import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsTagsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Tags'),
        subtitle: LunaText.subtitle(text: context.watch<RadarrAddMovieDetailsState>().tags.length == 0
            ? LunaUI().textEmDash
            : context.watch<RadarrAddMovieDetailsState>().tags.map((e) => e.label).join(', ')),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => await RadarrDialogs().setAddTags(context);
}
