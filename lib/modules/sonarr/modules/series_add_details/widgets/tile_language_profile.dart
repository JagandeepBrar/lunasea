import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsLanguageProfileTile extends StatefulWidget {
    final SonarrSeriesLookup series;
    final List<SonarrLanguageProfile> profiles;

    SonarrSeriesAddDetailsLanguageProfileTile({
        Key key,
        @required this.series,
        @required this.profiles,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsLanguageProfileTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Language Profile'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.key]),
            builder: (context, box, _) => LSSubtitle(
                text: widget.profiles.firstWhere(
                    (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
                    orElse: () => null,
                )?.name ?? Constants.TEXT_EMDASH,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: _onTap,
    );

    Future<void> _onTap() async {
        List _values = await SonarrDialogs.editLanguageProfiles(context, widget.profiles);
        if(_values[0]) {
            SonarrLanguageProfile _profile = _values[1];
            widget.series.languageProfileId = _profile.id;
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.put(_profile.id);
        }
    }
}
