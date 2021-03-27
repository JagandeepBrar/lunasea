import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistoryTile extends StatefulWidget {
    final NZBGetHistoryData data;
    final Function() refresh;

    NZBGetHistoryTile({
        @required this.data,
        @required this.refresh,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetHistoryTile> {
    @override
    Widget build(BuildContext context) {
        return LunaExpandableListTile(
            title: widget.data.name,
            collapsedSubtitle1: _subtitle1(),
            collapsedSubtitle2: _subtitle2(),
            expandedHighlightedNodes: _expandedHighlightedNodes(),
            expandedTableContent: _expandedTableContent(),
            expandedTableButtons: _expandedTableButtons(),
            onLongPress: () async => _handlePopup(),
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(
            children: [
                TextSpan(text: widget.data.completeTime),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.data.sizeReadable),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: (widget.data.category ?? '').isEmpty ? 'No Category' : widget.data.category),
            ],
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(
            text: widget.data.statusString,
            style: TextStyle(
                color: widget.data.statusColor,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
        );
    }

    List<LunaHighlightedNode> _expandedHighlightedNodes() {
        return [
            LunaHighlightedNode(
                text: widget.data.statusString,
                backgroundColor: widget.data.statusColor,
            ),
            LunaHighlightedNode(
                text: widget.data.healthString,
                backgroundColor: LunaColours.blueGrey,
            )
        ];
    }

    List<LunaTableContent> _expandedTableContent() {
        return [
            LunaTableContent(title: 'age', body: widget.data.completeTime),
            LunaTableContent(title: 'size', body: widget.data.sizeReadable),
            LunaTableContent(title: 'category', body: (widget.data.category ?? '').isEmpty ? 'No Category' : widget.data.category),
            LunaTableContent(title: 'speed', body: widget.data.downloadSpeed),
            LunaTableContent(title: 'path', body: widget.data.storageLocation),
        ];
    }

    List<LunaButton> _expandedTableButtons() {
        return [
            LunaButton.text(
                text: 'Delete',
                icon: Icons.delete_rounded,
                color: LunaColours.red,
                onTap: () async => _deleteButton(),
            ),
        ];
    }

    Future<void> _handlePopup() async {
        List values = await NZBGetDialogs.historySettings(context, widget.data.name);
        if(values[0]) switch(values[1]) {
            case 'retry': {
                await NZBGetAPI.from(Database.currentProfileObject).retryHistoryEntry(widget.data.id)
                .then((_) {
                    widget.refresh();
                    LSSnackBar(
                        context: context,
                        title: 'Retrying Job...',
                        message: widget.data.name,
                    );
                })
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Retry Job',
                    message: LunaLogger.checkLogsMessage,
                    type: SNACKBAR_TYPE.failure,
                ));
                break;
            }
            case 'hide': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(widget.data.id, hide: true)
            .then((_) => _handleDelete('History Hidden'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Hide History',
                message: LunaLogger.checkLogsMessage,
                type: SNACKBAR_TYPE.failure,
            ));
            break;
            case 'delete': await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(widget.data.id, hide: true)
            .then((_) => _handleDelete('History Deleted'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete History',
                message: LunaLogger.checkLogsMessage,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }

    Future<void> _deleteButton() async {
        List<dynamic> values = await NZBGetDialogs.deleteHistory(context);
        if(values[0]) await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(
            widget.data.id,
            hide: values[1],
        )
        .then((_) => _handleDelete(values[1] ? 'History Hidden' : 'History Deleted'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Delete History',
            message: LunaLogger.checkLogsMessage,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    void _handleDelete(String title) {
        LSSnackBar(
            context: context,
            title: title,
            message: widget.data.name,
            type: SNACKBAR_TYPE.success,
        );
        widget.refresh();
    }
}
