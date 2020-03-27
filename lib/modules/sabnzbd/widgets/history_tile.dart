import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sabnzbd.dart';

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
                style: TextStyle(color: Colors.white70),
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
            case 'delete': _handleDelete((context), 'History Deleted'); break;
            default: Logger.warning('SABnzbdHistoryTile', '_enterDetails', 'Unknown Case: ${result[0]}');
        }
        /** TODO */
    }

    Future<void> _handlePopup(BuildContext context) async {
        List values = await SABnzbdDialogs.showHistorySettingsPrompt(context, data.name, data.failed);
        /** TODO */
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
