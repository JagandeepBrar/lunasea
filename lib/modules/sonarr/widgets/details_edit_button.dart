import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrDetailsEditButton extends StatefulWidget {
    final SonarrCatalogueData data;
    final Function(bool) remove;
    
    SonarrDetailsEditButton({
        @required this.data,
        @required this.remove,
    });

    @override
    State<SonarrDetailsEditButton> createState() => _State();
}

class _State extends State<SonarrDetailsEditButton> {
    @override
    Widget build(BuildContext context) => Consumer<SonarrModel>(
        builder: (context, model, widget) => LSIconButton(
            icon: Icons.edit,
            onPressed: () => _handlePopup(context),
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await SonarrDialogs.showEditSeriesPrompt(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_series': _refreshSeries(context); break;
            case 'edit_series': _editSeries(context); break;
            case 'remove_series': _removeSeries(context); break;
            default: Logger.warning('SonarrDetailsEditButton', '_handlePopup', 'Unknown Case: (${values[1]})');
        }
    }

    Future<void> _editSeries(BuildContext context) async {
        /** TODO */
    }

    Future<void> _refreshSeries(BuildContext context) async {
        /** TODO */
    }

    Future<void> _removeSeries(BuildContext context) async {
        /** TODO */
    }
}
