import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsQualityProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Quality Profile'),
        subtitle: Selector<RadarrAddMovieDetailsState, RadarrQualityProfile>(
            selector: (_, state) => state.qualityProfile,
            builder: (context, profile, _) => LunaText.subtitle(text: profile?.name ?? Constants.TEXT_EMDASH),
        ),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => onTap(context),
    );
    
    Future<void> onTap(BuildContext context) async {
        List<RadarrQualityProfile> qualityProfiles = await context.read<RadarrState>().qualityProfiles;
        List values = await RadarrDialogs.editQualityProfile(context, qualityProfiles);
        if(values[0]) context.read<RadarrAddMovieDetailsState>().qualityProfile = values[1];
    }
}
