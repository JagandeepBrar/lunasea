import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryTile extends StatelessWidget {
    final SABnzbdHistoryData data;
    final ExpandableController _controller = ExpandableController();
    final Function() refresh;

    SABnzbdHistoryTile({
        @required this.data,
        @required this.refresh,
    });

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _expanded(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    LSTitle(
                                        text: data.name,
                                        softWrap: true,
                                        maxLines: 12,
                                    ),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: data.status,
                                                    bgColor: data.statusColor,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                ),
                                                children: [
                                                    TextSpan(text: data.completeTimeString),
                                                    TextSpan(text: '\t•\t'),
                                                    TextSpan(text: data.sizeReadable),
                                                    TextSpan(text: '\t•\t'),
                                                    TextSpan(text: data.category),
                                                    TextSpan(text: '\n\n'),
                                                    TextSpan(
                                                        text: data.storageLocation,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle.italic,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 10.0),
                                    ),
                                    Padding(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Stages',
                                                        onTap: () async => _enterStages(context),
                                                        margin: EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Delete',
                                                        backgroundColor: LunaColours.red,
                                                        onTap: () async => _delete(context),
                                                        margin: EdgeInsets.only(left: 6.0),
                                                    ),
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(bottom: 2.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                    ),
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _controller.toggle(),
            onLongPress: () async => _handlePopup(context),
        ),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
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
                    TextSpan(text: '\t•\t'),
                    TextSpan(text: data.category),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: data.statusString,
                        style: TextStyle(
                            color: data.statusColor,
                            fontWeight: FontWeight.bold,
                        ),
                    )
                ],
            ),
            maxLines: 2,
            overflow: TextOverflow.fade,
            softWrap: false,
        ),
        padContent: true,
        onTap: () => _controller.toggle(),
        onLongPress: () async => _handlePopup(context),
    );

    Future<void> _enterStages(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SABnzbdHistoryStages.ROUTE_NAME,
            arguments: SABnzbdHistoryStagesArguments(data: data),
        );
        if(result != null) switch(result[0]) {
            case 'delete': _handleRefresh(context, 'History Deleted'); break;
            default: LunaLogger().warning('SABnzbdHistoryTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup(BuildContext context) async {
        List values = await SABnzbdDialogs.historySettings(context, data.name, data.failed);
        if(values[0]) switch(values[1]) {
            case 'retry': _retry(context); break;
            case 'password': _password(context); break;
            case 'delete': _delete(context); break;
            default: LunaLogger().warning('SABnzbdHistoryTile', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _delete(BuildContext context) async {
        List values = await SABnzbdDialogs.deleteHistory(context);
        if(values[0]) {
            SABnzbdAPI.from(Database.currentProfileObject).deleteHistory(data.nzoId)
            .then((_) => _handleRefresh(context, 'History Deleted'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete History',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
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
