import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaExpandableListTile extends StatefulWidget {
    final String title;
    final TextSpan collapsedSubtitle1;
    final TextSpan collapsedSubtitle2;
    final Widget collapsedTrailing;
    final Widget collapsedLeading;
    final Color backgroundColor;
    final Function onLongPress;
    final List<LunaHighlightedNode> expandedHighlightedNodes;
    final List<LunaTableContent> expandedTableContent;
    final List<LunaButton> expandedTableButtons;
    final Widget expandedCustomWidget;
    final bool initialExpanded;

    /// Create a [LunaExpandableListTile] which is a list tile that expands into a table-style card.
    /// 
    /// If [expandedWidget] is supplied, that widget is used as the body within the expanded card.
    /// Any 
    LunaExpandableListTile({
        Key key,
        @required this.title,
        @required this.collapsedSubtitle1,
        this.collapsedSubtitle2,
        this.collapsedTrailing,
        this.collapsedLeading,
        this.onLongPress,
        this.expandedHighlightedNodes,
        this.expandedTableContent,
        this.expandedTableButtons,
        this.expandedCustomWidget,
        this.backgroundColor,
        this.initialExpanded = false,
    }) : super(key: key) {
        assert(title != null);
        assert(collapsedSubtitle1 != null);
        if(expandedCustomWidget == null) {
            assert(expandedTableContent != null);
        }
    }

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaExpandableListTile> {
    ExpandableController controller;

    @override
    void initState() {
        super.initState();
        controller = ExpandableController(initialExpanded: widget.initialExpanded);
    }

    @override
    void dispose() {
        controller?.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return ExpandableNotifier(
            controller: controller,
            child: Expandable(
                collapsed: collapsed(),
                expanded: expanded(),
            ),
        );
    }

    Widget collapsed() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: widget.title),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                        color: Colors.white70,
                    ),
                    children: [
                        widget.collapsedSubtitle1,
                        if(widget.collapsedSubtitle2 != null) TextSpan(text: '\n'),
                        if(widget.collapsedSubtitle2 != null) widget.collapsedSubtitle2,
                    ],
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
            ),
            onTap: controller.toggle,
            onLongPress: widget.onLongPress,
            contentPadding: widget.collapsedSubtitle2 != null,
            trailing: widget.collapsedTrailing,
            leading: widget.collapsedLeading,
            color: widget.backgroundColor,
        );
    }

    Widget expanded() {
        Widget child = widget.expandedCustomWidget ?? Row(
            children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                                child: LunaText.title(
                                    text: widget.title,
                                    softWrap: true,
                                    maxLines: 8,
                                ),
                                padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0, top: 10.0),
                            ),
                            if(widget.expandedHighlightedNodes != null) Padding(
                                child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: widget.expandedHighlightedNodes,
                                ),
                                padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0, top: 0.0),
                            ),
                            Padding(
                                child: Column(
                                    children: [
                                        ...widget.expandedTableContent.map<Widget>((content) => Padding(
                                            child: content,
                                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        )).toList(),
                                        if(widget.expandedTableButtons != null) Padding(
                                            child: Row(
                                                children: [
                                                    ...widget.expandedTableButtons.map<Widget>((button) => Expanded(
                                                        child: Padding(
                                                            child: button,
                                                            padding: EdgeInsets.zero,
                                                        ),
                                                    )).toList(),
                                                ],
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                                        ),
                                    ],
                                ),
                                padding: EdgeInsets.only(bottom: 6.0),
                            ),
                        ],
                    ),
                ),
            ],
        );
        return LunaCard(
            context: context,
            child: InkWell(
                child: child,
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                onTap: controller.toggle,
                onLongPress: widget.onLongPress,
            ),
            color: widget.backgroundColor,
        );
    }
}
