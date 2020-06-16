import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryTile extends StatefulWidget {
    final SonarrHistoryData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    SonarrHistoryTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<SonarrHistoryTile> createState() => _State();
}

class _State extends State<SonarrHistoryTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.seriesTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: widget.data.subtitle,
            ),
        ),
        trailing: LSIconButton(
            icon: Icons.arrow_forward_ios,
        ),
        padContent: true,
        onTap: () async => _enterSeries(),
    );

    Future<void> _enterSeries() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SonarrDetailsSeries.ROUTE_NAME,
            arguments: SonarrDetailsSeriesArguments(
                data: null,
                seriesID: widget.data.seriesID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_series': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.data.seriesTitle,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
            default: Logger.warning('SonarrHistoryTile', '_enterSeries', 'Unknown Case: ${result[0]}');
        }
    }
}
