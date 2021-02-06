import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditMinimumAvailabilityTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Minimum Availability'),
        subtitle: LSSubtitle(text: context.watch<RadarrMoviesEditState>().availability.readable),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await RadarrDialogs.editMinimumAvailability(context);
        if(_values[0]) context.read<RadarrMoviesEditState>().availability = _values[1];
    }
}
