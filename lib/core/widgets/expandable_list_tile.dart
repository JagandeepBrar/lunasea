import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaExpandableListTile extends StatefulWidget {
  final String title;
  final List<TextSpan> collapsedSubtitles;
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
    @required this.collapsedSubtitles,
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
    assert(collapsedSubtitles != null);
    if (expandedCustomWidget == null) {
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

  List<TextSpan> _parseSubtitles() {
    if (widget.collapsedSubtitles.isEmpty) return [];
    List<TextSpan> _result = [];
    for (int i = 0; i < widget.collapsedSubtitles.length; i++) {
      _result.add(widget.collapsedSubtitles[i]);
      if (i != widget.collapsedSubtitles.length - 1) {
        _result.add(const TextSpan(text: '\n'));
      }
    }
    return _result;
  }

  Widget collapsed() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: widget.title ?? LunaUI.TEXT_EMDASH),
      subtitle: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: Colors.white70,
          ),
          children: _parseSubtitles(),
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: widget.collapsedSubtitles.length,
      ),
      onTap: controller.toggle,
      onLongPress: widget.onLongPress,
      contentPadding: widget.collapsedSubtitles.length > 1,
      trailing: widget.collapsedTrailing,
      leading: widget.collapsedLeading,
      color: widget.backgroundColor,
    );
  }

  Widget expanded() {
    Widget child = widget.expandedCustomWidget ??
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: LunaText.title(
                      text: widget.title ?? LunaUI.TEXT_EMDASH,
                      softWrap: true,
                      maxLines: 8,
                    ),
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 12.0, right: 12.0, top: 10.0),
                  ),
                  if (widget.expandedHighlightedNodes != null)
                    Padding(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: widget.expandedHighlightedNodes,
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 12.0, right: 12.0, top: 0.0),
                    ),
                  Padding(
                    child: Column(
                      children: [
                        ...widget.expandedTableContent
                            .map<Widget>((content) => Padding(
                                  child: content,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                ))
                            .toList(),
                        if (widget.expandedTableButtons != null)
                          Padding(
                            child: Wrap(
                              children: [
                                ...List.generate(
                                    widget.expandedTableButtons.length,
                                    (index) {
                                  double widthFactor = 0.5;
                                  if (index ==
                                          (widget.expandedTableButtons.length -
                                              1) &&
                                      widget.expandedTableButtons.length.isOdd)
                                    widthFactor = 1;
                                  return FractionallySizedBox(
                                    child: widget.expandedTableButtons[index],
                                    widthFactor: widthFactor,
                                  );
                                }),
                              ],
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                          ),
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 6.0),
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
