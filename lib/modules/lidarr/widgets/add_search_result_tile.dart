import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearchResultTile extends StatelessWidget {
    final bool alreadyAdded;
    final LidarrSearchData data;

    LidarrAddSearchResultTile({
        @required this.alreadyAdded,
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title, darken: alreadyAdded),
        subtitle: LSSubtitle(
            text: data.overview.trim()+"\n\n",
            darken: alreadyAdded,
            maxLines: 2,
        ),
        padContent: true,
        trailing: alreadyAdded
            ? null
            : LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: alreadyAdded
            ? () => _showAlreadyAddedMessage(context)
            : () async => _enterDetails(context),
        
    );

    Future<void> _showAlreadyAddedMessage(BuildContext context) => LSSnackBar(
        context: context,
        title: 'Artist Already in Lidarr',
        message: data.title,
    );

    Future<void> _enterDetails(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrAddDetails.ROUTE_NAME,
            arguments: LidarrAddDetailsArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'artist_added': Navigator.of(context).pop(result); break;
            default: Logger.warning('LidarrAddSearchResultTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }
}
