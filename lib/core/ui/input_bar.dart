import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTextInputBar extends StatefulWidget {
    final TextEditingController controller;
    final TextInputAction action;
    final String labelText;
    final IconData labelIcon;
    final void Function(String, bool) onChanged;
    final void Function(String) onSubmitted;

    LSTextInputBar({
        @required this.controller,
        this.onChanged,
        this.onSubmitted,
        this.action = TextInputAction.search,
        this.labelText = 'Search...',
        this.labelIcon = Icons.search,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSTextInputBar> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                    labelText: widget.labelText,
                    labelStyle: TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.none,
                    ),
                    suffixIcon: AnimatedOpacity(
                        child: GestureDetector(
                            child: Icon(
                                Icons.close,
                                color: LSColors.accent,
                                size: 18.0,
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
                        padding: EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 8.0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                style: TextStyle(
                    color: Colors.white,
                ),
                cursorColor: LSColors.accent,
                textInputAction: widget.action,
                autocorrect: false,
                onChanged: (value) => widget.onChanged(value, false),
                onSubmitted: widget.onSubmitted,
            ),
        ),
    );
}