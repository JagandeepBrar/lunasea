import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaActionBarCard extends StatelessWidget {
    final String title;
    final String subtitle;
    final Color color;
    final IconData icon;
    final Function onTap;
    final Function onLongPress;
    final bool checkboxState;
    final void Function(bool) checkboxOnChanged;

    LunaActionBarCard({
        Key key,
        @required this.title,
        this.subtitle,
        this.onTap,
        this.onLongPress,
        this.color,
        this.icon,
        this.checkboxState,
        this.checkboxOnChanged,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaCard(
            context: context,
            child: InkWell(
                child: Container(
                    child: Padding(
                        child: Row(
                            children: [
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            LunaText(
                                                text: title,
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontSize: LunaUI.FONT_SIZE_BUTTON,
                                                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                                    color: Colors.white,
                                                ),
                                            ),
                                            if(subtitle != null) LunaText(
                                                text: subtitle,
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontSize: LunaUI.FONT_SIZE_SUBHEADER,
                                                    color: Colors.white70,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                if(checkboxState != null) Container(
                                    width: 30.0,
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                        width: 20.0,
                                        child: Checkbox(
                                            value: checkboxState,
                                            onChanged: checkboxOnChanged,
                                        ),
                                    ),
                                ),
                                if(icon != null) Container(
                                    width: 30.0,
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                        width: 20.0,
                                        child: Icon(
                                            icon,
                                            size: 20.0,
                                        ),
                                    ),
                                ),
                            ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    height: LunaButton.DEFAULT_HEIGHT,
                ),
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                onTap: onTap == null ? null : () async {
                    HapticFeedback.lightImpact();
                    onTap();
                },
                onLongPress: onLongPress == null ? null : () async {
                    HapticFeedback.heavyImpact();
                    onLongPress();
                },
            ),
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            color: color != null
                ? color.withOpacity(0.90)
                : LunaTheme.isAMOLEDTheme ? Colors.black.withOpacity(0.90) : LunaColours.primary.withOpacity(0.90),
        );
    }
}