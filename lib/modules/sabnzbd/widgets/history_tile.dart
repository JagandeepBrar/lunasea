import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryTile extends StatelessWidget {
    final SABnzbdHistoryData data;
    final Function() refresh;

    SABnzbdHistoryTile({
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
                    TextSpan(text: data.completeTimeString),
                    TextSpan(text: '\t•\t'),
                    TextSpan(text: data.sizeReadable),
                    TextSpan(text: '\n'),
                    data.getStatus,
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
            SABnzbdHistoryDetails.ROUTE_NAME,
            arguments: SABnzbdHistoryDetailsArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'delete': _handleRefresh(context, 'History Deleted'); break;
            default: Logger.warning('SABnzbdHistoryTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup(BuildContext context) async {
        List values = await SABnzbdDialogs.historySettings(context, data.name, data.failed);
        if(values[0]) switch(values[1]) {
            case 'retry': _retry(context); break;
            case 'password': _password(context); break;
            case 'delete': _delete(context); break;
            default: Logger.warning('SABnzbdHistoryTile', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _delete(BuildContext context) async {
        SABnzbdAPI.from(Database.currentProfileObject).deleteHistory(data.nzoId)
        .then((_) => _handleRefresh(context, 'History Deleted'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Delete History',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _password(BuildContext context) async {
        List values = await SABnzbdDialogs.setPassword(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).retryFailedJobPassword(data.nzoId, values[1])
        .then((_) => _handleRefresh(context, 'Password Set / Retrying...'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Set Password / Retry Job',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _retry(BuildContext context) async {
        SABnzbdAPI.from(Database.currentProfileObject).retryFailedJob(data.nzoId)
        .then((_) => _handleRefresh(context, 'Retrying Job'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Retry Job',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    void _handleRefresh(BuildContext context, String title) {
        LSSnackBar(
            context: context,
            title: title,
            message: data.name,
            type: SNACKBAR_TYPE.success,
        );
        refresh();
    }
}
