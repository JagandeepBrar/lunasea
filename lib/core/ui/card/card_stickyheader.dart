import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSCardStickyHeader extends StatelessWidget {
    final String text;
    final Function onTap;
    final Function onLongPress;

    LSCardStickyHeader({
        Key key,
        @required this.text,
        this.onTap,
        this.onLongPress,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => GestureDetector(
        child: LSContainerRow(
            backgroundColor: LSColors.secondary,
            mainAxisAlignment: MainAxisAlignment.center,
            padding: EdgeInsets.zero,
            children: [
                Container(
                    child: Text(
                        text,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                        ),
                    ),
                    height: 63.25,
                    alignment: Alignment.center,
                ),
            ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
    );
}
