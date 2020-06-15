import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/core/ui/colors.dart';

class LSHeader extends StatelessWidget {
    final String text;
    final String subtitle;
    
    LSHeader({
        @required this.text,
        this.subtitle,
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    text.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.UI_FONT_SIZE_HEADER,
                        color: Colors.white,
                    ),
                ),
                Padding(
                    child: Container(
                        height: 2.0,
                        width: 48.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                            color: LSColors.accent,
                        ),
                    ),
                    padding: EdgeInsets.only(
                        top: 4.0,
                        left: 1.0,
                        bottom: subtitle != null
                            ? 6.0
                            : 0.0,
                    ),
                ),
                if(subtitle != null) Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBHEADER,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
    );
}
