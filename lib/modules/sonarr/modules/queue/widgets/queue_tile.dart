import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueQueueTile extends StatelessWidget {
    final SonarrQueueRecord record;

    SonarrQueueQueueTile({
        Key key,
        @required this.record,
    }) : super(key: key);

    final ExpandableController _controller = ExpandableController();

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: record.title),
        subtitle: LSSubtitle(text: '\n', maxLines: 2),
        trailing: LSIconButton(icon: record.lunaStatusIcon),
        padContent: true,
        onTap: () => _controller.toggle(),
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
                                    LSTitle(text: record.title, softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: record.protocol.lsLanguage_Capitalize(),
                                                    bgColor: record.protocol == 'torrent'
                                                        ? LunaColours.purple
                                                        : LunaColours.blue,
                                                ),
                                                LSTextHighlighted(
                                                    text: record.lunaStatusText,
                                                    bgColor: LunaColours.blueGrey,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _controller.toggle(),
        ),
    );
}
