import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsQualityProfileTile extends StatefulWidget {
    final SonarrSeriesLookup series;
    final List<SonarrQualityProfile> profiles;

    SonarrSeriesAddDetailsQualityProfileTile({
        Key key,
        @required this.series,
        @required this.profiles,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsQualityProfileTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Quality Profile'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.key]),
            builder: (context, box, _) => LSSubtitle(
                text: widget.profiles.firstWhere(
                    (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
                    orElse: () => null,
                )?.name ?? Constants.TEXT_EMDASH,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: _onTap,
    );

    Future<void> _onTap() async {
        List _values = await SonarrDialogs.editQualityProfile(context, widget.profiles);
        if(_values[0]) {
            SonarrQualityProfile _profile = _values[1];
            widget.series.profileId = _profile.id;
            widget.series.qualityProfileId = _profile.id;
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.put(_profile.id);
        }
    }
}
