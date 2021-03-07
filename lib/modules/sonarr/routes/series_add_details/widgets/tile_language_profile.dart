import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsLanguageProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Language Profile'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesAddDetailsState>().languageProfile?.name ?? Constants.TEXT_EMDASH),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List<SonarrLanguageProfile> _profiles = await context.read<SonarrState>().languageProfiles;
        List _values = await SonarrDialogs.editLanguageProfiles(context, _profiles);
        if(_values[0]) {
            context.read<SonarrSeriesAddDetailsState>().languageProfile = _values[1];
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.put((_values[1] as SonarrLanguageProfile).id);
        }
    }
}
