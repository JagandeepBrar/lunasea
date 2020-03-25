import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetHistoryTile extends StatelessWidget {
    final NZBGetHistoryData data;
    final Function() deleteCallback;

    NZBGetHistoryTile({
        @required this.data,
        @required this.deleteCallback,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.name),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
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

    void _handleDelete(BuildContext context, String title) {
        LSSnackBar(
            context: context,
            title: title,
            message: data.name,
            type: SNACKBAR_TYPE.success,
        );
        deleteCallback();
    }
}
