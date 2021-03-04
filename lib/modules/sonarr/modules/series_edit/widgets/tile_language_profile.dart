import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditLanguageProfileTile extends StatelessWidget {
    final List<SonarrLanguageProfile> profiles;

    SonarrSeriesEditLanguageProfileTile({
        Key key,
        @required this.profiles,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Language Profile'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesEditState>().languageProfile.name),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await SonarrDialogs.editLanguageProfiles(context, profiles);
        if(_values[0]) context.read<SonarrSeriesEditState>().languageProfile = _values[1];
    }
}
