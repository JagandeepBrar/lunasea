import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistoryTile extends StatelessWidget {
    final NZBGetHistoryData data;
    final ExpandableController _controller = ExpandableController();
    final Function() refresh;

    NZBGetHistoryTile({
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
                                                    text: data.statusString,
                                                    bgColor: data.statusColor,
                                                ),
                                                LSTextHighlighted(
                                                    text: data.healthString,
                                                    bgColor: LunaColours.blueGrey,
                                                )
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
                                                    TextSpan(text: data.completeTime),
                                                    TextSpan(text: '\t•\t'),
                                                    TextSpan(text: data.sizeReadable),
                                                    TextSpan(text: '\t•\t'),
                                                    TextSpan(
                                                        text: data.category.isEmpty
                                                            ? "No Category"
                                                            : data.category
                                                    ),
                                                    TextSpan(text: '\n'),
                                                    TextSpan(text: 'Average Speed of ${data.downloadSpeed}'),
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
                                                        text: 'Delete',
                                                        backgroundColor: LunaColours.red,
                                                        onTap: () async => _deleteButton(context),
                                                        margin: EdgeInsets.zero,
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
                    TextSpan(text: data.completeTime),
                    TextSpan(text: '\t•\t'),
                    TextSpan(text: data.sizeReadable),
                    TextSpan(text: '\t•\t'),
                    TextSpan(
                        text: data.category.isEmpty
                            ? "No Category"
                            : data.category
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: data.statusString,
                        style: TextStyle(
                            color: data.statusColor,
                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        ),
                    ),
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
                    message: LunaLogger.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
                break;
            }
            case 'hide': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(data.id, hide: true)
            .then((_) => _handleDelete(context, 'History Hidden'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Hide History',
                message: LunaLogger.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
            break;
            case 'delete': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(data.id, hide: true)
            .then((_) => _handleDelete(context, 'History Deleted'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete History',
                message: LunaLogger.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }

    Future<void> _deleteButton(BuildContext context) async {
        List<dynamic> values = await NZBGetDialogs.deleteHistory(context);
        if(values[0]) await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(
            data.id,
            hide: values[1],
        )
        .then((_) => _handleDelete(context, values[1] ? 'History Hidden' : 'History Deleted'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Delete History',
            message: LunaLogger.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
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
