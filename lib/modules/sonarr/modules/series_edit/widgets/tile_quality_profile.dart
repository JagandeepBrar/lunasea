import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditQualityProfileTile extends StatelessWidget {
    final List<SonarrQualityProfile> profiles;

    SonarrSeriesEditQualityProfileTile({
        Key key,
        @required this.profiles,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Quality Profile'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesEditState>().qualityProfile.name),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await SonarrDialogs.editQualityProfile(context, profiles);
        if(_values[0]) context.read<SonarrSeriesEditState>().qualityProfile = _values[1];
    }
}
