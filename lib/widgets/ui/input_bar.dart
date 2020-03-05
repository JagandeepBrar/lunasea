import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LSTextInputBar extends StatefulWidget {
    final TextEditingController controller;
    final TextInputAction action;
    final String labelText;
    final IconData labelIcon;
    final void Function(String) onChanged;
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
            padding: EdgeInsets.only(right: 16.0),
            child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                    labelText: widget.labelText,
                    labelStyle: TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.none,
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
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
            ),
        ),
    );
}