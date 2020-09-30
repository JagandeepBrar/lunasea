import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsSeriesTypeTile extends StatefulWidget {
    final SonarrSeriesLookup series;

    SonarrSeriesAddDetailsSeriesTypeTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddDetailsSeriesTypeTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsSeriesTypeTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Series Type'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE.key]),
            builder: (context, box, _) => LSSubtitle(
                text: SonarrSeriesType.STANDARD.from(SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE.data)?.value?.lsLanguage_Capitalize() ?? Constants.TEXT_EMDASH,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: _onTap,
    );

    Future<void> _onTap() async {
        List _values = await SonarrDialogs.editSeriesType(context);
        if(_values[0]) {
            SonarrSeriesType _type = _values[1];
            widget.series.seriesType = _type;
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE.put(_type.value);
        }
    }
}
