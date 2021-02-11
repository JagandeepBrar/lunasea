import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditMinimumAvailabilityTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Minimum Availability'),
            subtitle: LunaText.subtitle(text: context.watch<RadarrMoviesEditState>().availability.readable),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _onTap(context),
        );
    }

    Future<void> _onTap(BuildContext context) async {
        Tuple2<bool, RadarrAvailability> _values = await RadarrDialogs().editMinimumAvailability(context);
        if(_values.item1) context.read<RadarrMoviesEditState>().availability = _values.item2;
    }
}
