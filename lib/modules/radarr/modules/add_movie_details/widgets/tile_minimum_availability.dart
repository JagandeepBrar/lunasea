import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsMinimumAvailabilityTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Minimum Availability'),
        subtitle: Selector<RadarrAddMovieDetailsState, RadarrAvailability>(
            selector: (_, state) => state.availability,
            builder: (context, availability, _) => LunaText.subtitle(text: availability?.readable ?? Constants.TEXT_EMDASH),
        ),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );
    
    Future<void> _onTap(BuildContext context) async {
        Tuple2<bool, RadarrAvailability> values = await RadarrDialogs().editMinimumAvailability(context);
        if(values.item1) context.read<RadarrAddMovieDetailsState>().availability = values.item2;
    }
}
