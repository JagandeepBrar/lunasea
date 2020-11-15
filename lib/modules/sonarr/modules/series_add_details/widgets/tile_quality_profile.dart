import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsQualityProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Quality Profile'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesAddDetailsState>().qualityProfile?.name ?? Constants.TEXT_EMDASH),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List<SonarrQualityProfile> _profiles = await context.read<SonarrState>().qualityProfiles;
        List _values = await SonarrDialogs.editQualityProfile(context, _profiles);
        if(_values[0]) {
            context.read<SonarrSeriesAddDetailsState>().qualityProfile = _values[1];
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.put((_values[1] as SonarrQualityProfile).id);
        }
    }
}
