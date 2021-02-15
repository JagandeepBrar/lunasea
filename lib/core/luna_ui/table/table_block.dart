import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTableCard extends StatelessWidget {
    final List<LunaTableContent> content;
    final List<LunaButton> buttons;

    LunaTableCard({
        Key key,
        @required this.content,
        this.buttons,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Padding(
            child: Column(
                children: [
                    ..._content(),
                    _buttons(),
                ],
            ),
            padding: buttons == null
                ? EdgeInsets.symmetric(vertical: 8.0)
                : EdgeInsets.only(top: 8.0, bottom: 6.0),
        ),
    );

    List<Widget> _content() {
        return content.map<Widget>((content) => Padding(
            child: content,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
        )).toList();
    }

    Widget _buttons() {
        if(buttons == null) return Container(height: 0.0);
        return Padding(
            child: Row(
                children: buttons.map<Widget>((button) => Expanded(child: button)).toList(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }
}
