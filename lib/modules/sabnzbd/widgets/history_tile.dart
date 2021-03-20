import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryTile extends StatefulWidget {
    final SABnzbdHistoryData data;
    final Function() refresh;

    SABnzbdHistoryTile({
        @required this.data,
        @required this.refresh,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdHistoryTile> {

    @override
    Widget build(BuildContext context) {
        return LunaExpandableListTile(
            title: widget.data.name,
            collapsedSubtitle1: _subtitle1(),
            collapsedSubtitle2: _subtitle2(),
            expandedTableContent: _expandedTableContent(),
            expandedHighlightedNodes: _expandedHighlightedNodes(),
            expandedTableButtons: _expandedButtons(),
            onLongPress: () async => _handlePopup(context),
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(
            children: [
                TextSpan(text: widget.data.completeTimeString),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.data.sizeReadable),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.data.category),
            ]
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

    List<LunaTableContent> _expandedTableContent() {
        return [
            LunaTableContent(title: 'age', body: widget.data.completeTimeString),
            LunaTableContent(title: 'size', body: widget.data.sizeReadable),
            LunaTableContent(title: 'category', body: widget.data.category),
            LunaTableContent(title: 'path', body: widget.data.storageLocation),
        ];
    }

    List<LunaHighlightedNode> _expandedHighlightedNodes() {
        return [
            LunaHighlightedNode(
                text: widget.data.status,
                backgroundColor: widget.data.statusColor,
            ),
        ];
    }

    List<LunaButton> _expandedButtons() {
        return [
            LunaButton.text(
                text: 'Stages',
                onTap: () async => _enterStages(context),
            ),
            LunaButton.text(
                text: 'Delete',
                backgroundColor: LunaColours.red,
                onTap: () async => _delete(context),
            ),
        ];
    }

    Future<void> _enterStages(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SABnzbdHistoryStages.ROUTE_NAME,
            arguments: SABnzbdHistoryStagesArguments(data: widget.data),
        );
        if(result != null) switch(result[0]) {
            case 'delete': _handleRefresh(context, 'History Deleted'); break;
            default: LunaLogger().warning('SABnzbdHistoryTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup(BuildContext context) async {
        List values = await SABnzbdDialogs.historySettings(context, widget.data.name, widget.data.failed);
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
            SABnzbdAPI.from(Database.currentProfileObject).deleteHistory(widget.data.nzoId)
            .then((_) => _handleRefresh(context, 'History Deleted'))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete History',
                message: LunaLogger.checkLogsMessage,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }

    Future<void> _password(BuildContext context) async {
        List values = await SABnzbdDialogs.setPassword(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).retryFailedJobPassword(widget.data.nzoId, values[1])
        .then((_) => _handleRefresh(context, 'Password Set / Retrying...'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Set Password / Retry Job',
            message: LunaLogger.checkLogsMessage,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _retry(BuildContext context) async {
        SABnzbdAPI.from(Database.currentProfileObject).retryFailedJob(widget.data.nzoId)
        .then((_) => _handleRefresh(context, 'Retrying Job'))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Retry Job',
            message: LunaLogger.checkLogsMessage,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    void _handleRefresh(BuildContext context, String title) {
        LSSnackBar(
            context: context,
            title: title,
            message: widget.data.name,
            type: SNACKBAR_TYPE.success,
        );
        widget.refresh();
    }
}
