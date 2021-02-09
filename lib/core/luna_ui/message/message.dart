import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaMessage extends StatelessWidget {
    final String text;
    final Color textColor;
    final String buttonText;
    final Function onTap;

    LunaMessage({
        Key key,
        @required this.text,
        this.textColor = Colors.white,
        this.buttonText,
        this.onTap,
    }) {
        assert(text != null);
        if(buttonText != null) assert(onTap != null, 'onTap must be defined if buttonText is defined');
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        elevation: LunaUI().elevation,
                        shape: LunaUI().shapeBorder(),
                        child: Row(
                            children: [
                                Expanded(
                                    child: Container(
                                        child: Text(
                                            text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: textColor,
                                                fontWeight: LunaUI().fontWeightBold,
                                                fontSize: LunaUI().fontSizeMessages,
                                            ),
                                        ),
                                        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                                    ),
                                ),
                            ],
                        ),
                    ),
                    if(buttonText != null) LSButton(text: buttonText, onTap: onTap),
                ],
            ),
        );
    }
}