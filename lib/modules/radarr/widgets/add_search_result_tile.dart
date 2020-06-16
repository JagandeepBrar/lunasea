import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddSearchResultTile extends StatelessWidget {
    final bool alreadyAdded;
    final RadarrSearchData data;

    RadarrAddSearchResultTile({
        @required this.alreadyAdded,
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title, darken: alreadyAdded),
        subtitle: LSSubtitle(
            text: '${data.year} (${data.formattedStatus})\n${data.overview.trim()}',
            maxLines: 2,
            darken: alreadyAdded,
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
        title: 'Movie Already in Radarr',
        message: data.title,
    );

    Future<void> _enterDetails(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            RadarrAddDetails.ROUTE_NAME,
            arguments: RadarrAddDetailsArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'movie_added': Navigator.of(context).pop(result); break;
            default: Logger.warning('RadarrAddSearchResultTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }
}
