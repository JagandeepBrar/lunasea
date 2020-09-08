import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsTautulliLogTile extends StatelessWidget {
    final TautulliLog log;
    final ExpandableController _controller = ExpandableController();

    TautulliLogsTautulliLogTile({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: log.message.trim()),
        subtitle: _subtitle,
        padContent: true,
        onTap: () => _controller.toggle(),
    );

    Widget get _subtitle => RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            children: [
                TextSpan(text: '${log.level}\n'),
                TextSpan(
                    text: log.timestamp,
                    style: TextStyle(
                        color: LSColors.accent,
                        fontWeight: FontWeight.w600,
                    )
                ),
            ],
        ),
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 2,
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
                                    LSTitle(text: log.message.trim(), softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: log.level,
                                                    bgColor: LSColors.blue,
                                                ),
                                                LSTextHighlighted(
                                                    text: log.timestamp,
                                                    bgColor: LSColors.accent,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                    ),
                                    Padding(
                                        child: LSSubtitle(text: log.thread),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 2.0),
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
        ),
    );
}
