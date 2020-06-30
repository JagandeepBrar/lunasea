import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistoryTile extends StatelessWidget {
    final NZBGetHistoryData data;
    final Function() refresh;

    NZBGetHistoryTile({
        @required this.data,
        @required this.refresh,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.name),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: data.completeTime),
                    TextSpan(text: '\t•\t'),
                    TextSpan(text: data.sizeReadable),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: data.statusString,
                        style: TextStyle(
                            color: data.statusColor,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ],
            ),
            maxLines: 2,
            overflow: TextOverflow.fade,
            softWrap: false,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        padContent: true,
        onTap: () async => _enterDetails(context),
        onLongPress: () async => _handlePopup(context),
    );

    Future<void> _enterDetails(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            NZBGetHistoryDetails.ROUTE_NAME,
            arguments: NZBGetHistoryDetailsArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'delete': _handleDelete((context), 'History Deleted'); break;
            case 'hide': _handleDelete((context), 'History Hidden'); break;
            default: Logger.warning('NZBGetHistoryTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup(BuildContext context) async {
        List values = await NZBGetDialogs.historySettings(context, data.name);
        if(values[0]) switch(values[1]) {
            case 'retry': {
                await NZBGetAPI.from(Database.currentProfileObject).retryHistoryEntry(data.id)
                .then((_) {
                    refresh();
                    LSSnackBar(
                        context: context,
                        title: 'Retrying Job...',
                        message: data.name,
                    );
                })
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Retry Job',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
                break;
            }
            case 'hide': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(data.id, hide: true)
            .then((_) => _handleDelete(context, 'History Hidden'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Hide History',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
            break;
            case 'delete': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(data.id, hide: true)
            .then((_) => _handleDelete(context, 'History Deleted'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete History',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }

    void _handleDelete(BuildContext context, String title) {
        LSSnackBar(
            context: context,
            title: title,
            message: data.name,
            type: SNACKBAR_TYPE.success,
        );
        refresh();
    }
}
