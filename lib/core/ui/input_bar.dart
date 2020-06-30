import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTextInputBar extends StatefulWidget {
    final TextEditingController controller;
    final TextInputAction action;
    final String labelText;
    final IconData labelIcon;
    final bool autofocus;
    final void Function(String, bool) onChanged;
    final void Function(String) onSubmitted;
    final EdgeInsets margin;

    LSTextInputBar({
        @required this.controller,
        this.onChanged,
        this.onSubmitted,
        this.action = TextInputAction.search,
        this.labelText = 'Search...',
        this.labelIcon = Icons.search,
        this.margin = Constants.UI_CARD_MARGIN,
        this.autofocus = false,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSTextInputBar> {
    @override
    Widget build(BuildContext context) => LSCard(
        margin: widget.margin,
        child: TextField(
            autofocus: widget.autofocus,
            controller: widget.controller,
            decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: TextStyle(
                    color: Colors.white54,
                    decoration: TextDecoration.none,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                suffixIcon: AnimatedOpacity(
                    child: GestureDetector(
                        child: Icon(
                            Icons.close,
                            color: LSColors.accent,
                            size: 24.0,
                        ),
                        onTap: () => widget.onChanged('', true),
                    ),
                    opacity: widget.controller.text == '' ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                ),
                icon: Padding(
                    child: Icon(
                        widget.labelIcon,
                        color: LSColors.accent,
                    ),
                    padding: EdgeInsets.only(left: 16.0),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            style: TextStyle(
                color: Colors.white,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            cursorColor: LSColors.accent,
            textInputAction: widget.action,
            autocorrect: false,
            onChanged: (value) => widget.onChanged(value, false),
            onSubmitted: widget.onSubmitted,
        ),
        color: Theme.of(context).canvasColor,
    );
}