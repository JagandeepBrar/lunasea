import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSearchResultTile extends StatelessWidget {
    final bool alreadyAdded;
    final SonarrSearchData data;

    SonarrAddSearchResultTile({
        @required this.alreadyAdded,
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title, darken: alreadyAdded),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: alreadyAdded ? Colors.white30 : Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: data.year.toString()),
                    TextSpan(text: ' (${data.status.lsLanguage_Capitalize()})'),
                    TextSpan(text: '\t•\t${data.seasonCountString}'),
                    TextSpan(text: '\n${data.overview.trim()}'),
                ]
            ),
            maxLines: 2,
            overflow: TextOverflow.fade,
            softWrap: false,
        ),
        trailing: alreadyAdded
            ? null
            : LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: alreadyAdded
            ? () => _showAlreadyAddedMessage(context)
            : () async => _enterDetails(context),
        padContent: true,
    );

    Future<void> _showAlreadyAddedMessage(BuildContext context) => LSSnackBar(
        context: context,
        title: 'Series Already in Sonarr',
        message: data.title,
    );

    Future<void> _enterDetails(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SonarrAddDetails.ROUTE_NAME,
            arguments: SonarrAddDetailsArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'series_added': Navigator.of(context).pop(result); break;
            default: Logger.warning('SonarrAddSearchResultTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }
}
